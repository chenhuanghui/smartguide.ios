#import "KM2Voucher.h"
#import "Utility.h"

@implementation KM2Voucher

+(KM2Voucher *)makeWithDictionary:(NSDictionary *)dict
{
    KM2Voucher *voucher=[KM2Voucher insert];
    
    voucher.type=[NSString stringWithStringDefault:dict[@"type"]];
    voucher.name=[NSString stringWithStringDefault:dict[@"name"]];
    voucher.condition=[NSString stringWithStringDefault:dict[@"condition"]];
    voucher.highlightKeywords=[NSString stringWithStringDefault:dict[@"highlightKeywords"]];
    voucher.isAfford=[NSNumber numberWithObject:dict[@"isAfford"]];
    
    return voucher;
}

@end
