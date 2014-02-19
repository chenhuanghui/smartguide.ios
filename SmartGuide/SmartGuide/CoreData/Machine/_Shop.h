// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Shop.h instead.

#import <CoreData/CoreData.h>

#define Shop_ClassName @"Shop"

#define Shop_Address @"address"
#define Shop_City @"city"
#define Shop_DataMode @"dataMode"
#define Shop_Desc @"desc"
#define Shop_DisplayTel @"displayTel"
#define Shop_IdShop @"idShop"
#define Shop_Logo @"logo"
#define Shop_LoveStatus @"loveStatus"
#define Shop_NumOfComment @"numOfComment"
#define Shop_NumOfLove @"numOfLove"
#define Shop_NumOfView @"numOfView"
#define Shop_PromotionType @"promotionType"
#define Shop_ShopGalleryCover @"shopGalleryCover"
#define Shop_ShopGalleryImage @"shopGalleryImage"
#define Shop_ShopLat @"shopLat"
#define Shop_ShopLng @"shopLng"
#define Shop_ShopName @"shopName"
#define Shop_ShopType @"shopType"
#define Shop_ShopTypeDisplay @"shopTypeDisplay"
#define Shop_Tel @"tel"
#define Shop_TotalComment @"totalComment"
#define Shop_TotalLove @"totalLove"

@class Shop;
@class UserHome4;
@class UserHome6;
@class UserHome8;
@class ShopKM1;
@class ShopKM2;
@class PromotionNews;
@class ShopGallery;
@class ShopList;
@class ShopUserComment;
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
@property (nonatomic, retain) NSNumber* dataMode;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSString* displayTel;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* loveStatus;
@property (nonatomic, retain) NSString* numOfComment;
@property (nonatomic, retain) NSString* numOfLove;
@property (nonatomic, retain) NSString* numOfView;
@property (nonatomic, retain) NSNumber* promotionType;
@property (nonatomic, retain) NSString* shopGalleryCover;
@property (nonatomic, retain) NSString* shopGalleryImage;
@property (nonatomic, retain) NSNumber* shopLat;
@property (nonatomic, retain) NSNumber* shopLng;
@property (nonatomic, retain) NSString* shopName;
@property (nonatomic, retain) NSNumber* shopType;
@property (nonatomic, retain) NSString* shopTypeDisplay;
@property (nonatomic, retain) NSString* tel;
@property (nonatomic, retain) NSNumber* totalComment;
@property (nonatomic, retain) NSNumber* totalLove;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home4
- (NSSet*) home4;
- (NSArray*) home4Objects;
- (void) addHome4:(NSSet*)value;
- (void) removeHome4:(NSSet*)value;
- (void) addHome4Object:(UserHome4*)value;
- (void) removeHome4Object:(UserHome4*)value;
- (void) removeAllHome4;

#pragma mark Home6
- (NSSet*) home6;
- (NSArray*) home6Objects;
- (void) addHome6:(NSSet*)value;
- (void) removeHome6:(NSSet*)value;
- (void) addHome6Object:(UserHome6*)value;
- (void) removeHome6Object:(UserHome6*)value;
- (void) removeAllHome6;

#pragma mark Home8
- (NSSet*) home8;
- (NSArray*) home8Objects;
- (void) addHome8:(NSSet*)value;
- (void) removeHome8:(NSSet*)value;
- (void) addHome8Object:(UserHome8*)value;
- (void) removeHome8Object:(UserHome8*)value;
- (void) removeAllHome8;

#pragma mark Km1
@property (nonatomic, retain) ShopKM1* km1;

#pragma mark Km2
@property (nonatomic, retain) ShopKM2* km2;

#pragma mark PromotionNew
@property (nonatomic, retain) PromotionNews* promotionNew;

#pragma mark ShopGalleries
- (NSSet*) shopGalleries;
- (NSArray*) shopGalleriesObjects;
- (void) addShopGalleries:(NSSet*)value;
- (void) removeShopGalleries:(NSSet*)value;
- (void) addShopGalleriesObject:(ShopGallery*)value;
- (void) removeShopGalleriesObject:(ShopGallery*)value;
- (void) removeAllShopGalleries;

#pragma mark ShopList
@property (nonatomic, retain) ShopList* shopList;

#pragma mark TimeComments
- (NSSet*) timeComments;
- (NSArray*) timeCommentsObjects;
- (void) addTimeComments:(NSSet*)value;
- (void) removeTimeComments:(NSSet*)value;
- (void) addTimeCommentsObject:(ShopUserComment*)value;
- (void) removeTimeCommentsObject:(ShopUserComment*)value;
- (void) removeAllTimeComments;

#pragma mark TopComments
- (NSSet*) topComments;
- (NSArray*) topCommentsObjects;
- (void) addTopComments:(NSSet*)value;
- (void) removeTopComments:(NSSet*)value;
- (void) addTopCommentsObject:(ShopUserComment*)value;
- (void) removeTopCommentsObject:(ShopUserComment*)value;
- (void) removeAllTopComments;

#pragma mark UserGalleries
- (NSSet*) userGalleries;
- (NSArray*) userGalleriesObjects;
- (void) addUserGalleries:(NSSet*)value;
- (void) removeUserGalleries:(NSSet*)value;
- (void) addUserGalleriesObject:(ShopUserGallery*)value;
- (void) removeUserGalleriesObject:(ShopUserGallery*)value;
- (void) removeAllUserGalleries;



#pragma mark Utility

-(void) revert;

@end