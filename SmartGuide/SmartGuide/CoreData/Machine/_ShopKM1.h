// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopKM1.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ShopKM1_ClassName @"ShopKM1"

#define ShopKM1_Duration @"duration"
#define ShopKM1_HasSGP @"hasSGP"
#define ShopKM1_Money @"money"
#define ShopKM1_P @"p"
#define ShopKM1_Sgp @"sgp"
#define ShopKM1_Sp @"sp"
#define ShopKM1_Text @"text"

@class ShopKM1;
@class KM1Voucher;
@class Shop;

@interface _ShopKM1 : NSManagedObject

+(ShopKM1*) insert;
+(ShopKM1*) temporary;
+(NSArray*) queryShopKM1:(NSPredicate*) predicate;
+(ShopKM1*) queryShopKM1Object:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* duration;
@property (nonatomic, retain) NSNumber* hasSGP;
@property (nonatomic, retain) NSString* money;
@property (nonatomic, retain) NSString* p;
@property (nonatomic, retain) NSString* sgp;
@property (nonatomic, retain) NSString* sp;
@property (nonatomic, retain) NSString* text;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark ListVoucher
- (NSSet*) listVoucher;
- (NSArray*) listVoucherObjects;
- (void) addListVoucher:(NSSet*)value;
- (void) removeListVoucher:(NSSet*)value;
- (void) addListVoucherObject:(KM1Voucher*)value;
- (void) removeListVoucherObject:(KM1Voucher*)value;
- (void) removeAllListVoucher;

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;



#pragma mark Utility

-(void) revert;

@end