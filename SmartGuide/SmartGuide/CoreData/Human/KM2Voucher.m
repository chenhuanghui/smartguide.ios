#import "KM2Voucher.h"
#import "Utility.h"

@implementation KM2Voucher
@synthesize nameHeight,conditionHeight,voucherHeight;

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

-(NSString *)condition1
{
    return @"Lorem ipsum dolor sit amet ";
}

-(NSString *)name1
{
    return @"ipsum dolor sit amet ipsum dolor sit amet";
}

@end
