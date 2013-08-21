// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PromotionDetail.h instead.

#import <CoreData/CoreData.h>

#define PromotionDetail_ClassName @"PromotionDetail"

#define PromotionDetail_Cost @"cost"
#define PromotionDetail_Duration @"duration"
#define PromotionDetail_IdAwardType2 @"idAwardType2"
#define PromotionDetail_Money @"money"
#define PromotionDetail_PromotionType @"promotionType"
#define PromotionDetail_Sgp @"sgp"
#define PromotionDetail_Sp @"sp"

@class PromotionDetail;
@class PromotionRequire;
@class Shop;

@interface _PromotionDetail : NSManagedObject

+(PromotionDetail*) insert;
+(PromotionDetail*) temporary;
+(NSArray*) queryPromotionDetail:(NSPredicate*) predicate;
+(PromotionDetail*) queryPromotionDetailObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSNumber* cost;
@property (nonatomic, retain) NSString* duration;
@property (nonatomic, retain) NSNumber* idAwardType2;
@property (nonatomic, retain) NSNumber* money;
@property (nonatomic, retain) NSNumber* promotionType;
@property (nonatomic, retain) NSNumber* sgp;
@property (nonatomic, retain) NSNumber* sp;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Requires
- (NSSet*) requires;
- (NSArray*) requiresObjects;
- (void) addRequires:(NSSet*)value;
- (void) removeRequires:(NSSet*)value;
- (void) addRequiresObject:(PromotionRequire*)value;
- (void) removeRequiresObject:(PromotionRequire*)value;

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end