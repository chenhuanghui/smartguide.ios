//
//  ASIOperationPost.m
//  SmartGuide
//
//  Created by XXX on 7/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "OperationRefreshToken.h"
#import "TokenManager.h"

@interface ASIOperationPost()
{
    NSURL *_sourceURL;
}

@end

@implementation ASIOperationPost
@synthesize delegatePost,values,keys;

-(ASIOperationPost *)initWithURL:(NSURL *)_url
{
    NSString *accessToken=[NSString stringWithString:[TokenManager shareInstance].accessToken];
    _sourceURL=[_url copy];
    _url=[ASIOperationPost makeURL:_url accessToken:accessToken];
    self=[super initWithURL:_url];

    self.numberOfTimesToRetryOnTimeout=3;
    self.shouldContinueWhenAppEntersBackground=true;
    self.persistentConnectionTimeoutSeconds=60*5;
    self.responseEncoding=NSUTF8StringEncoding;
    [self setValidatesSecureCertificate:false];

    self.delegate=self;
    
    return self;
}

+(NSURL*) makeURL:(NSURL*) sourceURL accessToken:(NSString*) accessToken
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",sourceURL,accessToken]];
}

-(void)startAsynchronous
{
    [self applyPostValue];
    
    NSLog(@"%@ start async %@ %@ %@",CLASS_NAME,self.url,self.keys,self.values);
    
    [super startAsynchronous];
}

-(void)startSynchronous
{
    [self applyPostValue];
    
    NSLog(@"%@ start sync %@ %@ %@",CLASS_NAME,self.url,self.keys,self.values);
    
    [super startSynchronous];
}

-(void) applyPostValue
{
    NSArray *arrKeys=[self keys];
    NSArray *arrValues=[self values];
    for(int i=0;i<arrKeys.count;i++)
    {
        NSString *key = [arrKeys objectAtIndex:i];
        id obj = [arrValues objectAtIndex:i];
        
        [self setPostValue:obj forKey:key];
    }
}

-(void) notifyFailed:(NSError*) errorr
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.error=error;
    NSLog(@"%@ failed %@",CLASS_NAME,self.responseStatusMessage?self.responseStatusMessage:self.error);
    
    if([self isRespondsToSelector:@selector(ASIOperaionPostFailed:)])
        [delegatePost ASIOperaionPostFailed:self];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if(self.responseString.length>0)
    {
        NSData *data=[self.responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *jsonError=nil;
        
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&jsonError];
        
        if(jsonError)
        {
            [self onFailed:jsonError];
            [self notifyFailed:jsonError];
        }
        else
        {
            if([json isKindOfClass:[NSArray class]])
            {
                NSMutableArray *jsonArray=json;
                
                if(jsonArray.count==0 || [jsonArray objectAtIndex:0] == [NSNull null])
                    [self onCompletedWithJSON:[NSArray array]];
                else
                    [self onCompletedWithJSON:jsonArray];
                
                [self notifyCompleted];
            }
            else if([json isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *jsonDict=json;
                
                if(jsonDict.count==0)
                    [self onCompletedWithJSON:[NSArray array]];
                else
                    [self onCompletedWithJSON:[NSArray arrayWithObject:jsonDict]];
                
                [self notifyCompleted];
            }
            else if(json==[NSNull null])
            {
                @try {
                    [self onCompletedWithJSON:@[[NSNull null]]];
                }
                @catch (NSException *exception) {
                    NSLog(@"%@ process null error %@",CLASS_NAME,exception);
                }
                @finally {
                    [self notifyCompleted];
                }
            }
            else if([json isKindOfClass:[NSNumber class]])
            {
                @try {
                    [self onCompletedWithJSON:@[json]];
                }
                @catch (NSException *exception) {
                    NSLog(@"%@ process number error %@",CLASS_NAME,exception);
                }
                @finally {
                    [self notifyCompleted];
                }
            }
            else
            {
                NSLog(@"%@ unknow json class %@",CLASS_NAME,NSStringFromClass([json class]));
                
                [self notifyCompleted];
            }
        }
    }
    else
        [self notifyCompleted];
}

-(void)notifyCompleted
{
    NSLog(@"%@ finished %i",CLASS_NAME,self.responseString.length);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];    
    
    if([self isRespondsToSelector:@selector(ASIOperaionPostFinished:)])
        [delegatePost ASIOperaionPostFinished:self];
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    if(self.responseString.length>0)
    {
        NSData *data=[self.responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *jsonError=nil;
        NSArray *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&jsonError];
        
        if(!jsonError && [json isKindOfClass:[NSDictionary class]] && json.count>0)
        {
            NSString *key=[json valueForKey:@"error"];
            if(key.length>0)
            {
                if([key isEqualToString:@"invalid_grant"])
                {
                    if(![TokenManager shareInstance].isRefreshingToken)
                    {
                        [[TokenManager shareInstance] refreshToken];
                    }
                    
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTokenSuccess:) name:NOTIFICATION_REFRESH_TOKEN_SUCCESS object:nil];
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTokenFailed:) name:NOTIFICATION_REFRESH_TOKEN_FAILED object:nil];
                    
                    return;
                }
            }
        }
        
        self.error=jsonError;
    }
    [self onFailed:self.error];
    [self notifyFailed:self.error];
}

-(void) refreshTokenFailed:(NSNotification*) notification
{
    self.error=[NSError errorWithDomain:@"Refresh token failed" code:0 userInfo:nil];
    [self onFailed:self.error];
    [self notifyFailed:self.error];
}

-(void) refreshTokenSuccess:(NSNotification*) notification
{
    NSString *accessToken=[NSString stringWithString:[TokenManager shareInstance].accessToken];
    
    NSURL *_url=[ASIOperationPost makeURL:_sourceURL accessToken:accessToken];
    
    id ope=[[NSClassFromString(NSStringFromClass([self class])) alloc] initWithURL:_url];
    
    [ope setValues:self.values];
    [ope setKeys:self.keys];
    
    [ope setDelegatePost:self.delegatePost];
    
    [ope startAsynchronous];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    
}

-(void)onFailed:(NSError *)error
{
    
}

-(BOOL) isRespondsToSelector:(SEL)aSelector
{
    return delegatePost && [delegatePost respondsToSelector:aSelector];
}

-(NSArray *)keys
{
    return [NSArray array];
}

-(NSArray *)values
{
    return [NSArray array];
}

-(bool)isNullData:(NSArray *)data
{
    if((id)data==[NSNull null] ||  data.count==0 || [data objectAtIndex:0]==[NSNull null])
        return true;
    
    return false;
}

-(void)cancel
{
    self.delegatePost=nil;
    [super cancel];
}

// If a delegate implements one of these, it will be asked to supply credentials when none are available
// The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
// or cancel it ([request cancelAuthentication])
//- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request;
//- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request;

@end
