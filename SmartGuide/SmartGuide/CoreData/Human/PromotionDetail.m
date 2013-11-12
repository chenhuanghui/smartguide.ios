#import "PromotionDetail.h"
#import "PromotionRequire.h"
#import "PromotionVoucher.h"

@implementation PromotionDetail
@synthesize vouchersInserted,requiresInserted;

-(NSArray *)requiresObjects
{
    NSArray *array=[super requiresObjects];
    
    if(array.count>0)
    {
        NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:PromotionRequire_SgpRequired ascending:true];
        return [array sortedArrayUsingDescriptors:@[sort]];
    }
    
    return array;
}

-(NSArray *)vouchersObjects
{
    NSArray *array=[super vouchersObjects];
    if(array.count>0)
    {
        NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:PromotionVoucher_SortOrder ascending:true];
        return [array sortedArrayUsingDescriptors:@[sort]];
    }
    
    return array;
}

-(PromotionVoucher *)voucherWithID:(int)idVoucher
{
    PromotionVoucher *voucher=nil;
    bool found=false;
    for(voucher in self.vouchersObjects)
        if(voucher.idVoucher.integerValue==idVoucher)
        {
            found=true;
            break;
        }
    
    if(found)
        return voucher;
    
    return nil;
}

@end
