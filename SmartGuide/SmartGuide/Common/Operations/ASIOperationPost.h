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
#import "Flags.h"

#define USER_LATITUDE @"userLat"
#define USER_LONGITUDE @"userLng"
#define PAGE @"page"
#define SORT @"sort"
#define IDSHOP @"idShop"
#define IDSTORE @"idStore"
#define IDPLACELIST @"idPlacelist"
#define DESCRIPTION @"description"
#define STATUS @"status"
#define MESSAGE @"message"

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
@property (nonatomic, strong) NSMutableDictionary *keyValue;
@property (nonatomic, strong) NSString *operationAccessToken;
@property (nonatomic, strong) NSURL *sourceURL;
@property (nonatomic, strong) NSString *tScreen;
@property (nonatomic, strong) NSMutableDictionary *tData;
@property (nonatomic, strong) NSString *fScreen;
@property (nonatomic, strong) NSMutableDictionary *fData;
@property (nonatomic, strong) NSFetchedResultsController *fetchedController;

@end

@interface ASIOperationPost(MakeTest)

+(void) makeTest;

@end