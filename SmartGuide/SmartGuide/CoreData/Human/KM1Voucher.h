#import "_KM1Voucher.h"

@interface KM1Voucher : _KM1Voucher 
{
}

+(KM1Voucher*) makeWithJSON:(NSDictionary*) data;

@property (nonatomic, strong) NSNumber *nameHeight;

@end
