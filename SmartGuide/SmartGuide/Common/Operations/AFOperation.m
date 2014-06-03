//
//  AFOperation.m
//  Infory
//
//  Created by XXX on 6/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "AFOperation.h"

@implementation AFOperation

-(void)start
{
    [self setCompletionBlockWithSuccess:nil failure:nil];

    if(self.delegate)
    {
        __strong __block AFOperation *sSelf=self;
        [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             [sSelf.delegate AFOperationFinished:sSelf];
             
             NSLog(@"%@ finished %@",NSStringFromClass([sSelf class]),sSelf.request.URL);
             
             sSelf=nil;
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [sSelf.delegate AFOperationFailed:sSelf];
             
             NSLog(@"%@ failed %@",NSStringFromClass([sSelf class]),sSelf.request.URL);
             
             sSelf=nil;
         }];
    }
    
    NSLog(@"%@ start %@ %@",CLASS_NAME,self.request.HTTPMethod,self.request,self.request.URL);
    
    [super start];
}

CALL_DEALLOC_LOG

@end

@implementation AFHTTPRequestOperationManager(AFOperation)

-(AFOperation *)afHTTPRequestOperationWithRequest:(NSURLRequest *)request delegate:(id<AFOperationDelegate>)delegate
{
    AFOperation *operation = [[AFOperation alloc] initWithRequest:request];
    operation.responseSerializer = self.responseSerializer;
    operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
    operation.credential = self.credential;
    operation.securityPolicy = self.securityPolicy;
    
    return operation;
}

-(AFOperation *)afGET:(NSString *)URLString parameters:(id)parameters delegate:(id<AFOperationDelegate>)delegate
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFOperation *operation = [self afHTTPRequestOperationWithRequest:request delegate:delegate];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

-(AFOperation *)afPOST:(NSString *)URLString parameters:(id)parameters delegate:(id<AFOperationDelegate>)delegate
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFOperation *operation = [self afHTTPRequestOperationWithRequest:request delegate:delegate];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

-(AFOperation *)requestWithMethod:(NSString *)method url:(NSString *)url parameters:(id)parameters delegate:(id<AFOperationDelegate>)delegate
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