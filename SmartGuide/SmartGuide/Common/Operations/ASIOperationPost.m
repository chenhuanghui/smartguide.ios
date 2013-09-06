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

static NSMutableArray *asioperations=nil;

@interface ASIOperationPost()
{
}

@end

@implementation ASIOperationPost
@synthesize delegatePost,values,keys,operationAccessToken,sourceURL;

-(ASIOperationPost *)initWithURL:(NSURL *)_url
{
    NSURL *urlCopy=[_url copy];
    NSString *accessToken=[NSString stringWithString:[TokenManager shareInstance].accessToken];
    _url=[ASIOperationPost makeURL:_url accessToken:accessToken];
    self=[super initWithURL:_url];

    self.values=[NSArray array];
    self.keys=[NSArray array];
    
    self.numberOfTimesToRetryOnTimeout=3;
    self.shouldContinueWhenAppEntersBackground=true;
    self.persistentConnectionTimeoutSeconds=60*5;
    self.responseEncoding=NSUTF8StringEncoding;
    [self setValidatesSecureCertificate:true];
    
    self.sourceURL=urlCopy;
    
    self.operationAccessToken=[[NSString alloc] initWithString:accessToken];
    
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

-(bool) handleTokenError:(NSDictionary*) json
{
    if(json.count>0)
    {
        NSString *key=[NSString stringWithStringDefault:[json valueForKey:@"error"]];
        if(key.length>0)
        {
            if([key isEqualToString:@"invalid_grant"])
            {
                NSLog(@"handleToken %@ %@ %@",CLASS_NAME,self.operationAccessToken,[TokenManager shareInstance].accessToken);

                if(![TokenManager shareInstance].isRefreshingToken)
                {
                    //Token có thể đã được refresh bởi 1 operation khác, nếu token operation (bị lỗi) trùng với token hiện tại->refresh token
                    if([self.operationAccessToken isEqualToString:[TokenManager shareInstance].accessToken])
                        [[TokenManager shareInstance] refreshToken];
                    else
                    {
                        //Token đã được refresh bởi operation khác và token hiện tại của operation khác với token app->restart để apply token mới
                        [self restart];
                        return true;
                    }
                }
                
                if(!asioperations)
                {
                    asioperations=[[NSMutableArray alloc] init];
                }
                
                [asioperations addObject:self];
                
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTokenSuccess:) name:NOTIFICATION_REFRESH_TOKEN_SUCCESS object:nil];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTokenFailed:) name:NOTIFICATION_REFRESH_TOKEN_FAILED object:nil];
                
                return true;
            }
        }
    }
    
    return false;
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%@ requestFinished %@",CLASS_NAME,self.responseStatusMessage);
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
                
                if([self handleTokenError:jsonDict])
                    return;
                
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
    NSLog(@"%@ requestFailed %@",CLASS_NAME,self.responseStatusMessage);
    
    if(self.responseString.length>0)
    {
        NSData *data=[self.responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *jsonError=nil;
        NSArray *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&jsonError];
        
        if(!jsonError && [json isKindOfClass:[NSDictionary class]] && json.count>0)
        {
            if([self handleTokenError:(NSDictionary*)json])
                return;
        }
        
        self.error=jsonError;
    }
    [self onFailed:self.error];
    [self notifyFailed:self.error];
}

-(void) refreshTokenFailed:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.error=[NSError errorWithDomain:@"Refresh token failed" code:0 userInfo:nil];
    [self onFailed:self.error];
    [self notifyFailed:self.error];
}

-(void) refreshTokenSuccess:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self restart];
}

-(void)restart
{
    ASIOperationPost *ope=[self copy];
 
    ope.sourceURL=[self.sourceURL copy];
    
    NSString *accessToken=[NSString stringWithString:[TokenManager shareInstance].accessToken];
    ope.operationAccessToken=[accessToken copy];
    ope.url=[ASIOperationPost makeURL:ope.sourceURL accessToken:accessToken];
    
    ope.delegate=ope;
    ope.delegatePost=self.delegatePost;
    self.delegatePost=nil;
    
    NSLog(@"%@ restart %@ %@ %@",NSStringFromClass([ope class]),ope.url,ope.keys,ope.values);
    [ope startAsynchronous];
    
    [asioperations removeObject:self];
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

-(bool)isNullData:(NSArray *)data
{
    if((id)data==[NSNull null] ||  data.count==0 || [data objectAtIndex:0]==[NSNull null])
        return true;
    
    return false;
}

-(void)cancel
{
    self.delegatePost=nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];    
    
    [super cancel];
}

// If a delegate implements one of these, it will be asked to supply credentials when none are available
// The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
// or cancel it ([request cancelAuthentication])
//- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request;
//- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request;

-(id)copyWithZone:(NSZone *)zone
{
    ASIOperationPost *ope=[super copyWithZone:zone];
    
    [ope setValues:self.values];
    [ope setKeys:self.keys];
    
    return ope;
}

@end
