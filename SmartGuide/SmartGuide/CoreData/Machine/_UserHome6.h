// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome6.h instead.

#import <CoreData/CoreData.h>

#define UserHome6_ClassName @"UserHome6"

#define UserHome6_Content @"content"
#define UserHome6_Cover @"cover"
#define UserHome6_Date @"date"
#define UserHome6_Gotoshop @"gotoshop"
#define UserHome6_IdShop @"idShop"
#define UserHome6_Logo @"logo"
#define UserHome6_ShopName @"shopName"
#define UserHome6_Title @"title"

@class UserHome6;
@class UserHome;

@interface _UserHome6 : NSManagedObject

+(UserHome6*) insert;
+(UserHome6*) temporary;
+(NSArray*) queryUserHome6:(NSPredicate*) predicate;
+(UserHome6*) queryUserHome6Object:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, retain) NSString* gotoshop;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSString* shopName;
@property (nonatomic, retain) NSString* title;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) UserHome* home;


@end