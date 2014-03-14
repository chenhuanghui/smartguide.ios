//
//  OperationQueue.m
//  SmartGuide
//
//  Created by XXX on 7/18/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationURL()

-(void) onCompleted:(AFHTTPRequestOperation*) operation responseObject:(id) responseObject;
-(void) onFailure:(AFHTTPRequestOperation*) operation error:(NSError*) error;

@end

@implementation OperationURL
@synthesize delegate,params,router;


-(OperationURL *)initWithRouter:(NSString *)_router params:(NSDictionary *)dict
{
    NSString *url=_router;
    
    if(dict.count>0)
        url=[url stringByAppendingFormat:@"?%@",[dict makeParamsHTTPGET]];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    self=[super initWithRequest:request];
    
    params=[dict copy];
    router=[_router copy];
    
    __weak id weakSelf=self;
    [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [weakSelf onCompleted:operation responseObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf onFailure:operation error:error];
    }];
    
    return self;
}

-(void)start
{
    NSLog(@"%@ request %@",NSStringFromClass([self class]),self.request.URL);
    
    [super start];
}

-(bool)canManualHandleData:(id)responseObject
{
    return false;
}

-(void) onCompleted:(AFHTTPRequestOperation*) operation responseObject:(id) responseObject
{
    NSLog(@"%@ completed %@",NSStringFromClass([self class]),self.request.URL);
    
    if([self canManualHandleData:responseObject])
    {
        [self onCompletedWithJSON:@[responseObject]];
        
        if(self.error)
            [self notifyFailed:self.error];
        else
            [self notifyCompleted];
        return;
    }
    
    if(!responseObject)
    {
        [self onFailure:self error:nil];
        return;
    }
    
    NSError *error=nil;
    id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
    
    if(error)
        [self onFailure:self error:error];
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
        else
        {
            NSLog(@"%@ unknow json class %@",CLASS_NAME,NSStringFromClass([json class]));
            
            [self notifyCompleted];
        }
    }
}

-(void)notifyCompleted
{
    if([self isRespondsSelector:@selector(operationURLFinished:)])
        [delegate operationURLFinished:self];
    
    self.delegate=nil;
}

-(void)notifyFailed:(NSError *)_error
{
    NSLog(@"%@ error %@",NSStringFromClass([self class]),_error);
    
    if([self isRespondsSelector:@selector(operationURLFailed:)])
        [delegate operationURLFailed:self];
    
    self.delegate=nil;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}

-(void) onFailure:(AFHTTPRequestOperation*) operation error:(NSError*) _error
{
    [self notifyFailed:_error];
}

-(bool) isRespondsSelector:(SEL) selector
{
    return delegate && [delegate respondsToSelector:selector];
}

-(bool)isNullData:(NSArray *)data
{
    if((id)data==[NSNull null] ||  data.count==0 || [data objectAtIndex:0]==[NSNull null])
        return true;
    return false;
}

CALL_DEALLOC_LOG

@end
