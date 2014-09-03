// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfoList.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ShopInfoList_ClassName @"ShopInfoList"

#define ShopInfoList_Address @"address"
#define ShopInfoList_Cover @"cover"
#define ShopInfoList_CoverHeight @"coverHeight"
#define ShopInfoList_CoverWidth @"coverWidth"
#define ShopInfoList_Desc @"desc"
#define ShopInfoList_Distance @"distance"
#define ShopInfoList_IdShop @"idShop"
#define ShopInfoList_Image @"image"
#define ShopInfoList_ImageHeight @"imageHeight"
#define ShopInfoList_ImageWidth @"imageWidth"
#define ShopInfoList_Logo @"logo"
#define ShopInfoList_LoveStatus @"loveStatus"
#define ShopInfoList_Name @"name"
#define ShopInfoList_NumOfComment @"numOfComment"
#define ShopInfoList_NumOfLove @"numOfLove"
#define ShopInfoList_NumOfView @"numOfView"
#define ShopInfoList_ShopLat @"shopLat"
#define ShopInfoList_ShopLng @"shopLng"
#define ShopInfoList_ShopType @"shopType"
#define ShopInfoList_ShopTypeDisplay @"shopTypeDisplay"

@class ShopInfoList;
@class Place;
@class ShopInfo;

@interface _ShopInfoList : NSManagedObject

+(ShopInfoList*) insert;
+(ShopInfoList*) temporary;
+(NSArray*) queryShopInfoList:(NSPredicate*) predicate;
+(ShopInfoList*) queryShopInfoListObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSNumber* coverHeight;
@property (nonatomic, retain) NSNumber* coverWidth;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSString* distance;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* imageHeight;
@property (nonatomic, retain) NSNumber* imageWidth;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* loveStatus;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* numOfComment;
@property (nonatomic, retain) NSString* numOfLove;
@property (nonatomic, retain) NSString* numOfView;
@property (nonatomic, retain) NSNumber* shopLat;
@property (nonatomic, retain) NSNumber* shopLng;
@property (nonatomic, retain) NSNumber* shopType;
@property (nonatomic, retain) NSString* shopTypeDisplay;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Place
@property (nonatomic, retain) Place* place;

#pragma mark Shop
@property (nonatomic, retain) ShopInfo* shop;



#pragma mark Utility

-(void) revert;

@end