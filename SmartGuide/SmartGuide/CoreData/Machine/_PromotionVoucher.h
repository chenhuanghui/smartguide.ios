// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PromotionVoucher.h instead.

#import <CoreData/CoreData.h>

#define PromotionVoucher_ClassName @"PromotionVoucher"

#define PromotionVoucher_Content @"content"
#define PromotionVoucher_Desc @"desc"
#define PromotionVoucher_IdVoucher @"idVoucher"
#define PromotionVoucher_Money @"money"
#define PromotionVoucher_NumberVoucher @"numberVoucher"
#define PromotionVoucher_P @"p"
#define PromotionVoucher_SortOrder @"sortOrder"
#define PromotionVoucher_Title @"title"

@class PromotionVoucher;
@class PromotionDetail;

@interface _PromotionVoucher : NSManagedObject

+(PromotionVoucher*) insert;
+(PromotionVoucher*) temporary;
+(NSArray*) queryPromotionVoucher:(NSPredicate*) predicate;
+(PromotionVoucher*) queryPromotionVoucherObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idVoucher;
@property (nonatomic, retain) NSNumber* money;
@property (nonatomic, retain) NSString* numberVoucher;
@property (nonatomic, retain) NSNumber* p;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* title;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Promotion
@property (nonatomic, retain) PromotionDetail* promotion;


@end