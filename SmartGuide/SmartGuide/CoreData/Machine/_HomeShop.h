// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HomeShop.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define HomeShop_ClassName @"HomeShop"

#define HomeShop_Content @"content"
#define HomeShop_Cover @"cover"
#define HomeShop_CoverHeight @"coverHeight"
#define HomeShop_CoverWidth @"coverWidth"
#define HomeShop_Date @"date"
#define HomeShop_GoTo @"goTo"
#define HomeShop_Title @"title"

@class HomeShop;
@class Home;
@class ShopInfo;

@interface _HomeShop : NSManagedObject

+(HomeShop*) insert;
+(HomeShop*) temporary;
+(NSArray*) queryHomeShop:(NSPredicate*) predicate;
+(HomeShop*) queryHomeShopObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSNumber* coverHeight;
@property (nonatomic, retain) NSNumber* coverWidth;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, retain) NSString* goTo;
@property (nonatomic, retain) NSString* title;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) Home* home;

#pragma mark Shop
@property (nonatomic, retain) ShopInfo* shop;



#pragma mark Utility

-(void) revert;

@end