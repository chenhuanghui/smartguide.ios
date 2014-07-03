// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KM1Voucher.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define KM1Voucher_ClassName @"KM1Voucher"

#define KM1Voucher_IdVoucher @"idVoucher"
#define KM1Voucher_IsAfford @"isAfford"
#define KM1Voucher_Name @"name"
#define KM1Voucher_Sgp @"sgp"
#define KM1Voucher_SortOrder @"sortOrder"
#define KM1Voucher_Type @"type"

@class KM1Voucher;
@class ShopKM1;

@interface _KM1Voucher : NSManagedObject

+(KM1Voucher*) insert;
+(KM1Voucher*) temporary;
+(NSArray*) queryKM1Voucher:(NSPredicate*) predicate;
+(KM1Voucher*) queryKM1VoucherObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* idVoucher;
@property (nonatomic, retain) NSNumber* isAfford;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* sgp;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* type;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark ShopKM1
@property (nonatomic, retain) ShopKM1* shopKM1;



#pragma mark Utility

-(void) revert;
-(void) save;

@end