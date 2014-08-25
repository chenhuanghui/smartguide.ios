// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Event.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define Event_ClassName @"Event"

#define Event_BrandName @"brandName"
#define Event_Cover @"cover"
#define Event_CoverHeight @"coverHeight"
#define Event_CoverWidth @"coverWidth"
#define Event_Date @"date"
#define Event_Desc @"desc"
#define Event_GoTo @"goTo"
#define Event_IdShop @"idShop"
#define Event_IdShops @"idShops"
#define Event_Logo @"logo"
#define Event_ShopLat @"shopLat"
#define Event_ShopLng @"shopLng"
#define Event_Title @"title"
#define Event_Type @"type"

@class Event;

@interface _Event : NSManagedObject

+(Event*) insert;
+(Event*) temporary;
+(NSArray*) queryEvent:(NSPredicate*) predicate;
+(Event*) queryEventObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* brandName;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSNumber* coverHeight;
@property (nonatomic, retain) NSNumber* coverWidth;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSString* goTo;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* shopLat;
@property (nonatomic, retain) NSNumber* shopLng;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSNumber* type;

#pragma mark Fetched property

    
#pragma mark Relationships



#pragma mark Utility

-(void) revert;

@end