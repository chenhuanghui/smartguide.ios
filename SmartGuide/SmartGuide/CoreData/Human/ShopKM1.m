#import "ShopKM1.h"
#import "Utility.h"
#import "KM1Voucher.h"

@implementation ShopKM1

+(ShopKM1 *)makeWithJSON:(NSDictionary *)data
{
    ShopKM1 *obj=[ShopKM1 insert];
    obj.notice=[NSString stringWithStringDefault:data[@"notice"]];
    obj.duration=[NSString stringWithStringDefault:data[@"duration"]];
    obj.money=[NSString stringWithStringDefault:data[@"money"]];
    obj.sgp=[NSString stringWithStringDefault:data[@"sgp"]];
    obj.sp=[NSString stringWithStringDefault:data[@"sp"]];
    obj.p=[NSString stringWithStringDefault:data[@"p"]];
    
    NSArray *voucher=data[@"voucherList"];
    
    if(![voucher isNullData])
    {
        int i=0;
        for(NSDictionary *dict in voucher)
        {
            KM1Voucher *v = [KM1Voucher makeWithJSON:dict];
            v.sortOrder=@(i++);
            
            [obj addListVoucherObject:v];
        }
    }
    
    return obj;
}

-(NSArray *)listVoucherObjects
{
    return [[super listVoucherObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:KM1Voucher_SortOrder ascending:true]]];
}

@end
