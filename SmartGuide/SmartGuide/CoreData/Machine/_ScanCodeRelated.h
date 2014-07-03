// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScanCodeRelated.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ScanCodeRelated_ClassName @"ScanCodeRelated"

#define ScanCodeRelated_AuthorAvatar @"authorAvatar"
#define ScanCodeRelated_Desc @"desc"
#define ScanCodeRelated_DescHeight @"descHeight"
#define ScanCodeRelated_Distance @"distance"
#define ScanCodeRelated_IdPlacelist @"idPlacelist"
#define ScanCodeRelated_IdShop @"idShop"
#define ScanCodeRelated_IdShops @"idShops"
#define ScanCodeRelated_Logo @"logo"
#define ScanCodeRelated_Order @"order"
#define ScanCodeRelated_Page @"page"
#define ScanCodeRelated_PlacelistName @"placelistName"
#define ScanCodeRelated_PlacelistNameHeight @"placelistNameHeight"
#define ScanCodeRelated_PromotioNameHeight @"promotioNameHeight"
#define ScanCodeRelated_PromotionName @"promotionName"
#define ScanCodeRelated_ShopName @"shopName"
#define ScanCodeRelated_ShopNameHeight @"shopNameHeight"
#define ScanCodeRelated_Time @"time"
#define ScanCodeRelated_Type @"type"

@class ScanCodeRelated;
@class ScanCodeResult;

@interface _ScanCodeRelated : NSManagedObject

+(ScanCodeRelated*) insert;
+(ScanCodeRelated*) temporary;
+(NSArray*) queryScanCodeRelated:(NSPredicate*) predicate;
+(ScanCodeRelated*) queryScanCodeRelatedObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* authorAvatar;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* descHeight;
@property (nonatomic, retain) NSString* distance;
@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* order;
@property (nonatomic, retain) NSNumber* page;
@property (nonatomic, retain) NSString* placelistName;
@property (nonatomic, retain) NSNumber* placelistNameHeight;
@property (nonatomic, retain) NSNumber* promotioNameHeight;
@property (nonatomic, retain) NSString* promotionName;
@property (nonatomic, retain) NSString* shopName;
@property (nonatomic, retain) NSNumber* shopNameHeight;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSNumber* type;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Result
@property (nonatomic, retain) ScanCodeResult* result;



#pragma mark Utility

-(void) revert;

@end