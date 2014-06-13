#import "_KM2Voucher.h"

@interface KM2Voucher : _KM2Voucher 
{
}

+(KM2Voucher*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSNumber* nameHeight;
@property (nonatomic, strong) NSNumber* conditionHeight;

@end
