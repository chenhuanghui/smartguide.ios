// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopKM2.h instead.

#import <CoreData/CoreData.h>

#define ShopKM2_ClassName @"ShopKM2"

#define ShopKM2_Duration @"duration"
#define ShopKM2_Note @"note"
#define ShopKM2_Text @"text"

@class ShopKM2;
@class KM2Voucher;
@class Shop;

@interface _ShopKM2 : NSManagedObject

+(ShopKM2*) insert;
+(ShopKM2*) temporary;
+(NSArray*) queryShopKM2:(NSPredicate*) predicate;
+(ShopKM2*) queryShopKM2Object:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* duration;
@property (nonatomic, retain) NSString* note;
@property (nonatomic, retain) NSString* text;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark ListVoucher
- (NSSet*) listVoucher;
- (NSArray*) listVoucherObjects;
- (void) addListVoucher:(NSSet*)value;
- (void) removeListVoucher:(NSSet*)value;
- (void) addListVoucherObject:(KM2Voucher*)value;
- (void) removeListVoucherObject:(KM2Voucher*)value;
- (void) removeAllListVoucher;

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end