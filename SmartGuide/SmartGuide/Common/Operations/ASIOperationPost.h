//
//  ASIOperationPost.h
//  SmartGuide
//
//  Created by XXX on 7/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIFormDataRequest.h"
#import "Constant.h"
#import "Utility.h"
#import "DataManager.h"
#import "AFNetworking.h"

@class ASIOperationPost;

@protocol ASIOperationPostDelegate <NSObject>

-(void) ASIOperaionPostFinished:(ASIOperationPost*) operation;
-(void) ASIOperaionPostFailed:(ASIOperationPost*) operation;

@end

@interface ASIOperationPost : ASIFormDataRequest<ASIHTTPRequestDelegate>

-(ASIOperationPost*) initWithURL:(NSURL*) url;
-(ASIOperationPost*) initWithRouter:(NSURL*) url;

-(void) onCompletedWithJSON:(NSArray*) json;
-(void) onFailed:(NSError *)error;
-(void) notifyCompleted;
-(void) notifyFailed:(NSError*) error;
-(bool) isNullData:(NSArray*) data;
-(void) restart;

@property (nonatomic, weak) id<ASIOperationPostDelegate> delegatePost;
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) NSDictionary *keyValue;
@property (nonatomic, strong) NSString *operationAccessToken;
@property (nonatomic, strong) NSURL *sourceURL;

@end