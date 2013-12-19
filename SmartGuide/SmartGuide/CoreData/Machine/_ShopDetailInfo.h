// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopDetailInfo.h instead.

#import <CoreData/CoreData.h>

#define ShopDetailInfo_ClassName @"ShopDetailInfo"

#define ShopDetailInfo_Content @"content"
#define ShopDetailInfo_Date @"date"
#define ShopDetailInfo_Header @"header"
#define ShopDetailInfo_IdShop @"idShop"
#define ShopDetailInfo_Image @"image"
#define ShopDetailInfo_IsTicked @"isTicked"
#define ShopDetailInfo_Title @"title"
#define ShopDetailInfo_Type @"type"

@class ShopDetailInfo;
@class Shop;

@interface _ShopDetailInfo : NSManagedObject

+(ShopDetailInfo*) insert;
+(ShopDetailInfo*) temporary;
+(NSArray*) queryShopDetailInfo:(NSPredicate*) predicate;
+(ShopDetailInfo*) queryShopDetailInfoObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, retain) NSString* header;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* isTicked;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSNumber* type;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end