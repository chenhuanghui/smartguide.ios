// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopList.h instead.

#import <CoreData/CoreData.h>

#define ShopList_ClassName @"ShopList"

#define ShopList_Address @"address"
#define ShopList_Cover @"cover"
#define ShopList_CoverFullscreen @"coverFullscreen"
#define ShopList_Desc @"desc"
#define ShopList_Distance @"distance"
#define ShopList_IdShop @"idShop"
#define ShopList_Logo @"logo"
#define ShopList_LoveStatus @"loveStatus"
#define ShopList_NumOfComment @"numOfComment"
#define ShopList_NumOfLove @"numOfLove"
#define ShopList_NumOfView @"numOfView"
#define ShopList_PromotionType @"promotionType"
#define ShopList_ShopLat @"shopLat"
#define ShopList_ShopLng @"shopLng"
#define ShopList_ShopName @"shopName"
#define ShopList_ShopType @"shopType"

@class ShopList;
@class Placelist;

@interface _ShopList : NSManagedObject

+(ShopList*) insert;
+(ShopList*) temporary;
+(NSArray*) queryShopList:(NSPredicate*) predicate;
+(ShopList*) queryShopListObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSString* coverFullscreen;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSString* distance;
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
@property (nonatomic, retain) NSNumber* shopType;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark PlaceList
@property (nonatomic, retain) Placelist* placeList;


@end