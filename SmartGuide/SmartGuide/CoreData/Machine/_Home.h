// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Home.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define Home_ClassName @"Home"

#define Home_Type @"type"

@class Home;
@class HomeImages;
@class HomeShop;

@interface _Home : NSManagedObject

+(Home*) insert;
+(Home*) temporary;
+(NSArray*) queryHome:(NSPredicate*) predicate;
+(Home*) queryHomeObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* type;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark HomeImage
@property (nonatomic, retain) HomeImages* homeImage;

#pragma mark HomeShop
@property (nonatomic, retain) HomeShop* homeShop;



#pragma mark Utility

-(void) revert;

@end