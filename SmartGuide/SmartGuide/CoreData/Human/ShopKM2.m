#import "ShopKM2.h"
#import "Utility.h"

@implementation ShopKM2

+(ShopKM2 *)makeWithDictionary:(NSDictionary *)dict
{
    ShopKM2 *km2=[ShopKM2 insert];
    
    km2.text=[NSString stringWithStringDefault:dict[@"text"]];
    
    NSArray *array=dict[@"voucherList"];
    
    if(![array isNullData])
    {
        int count=0;
        for(NSDictionary *voucher in array)
        {
            KM2Voucher *obj = [KM2Voucher makeWithDictionary:voucher];
            obj.sortOrder=@(count++);
            
            [km2 addListVoucherObject:obj];
        }
    }
    
    return km2;
}

-(NSArray *)listVoucherObjects
{
    NSArray *array=[super listVoucherObjects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:KM2Voucher_SortOrder ascending:true]]];
    
    return [NSArray array];
        
}

@end
