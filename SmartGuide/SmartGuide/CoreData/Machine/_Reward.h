// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Reward.h instead.

#import <CoreData/CoreData.h>

#define Reward_ClassName @"Reward"

#define Reward_Content @"content"
#define Reward_IdReward @"idReward"
#define Reward_Score @"score"
#define Reward_Status @"status"
#define Reward_Thumbnail @"thumbnail"

@class Reward;

@interface _Reward : NSManagedObject

+(Reward*) insert;
+(Reward*) temporary;
+(NSArray*) queryReward:(NSPredicate*) predicate;
+(Reward*) queryRewardObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSNumber* idReward;
@property (nonatomic, retain) NSNumber* score;
@property (nonatomic, retain) NSNumber* status;
@property (nonatomic, retain) NSString* thumbnail;

#pragma mark Fetched property

    
#pragma mark Relationships



#pragma mark Utility

-(void) revert;

@end