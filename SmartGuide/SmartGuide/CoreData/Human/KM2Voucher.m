#import "KM2Voucher.h"
#import "Utility.h"

@implementation KM2Voucher
@synthesize nameHeight,conditionHeight,voucherHeight;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.nameHeight=@(-1);
    self.conditionHeight=@(-1);
    self.voucherHeight=@(-1);
    
    return self;
}

+(KM2Voucher *)makeWithDictionary:(NSDictionary *)dict
{
    KM2Voucher *voucher=[KM2Voucher insert];
    
    voucher.type=[NSString makeString:dict[@"type"]];
    voucher.name=[NSString makeString:dict[@"name"]];
    voucher.condition=[NSString makeString:dict[@"condition"]];
    voucher.highlightKeywords=[NSString makeString:dict[@"highlightKeywords"]];
    voucher.isAfford=[NSNumber makeNumber:dict[@"isAfford"]];
    
    return voucher;
}

@end
