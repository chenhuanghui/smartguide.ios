// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopUserComment.h instead.

#import <CoreData/CoreData.h>

#define ShopUserComment_ClassName @"ShopUserComment"

#define ShopUserComment_Avatar @"avatar"
#define ShopUserComment_Comment @"comment"
#define ShopUserComment_Fulltime @"fulltime"
#define ShopUserComment_IdShop @"idShop"
#define ShopUserComment_Time @"time"
#define ShopUserComment_User @"user"

@class ShopUserComment;
@class Shop;

@interface _ShopUserComment : NSManagedObject

+(ShopUserComment*) insert;
+(ShopUserComment*) temporary;
+(NSArray*) queryShopUserComment:(NSPredicate*) predicate;
+(ShopUserComment*) queryShopUserCommentObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSString* avatar;
@property (nonatomic, retain) NSString* comment;
@property (nonatomic, retain) NSString* fulltime;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* user;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end