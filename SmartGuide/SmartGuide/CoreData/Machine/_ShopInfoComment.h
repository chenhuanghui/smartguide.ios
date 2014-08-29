// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfoComment.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ShopInfoComment_ClassName @"ShopInfoComment"

#define ShopInfoComment_AgreeStatus @"agreeStatus"
#define ShopInfoComment_Avatar @"avatar"
#define ShopInfoComment_Comment @"comment"
#define ShopInfoComment_IdComment @"idComment"
#define ShopInfoComment_NumOfAgree @"numOfAgree"
#define ShopInfoComment_Time @"time"
#define ShopInfoComment_TotalAgree @"totalAgree"
#define ShopInfoComment_Username @"username"

@class ShopInfoComment;
@class ShopInfo;

@interface _ShopInfoComment : NSManagedObject

+(ShopInfoComment*) insert;
+(ShopInfoComment*) temporary;
+(NSArray*) queryShopInfoComment:(NSPredicate*) predicate;
+(ShopInfoComment*) queryShopInfoCommentObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* agreeStatus;
@property (nonatomic, retain) NSString* avatar;
@property (nonatomic, retain) NSString* comment;
@property (nonatomic, retain) NSNumber* idComment;
@property (nonatomic, retain) NSString* numOfAgree;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSNumber* totalAgree;
@property (nonatomic, retain) NSString* username;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) ShopInfo* shop;



#pragma mark Utility

-(void) revert;

@end