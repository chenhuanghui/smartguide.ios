// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Shop.h instead.

#import <CoreData/CoreData.h>

#define Shop_ClassName @"Shop"

#define Shop_Address @"address"
#define Shop_Contact @"contact"
#define Shop_Cover @"cover"
#define Shop_Desc @"desc"
#define Shop_Dislike @"dislike"
#define Shop_Distance @"distance"
#define Shop_Gallery @"gallery"
#define Shop_IdGroup @"idGroup"
#define Shop_IdShop @"idShop"
#define Shop_IsNeedReloadData @"isNeedReloadData"
#define Shop_Like @"like"
#define Shop_Like_status @"like_status"
#define Shop_Logo @"logo"
#define Shop_Love @"love"
#define Shop_Name @"name"
#define Shop_NumGetPromotion @"numGetPromotion"
#define Shop_NumGetReward @"numGetReward"
#define Shop_NumOfDislike @"numOfDislike"
#define Shop_NumOfLike @"numOfLike"
#define Shop_NumOfVisit @"numOfVisit"
#define Shop_PromotionStatus @"promotionStatus"
#define Shop_Shop_lat @"shop_lat"
#define Shop_Shop_lng @"shop_lng"
#define Shop_Updated_at @"updated_at"
#define Shop_Website @"website"

@class Shop;
@class ShopProduct;
@class PromotionDetail;
@class ShopGallery;
@class ShopUserComment;
@class ShopUserGallery;

@interface _Shop : NSManagedObject

+(Shop*) insert;
+(Shop*) temporary;
+(NSArray*) queryShop:(NSPredicate*) predicate;
+(Shop*) queryShopObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* contact;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* dislike;
@property (nonatomic, retain) NSNumber* distance;
@property (nonatomic, retain) NSString* gallery;
@property (nonatomic, retain) NSNumber* idGroup;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSNumber* isNeedReloadData;
@property (nonatomic, retain) NSNumber* like;
@property (nonatomic, retain) NSNumber* like_status;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* love;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSNumber* numGetPromotion;
@property (nonatomic, retain) NSNumber* numGetReward;
@property (nonatomic, retain) NSNumber* numOfDislike;
@property (nonatomic, retain) NSNumber* numOfLike;
@property (nonatomic, retain) NSNumber* numOfVisit;
@property (nonatomic, retain) NSNumber* promotionStatus;
@property (nonatomic, retain) NSNumber* shop_lat;
@property (nonatomic, retain) NSNumber* shop_lng;
@property (nonatomic, retain) NSString* updated_at;
@property (nonatomic, retain) NSString* website;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Products
- (NSSet*) products;
- (NSArray*) productsObjects;
- (void) addProducts:(NSSet*)value;
- (void) removeProducts:(NSSet*)value;
- (void) addProductsObject:(ShopProduct*)value;
- (void) removeProductsObject:(ShopProduct*)value;

#pragma mark PromotionDetail
@property (nonatomic, retain) PromotionDetail* promotionDetail;

#pragma mark ShopGallery
- (NSSet*) shopGallery;
- (NSArray*) shopGalleryObjects;
- (void) addShopGallery:(NSSet*)value;
- (void) removeShopGallery:(NSSet*)value;
- (void) addShopGalleryObject:(ShopGallery*)value;
- (void) removeShopGalleryObject:(ShopGallery*)value;

#pragma mark ShopUserComments
- (NSSet*) shopUserComments;
- (NSArray*) shopUserCommentsObjects;
- (void) addShopUserComments:(NSSet*)value;
- (void) removeShopUserComments:(NSSet*)value;
- (void) addShopUserCommentsObject:(ShopUserComment*)value;
- (void) removeShopUserCommentsObject:(ShopUserComment*)value;

#pragma mark UserGallery
- (NSSet*) userGallery;
- (NSArray*) userGalleryObjects;
- (void) addUserGallery:(NSSet*)value;
- (void) removeUserGallery:(NSSet*)value;
- (void) addUserGalleryObject:(ShopUserGallery*)value;
- (void) removeUserGalleryObject:(ShopUserGallery*)value;


@end