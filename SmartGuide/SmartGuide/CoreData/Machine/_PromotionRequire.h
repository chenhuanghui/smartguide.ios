// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PromotionRequire.h instead.

#import <CoreData/CoreData.h>

#define PromotionRequire_ClassName @"PromotionRequire"

#define PromotionRequire_Content @"content"
#define PromotionRequire_IdRequire @"idRequire"
#define PromotionRequire_NumberVoucher @"numberVoucher"
#define PromotionRequire_SgpRequired @"sgpRequired"

@class PromotionRequire;
@class PromotionDetail;

@interface _PromotionRequire : NSManagedObject

+(PromotionRequire*) insert;
+(PromotionRequire*) temporary;
+(NSArray*) queryPromotionRequire:(NSPredicate*) predicate;
+(PromotionRequire*) queryPromotionRequireObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;

-(bool) save;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSNumber* idRequire;
@property (nonatomic, retain) NSString* numberVoucher;
@property (nonatomic, retain) NSNumber* sgpRequired;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Promotion
@property (nonatomic, retain) PromotionDetail* promotion;


@end