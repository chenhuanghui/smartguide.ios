#import "KM2Voucher.h"
#import "Utility.h"

@implementation KM2Voucher
@synthesize nameHeight,conditionHeight;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.nameHeight=@(-1);
    self.conditionHeight=@(-1);
    
    return self;
}

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
