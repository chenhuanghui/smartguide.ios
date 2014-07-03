// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserPromotion.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserPromotion_ClassName @"UserPromotion"

#define UserPromotion_BrandName @"brandName"
#define UserPromotion_Cover @"cover"
#define UserPromotion_CoverHeight @"coverHeight"
#define UserPromotion_CoverWidth @"coverWidth"
#define UserPromotion_Date @"date"
#define UserPromotion_Desc @"desc"
#define UserPromotion_GoTo @"goTo"
#define UserPromotion_IdItem @"idItem"
#define UserPromotion_IdShop @"idShop"
#define UserPromotion_IdShops @"idShops"
#define UserPromotion_IdStore @"idStore"
#define UserPromotion_Logo @"logo"
#define UserPromotion_SortOrder @"sortOrder"
#define UserPromotion_Title @"title"
#define UserPromotion_Type @"type"

@class UserPromotion;

@interface _UserPromotion : NSManagedObject

+(UserPromotion*) insert;
+(UserPromotion*) temporary;
+(NSArray*) queryUserPromotion:(NSPredicate*) predicate;
+(UserPromotion*) queryUserPromotionObject:(NSPredicate*) predicate;
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
@property (nonatomic, retain) NSNumber* idItem;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSNumber* idStore;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSNumber* type;

#pragma mark Fetched property

    
#pragma mark Relationships



#pragma mark Utility

-(void) revert;
-(void) save;

@end