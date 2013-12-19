// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Shop.h instead.

#import <CoreData/CoreData.h>

#define Shop_ClassName @"Shop"

#define Shop_Address @"address"
#define Shop_City @"city"
#define Shop_Desc @"desc"
#define Shop_DisplayTel @"displayTel"
#define Shop_IdShop @"idShop"
#define Shop_Logo @"logo"
#define Shop_LoveStatus @"loveStatus"
#define Shop_NumOfComment @"numOfComment"
#define Shop_NumOfLove @"numOfLove"
#define Shop_NumOfView @"numOfView"
#define Shop_PromotionType @"promotionType"
#define Shop_ShopLat @"shopLat"
#define Shop_ShopLng @"shopLng"
#define Shop_ShopName @"shopName"
#define Shop_ShopType @"shopType"
#define Shop_Tel @"tel"

@class Shop;
@class ShopDetailInfo;
@class ShopKM1;
@class ShopGallery;
@class ShopUserComment;
@class ShopUserGallery;

@interface _Shop : NSManagedObject

+(Shop*) insert;
+(Shop*) temporary;
+(NSArray*) queryShop:(NSPredicate*) predicate;
+(Shop*) queryShopObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSString* displayTel;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* loveStatus;
@property (nonatomic, retain) NSString* numOfComment;
@property (nonatomic, retain) NSString* numOfLove;
@property (nonatomic, retain) NSString* numOfView;
@property (nonatomic, retain) NSNumber* promotionType;
@property (nonatomic, retain) NSNumber* shopLat;
@property (nonatomic, retain) NSNumber* shopLng;
@property (nonatomic, retain) NSString* shopName;
@property (nonatomic, retain) NSString* shopType;
@property (nonatomic, retain) NSString* tel;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark DetailInfo
- (NSSet*) detailInfo;
- (NSArray*) detailInfoObjects;
- (void) addDetailInfo:(NSSet*)value;
- (void) removeDetailInfo:(NSSet*)value;
- (void) addDetailInfoObject:(ShopDetailInfo*)value;
- (void) removeDetailInfoObject:(ShopDetailInfo*)value;
- (void) removeAllDetailInfo;

#pragma mark Km1
@property (nonatomic, retain) ShopKM1* km1;

#pragma mark ShopGalleries
- (NSSet*) shopGalleries;
- (NSArray*) shopGalleriesObjects;
- (void) addShopGalleries:(NSSet*)value;
- (void) removeShopGalleries:(NSSet*)value;
- (void) addShopGalleriesObject:(ShopGallery*)value;
- (void) removeShopGalleriesObject:(ShopGallery*)value;
- (void) removeAllShopGalleries;

#pragma mark UserComments
- (NSSet*) userComments;
- (NSArray*) userCommentsObjects;
- (void) addUserComments:(NSSet*)value;
- (void) removeUserComments:(NSSet*)value;
- (void) addUserCommentsObject:(ShopUserComment*)value;
- (void) removeUserCommentsObject:(ShopUserComment*)value;
- (void) removeAllUserComments;

#pragma mark UserGalleries
- (NSSet*) userGalleries;
- (NSArray*) userGalleriesObjects;
- (void) addUserGalleries:(NSSet*)value;
- (void) removeUserGalleries:(NSSet*)value;
- (void) addUserGalleriesObject:(ShopUserGallery*)value;
- (void) removeUserGalleriesObject:(ShopUserGallery*)value;
- (void) removeAllUserGalleries;


@end