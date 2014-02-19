// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KM2Voucher.h instead.

#import <CoreData/CoreData.h>

#define KM2Voucher_ClassName @"KM2Voucher"

#define KM2Voucher_Condition @"condition"
#define KM2Voucher_HighlightKeywords @"highlightKeywords"
#define KM2Voucher_IsAfford @"isAfford"
#define KM2Voucher_Name @"name"
#define KM2Voucher_SortOrder @"sortOrder"
#define KM2Voucher_Type @"type"

@class KM2Voucher;
@class ShopKM2;

@interface _KM2Voucher : NSManagedObject

+(KM2Voucher*) insert;
+(KM2Voucher*) temporary;
+(NSArray*) queryKM2Voucher:(NSPredicate*) predicate;
+(KM2Voucher*) queryKM2VoucherObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* condition;
@property (nonatomic, retain) NSString* highlightKeywords;
@property (nonatomic, retain) NSNumber* isAfford;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* type;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark ShopKM2
@property (nonatomic, retain) ShopKM2* shopKM2;



#pragma mark Utility

-(void) revert;

@end