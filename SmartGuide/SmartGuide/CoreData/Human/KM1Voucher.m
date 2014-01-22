#import "KM1Voucher.h"
#import "Utility.h"

@implementation KM1Voucher

+(KM1Voucher *)makeWithJSON:(NSDictionary *)data
{
    KM1Voucher *obj=[KM1Voucher insert];
    obj.type=[NSString stringWithStringDefault:data[@"type"]];
    obj.name=[NSString stringWithStringDefault:data[@"name"]];
    obj.sgp=[NSString stringWithStringDefault:data[@"sgp"]];
    obj.isAfford=[NSNumber numberWithObject:data[@"isAfford"]];
    
    return obj;
}

-(NSString *)name1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit,sed diam nonummy nibh euismod tincidunt ut la ";
}

@end
