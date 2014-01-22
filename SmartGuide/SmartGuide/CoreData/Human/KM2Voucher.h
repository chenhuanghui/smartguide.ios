#import "_KM2Voucher.h"

@interface KM2Voucher : _KM2Voucher 
{
}

+(KM2Voucher*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, assign) float nameHeight;
@property (nonatomic, assign) float conditionHeight;
@property (nonatomic, assign) float voucherHeight;

@end
