// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Filter.h instead.

#import <CoreData/CoreData.h>

#define Filter_ClassName @"Filter"

#define Filter_Distance @"distance"
#define Filter_Drink @"drink"
#define Filter_Education @"education"
#define Filter_Entertaiment @"entertaiment"
#define Filter_Fashion @"fashion"
#define Filter_Food @"food"
#define Filter_Health @"health"
#define Filter_IdUser @"idUser"
#define Filter_MostGetPoint @"mostGetPoint"
#define Filter_MostGetReward @"mostGetReward"
#define Filter_MostLike @"mostLike"
#define Filter_MostView @"mostView"
#define Filter_Production @"production"
#define Filter_Travel @"travel"

@class Filter;
@class User;

@interface _Filter : NSManagedObject

+(Filter*) insert;
+(Filter*) temporary;
+(NSArray*) queryFilter:(NSPredicate*) predicate;
+(Filter*) queryFilterObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSNumber* distance;
@property (nonatomic, retain) NSNumber* drink;
@property (nonatomic, retain) NSNumber* education;
@property (nonatomic, retain) NSNumber* entertaiment;
@property (nonatomic, retain) NSNumber* fashion;
@property (nonatomic, retain) NSNumber* food;
@property (nonatomic, retain) NSNumber* health;
@property (nonatomic, retain) NSNumber* idUser;
@property (nonatomic, retain) NSNumber* mostGetPoint;
@property (nonatomic, retain) NSNumber* mostGetReward;
@property (nonatomic, retain) NSNumber* mostLike;
@property (nonatomic, retain) NSNumber* mostView;
@property (nonatomic, retain) NSNumber* production;
@property (nonatomic, retain) NSNumber* travel;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark User
@property (nonatomic, retain) User* user;


@end