// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome7.h instead.

#import <CoreData/CoreData.h>

#define UserHome7_ClassName @"UserHome7"

#define UserHome7_Content @"content"
#define UserHome7_Cover @"cover"
#define UserHome7_Date @"date"
#define UserHome7_Gotostore @"gotostore"
#define UserHome7_IdStore @"idStore"
#define UserHome7_Logo @"logo"
#define UserHome7_StoreName @"storeName"
#define UserHome7_Title @"title"

@class UserHome7;
@class UserHome;

@interface _UserHome7 : NSManagedObject

+(UserHome7*) insert;
+(UserHome7*) temporary;
+(NSArray*) queryUserHome7:(NSPredicate*) predicate;
+(UserHome7*) queryUserHome7Object:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, retain) NSString* gotostore;
@property (nonatomic, retain) NSNumber* idStore;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSString* storeName;
@property (nonatomic, retain) NSString* title;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) UserHome* home;


@end