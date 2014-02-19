// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#import <CoreData/CoreData.h>

#define User_ClassName @"User"

#define User_ActivationCode @"activationCode"
#define User_AllowShareCommentFB @"allowShareCommentFB"
#define User_Avatar @"avatar"
#define User_Birthday @"birthday"
#define User_Cover @"cover"
#define User_FacebookToken @"facebookToken"
#define User_Gender @"gender"
#define User_GoogleplusToken @"googleplusToken"
#define User_IdUser @"idUser"
#define User_Name @"name"
#define User_Phone @"phone"
#define User_SocialType @"socialType"

@class User;

@interface _User : NSManagedObject

+(User*) insert;
+(User*) temporary;
+(NSArray*) queryUser:(NSPredicate*) predicate;
+(User*) queryUserObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* activationCode;
@property (nonatomic, retain) NSNumber* allowShareCommentFB;
@property (nonatomic, retain) NSString* avatar;
@property (nonatomic, retain) NSString* birthday;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSString* facebookToken;
@property (nonatomic, retain) NSNumber* gender;
@property (nonatomic, retain) NSString* googleplusToken;
@property (nonatomic, retain) NSNumber* idUser;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* phone;
@property (nonatomic, retain) NSNumber* socialType;

#pragma mark Fetched property

    
#pragma mark Relationships



#pragma mark Utility

-(void) revert;

@end