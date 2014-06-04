//
//  AFOperation.m
//  Infory
//
//  Created by XXX on 6/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "AFOperation.h"
#import "TokenManager.h"

NSString *makeURLWithAccessToken(NSString* urlString)
{
    NSString *accessToken=[NSString stringWithString:[TokenManager shareInstance].accessToken];
    
    return [[NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",urlString,accessToken]] absoluteString];
}

NSString* afOperationMethodDescription(enum AFOPEARTION_METHOD_TYPE type)
{
    switch (type) {
        case AFOPEARTION_METHOD_TYPE_GET:
            return @"GET";
            
        case AFOPEARTION_METHOD_TYPE_POST:
            return @"POST";
    }
}

@implementation AFOperation

-(AFOperation *)initWithMethod:(enum AFOPEARTION_METHOD_TYPE)method url:(NSString *)urlString parameters:(NSDictionary *)parameters delegate:(id<AFOperationDelegate>)delegate
{
    NSString *url=makeURLWithAccessToken(urlString);
    
    NSMutableURLRequest *mutableRequest=[[AFOperationManager shareInstance].requestSerializer requestWithMethod:afOperationMethodDescription(method) URLString:url parameters:parameters error:nil];
    
    self=[super initWithRequest:mutableRequest];
    self.delegate=delegate;
    
    return self;
}

-(void)addToDefaultQueue
{
    self.responseSerializer = [AFOperationManager shareInstance].responseSerializer;
    self.shouldUseCredentialStorage = [AFOperationManager shareInstance].shouldUseCredentialStorage;
    self.credential = [AFOperationManager shareInstance].credential;
    self.securityPolicy = [AFOperationManager shareInstance].securityPolicy;
    
    [[AFOperationManager shareInstance].operationQueue addOperation:self];
}

-(void)addToQueue:(AFHTTPRequestOperationManager *)operationManager
{
    self.responseSerializer = operationManager.responseSerializer;
    self.shouldUseCredentialStorage = operationManager.shouldUseCredentialStorage;
    self.credential = operationManager.credential;
    self.securityPolicy = operationManager.securityPolicy;
    
    [operationManager.operationQueue addOperation:self];
}

-(void)start
{
    [self setCompletionBlockWithSuccess:nil failure:nil];
    
    __weak AFOperation *wSelf=self;
    [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         if(wSelf)
             [wSelf operationFinished];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         if(wSelf)
             [wSelf operationFailed];
         
     }];
    
#if BUILD_MODE==0
    NSLog(@"%@ start %@ %@ params %@",CLASS_NAME,self.request.HTTPMethod,self.request.URL,[[NSString alloc] initWithData:self.request.HTTPBody encoding:NSUTF8StringEncoding]);
#endif
    
    [super start];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    
}

-(void) operationFinished
{
    NSLog(@"%@ finished %@ statusCode %i", CLASS_NAME, self.request.URL, self.response.statusCode);
    [self.delegate AFOperationFinished:self];
}


-(void) operationFailed
{
    NSLog(@"%@ failed %@ statusCode %i", CLASS_NAME, self.request.URL, self.response.statusCode);
    [self.delegate AFOperationFailed:self];
}

CALL_DEALLOC_LOG

@end

static AFOperationManager *_afOperationManager = nil;
@implementation AFOperationManager

+(AFOperationManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _afOperationManager=[AFOperationManager manager];
    });
    
    return _afOperationManager;
}

-(AFOperation *)afHTTPRequestOperationWithRequest:(NSURLRequest *)request delegate:(id<AFOperationDelegate>)delegate
{
    AFOperation *operation = [[AFOperation alloc] initWithRequest:request];
    operation.responseSerializer = self.responseSerializer;
    operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
    operation.credential = self.credential;
    operation.securityPolicy = self.securityPolicy;
    
    return operation;
}

-(AFOperation *)afGET:(NSString *)URLString parameters:(NSDictionary*)parameters delegate:(id<AFOperationDelegate>)delegate
{
    NSString *url=makeURLWithAccessToken(URLString);
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
    AFOperation *operation = [self afHTTPRequestOperationWithRequest:request delegate:delegate];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

-(AFOperation *)afPOST:(NSString *)URLString parameters:(NSDictionary*)parameters delegate:(id<AFOperationDelegate>)delegate
{
    NSString *url=makeURLWithAccessToken(URLString);
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
    AFOperation *operation = [self afHTTPRequestOperationWithRequest:request delegate:delegate];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

-(AFOperation *)requestWithMethod:(NSString *)method url:(NSString *)url parameters:(NSDictionary*)parameters delegate:(id<AFOperationDelegate>)delegate
{
    if([method isEqualToString:@"POST"])
        return [self afPOST:url parameters:parameters delegate:delegate];
    else if([method isEqualToString:@"GET"])
        return [self afGET:url parameters:parameters delegate:delegate];
    
    return nil;
}

-(AFOperation *)afPOST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block delegate:(id<AFOperationDelegate>)delegate
{
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    AFOperation *operation = [self afHTTPRequestOperationWithRequest:request delegate:delegate];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end