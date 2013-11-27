// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopUserComment.h instead.

#import <CoreData/CoreData.h>

#define ShopUserComment_ClassName @"ShopUserComment"

#define ShopUserComment_Avatar @"avatar"
#define ShopUserComment_Comment @"comment"
#define ShopUserComment_IdComment @"idComment"
#define ShopUserComment_ShopName @"shopName"
#define ShopUserComment_SortOrder @"sortOrder"
#define ShopUserComment_Time @"time"
#define ShopUserComment_Username @"username"

@class ShopUserComment;
@class Shop;

@interface _ShopUserComment : NSManagedObject

+(ShopUserComment*) insert;
+(ShopUserComment*) temporary;
+(NSArray*) queryShopUserComment:(NSPredicate*) predicate;
+(ShopUserComment*) queryShopUserCommentObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* avatar;
@property (nonatomic, retain) NSString* comment;
@property (nonatomic, retain) NSNumber* idComment;
@property (nonatomic, retain) NSString* shopName;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* username;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end