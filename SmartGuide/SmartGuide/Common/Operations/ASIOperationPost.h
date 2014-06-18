//
//  ASIOperationPost.h
//  SmartGuide
//
//  Created by XXX on 7/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "AFHTTPRequestOperation.h"
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

#define REFRESH_TOKEN_ERROR_CODE 1000

@class ASIOperationPost;

@protocol ASIOperationPostDelegate <NSObject>

-(void) ASIOperaionPostFinished:(ASIOperationPost*) operation;
-(void) ASIOperaionPostFailed:(ASIOperationPost*) operation;

@end

@interface ASIOperationPost : AFHTTPRequestOperation

-(ASIOperationPost*) initWithURL:(NSURL*) url;
-(ASIOperationPost*) initWithRouter:(NSURL*) url;

-(void) onCompletedWithJSON:(NSArray*) json;
-(void) onFailed:(NSError *)error;
-(void) notifyCompleted;
-(void) notifyFailed:(NSError*) error;
-(void) restart;

-(void) addToQueue;
-(void) clearDelegatesAndCancel;

-(void) addImage:(NSData*) binary withKey:(NSString*) key;

@property (nonatomic, weak) id<ASIOperationPostDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *keyValue;
//@property (nonatomic, strong) NSString *operationAccessToken;
@property (nonatomic, strong) NSURL *sourceURL;
@property (nonatomic, strong) NSString *tScreen;
@property (nonatomic, strong) NSMutableDictionary *tData;
@property (nonatomic, strong) NSString *fScreen;
@property (nonatomic, strong) NSMutableDictionary *fData;
@property (nonatomic, strong) NSFetchedResultsController *fetchedController;
@property (nonatomic, strong) NSMutableDictionary *imagesData;

@end

@interface ASIOperationManager : AFHTTPRequestOperationManager

+(ASIOperationManager*) shareInstance;
-(NSMutableURLRequest*) createPOST:(NSString*) urlString parameters:(NSDictionary*) parameters;
-(NSMutableURLRequest*) createGET:(NSString*) urlString parameters:(NSDictionary*) parameters;

-(void) addOperation:(ASIOperationPost*) operation;

-(void) clearAllOperation;

@end