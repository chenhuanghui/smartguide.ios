// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#import <CoreData/CoreData.h>

#define User_ClassName @"User"

#define User_Avatar @"avatar"
#define User_AvatarImage @"avatarImage"
#define User_IsConnectedFacebook @"isConnectedFacebook"
#define User_Name @"name"

@class User;
@class Filter;

@interface _User : NSManagedObject

+(User*) insert;
+(User*) temporary;
+(NSArray*) queryUser:(NSPredicate*) predicate;
+(User*) queryUserObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* avatar;
@property (nonatomic, retain) NSData* avatarImage;
@property (nonatomic, retain) NSNumber* isConnectedFacebook;
@property (nonatomic, retain) NSString* name;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Filter
@property (nonatomic, retain) Filter* filter;


@end