// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Placelist.h instead.

#import <CoreData/CoreData.h>

#define Placelist_ClassName @"Placelist"

#define Placelist_Desc @"desc"
#define Placelist_IdPlacelist @"idPlacelist"
#define Placelist_Image @"image"
#define Placelist_LoveStatus @"loveStatus"
#define Placelist_NumOfView @"numOfView"
#define Placelist_Title @"title"

@class Placelist;
@class ShopList;

@interface _Placelist : NSManagedObject

+(Placelist*) insert;
+(Placelist*) temporary;
+(NSArray*) queryPlacelist:(NSPredicate*) predicate;
+(Placelist*) queryPlacelistObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* loveStatus;
@property (nonatomic, retain) NSString* numOfView;
@property (nonatomic, retain) NSString* title;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark ShopsList
- (NSSet*) shopsList;
- (NSArray*) shopsListObjects;
- (void) addShopsList:(NSSet*)value;
- (void) removeShopsList:(NSSet*)value;
- (void) addShopsListObject:(ShopList*)value;
- (void) removeShopsListObject:(ShopList*)value;
- (void) removeAllShopsList;


@end