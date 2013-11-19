// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopProduct.h instead.

#import <CoreData/CoreData.h>

#define ShopProduct_ClassName @"ShopProduct"

#define ShopProduct_Cat_name @"cat_name"
#define ShopProduct_Desc @"desc"
#define ShopProduct_HasPrice1 @"hasPrice1"
#define ShopProduct_Images @"images"
#define ShopProduct_Name @"name"
#define ShopProduct_Price @"price"
#define ShopProduct_Price1 @"price1"

@class ShopProduct;
@class Shop;

@interface _ShopProduct : NSManagedObject

+(ShopProduct*) insert;
+(ShopProduct*) temporary;
+(NSArray*) queryShopProduct:(NSPredicate*) predicate;
+(ShopProduct*) queryShopProductObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;

-(bool) save;


@property (nonatomic, retain) NSString* cat_name;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* hasPrice1;
@property (nonatomic, retain) NSString* images;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* price;
@property (nonatomic, retain) NSString* price1;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end