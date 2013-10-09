#import "_PromotionDetail.h"

@interface PromotionDetail : _PromotionDetail 
{
}

-(PromotionVoucher*) voucherWithID:(int) idVoucher;

@property (nonatomic, strong) NSMutableArray *requiresInserted;
@property (nonatomic, strong) NSMutableArray *vouchersInserted;

@end
