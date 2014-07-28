#import "_UserHome6.h"
#import "Shop.h"

@interface UserHome6 : _UserHome6 
{
}

+(UserHome6*) makeWithDictionary:(NSDictionary*) dict;

-(NSString *)logo;

@property (nonatomic, strong) NSAttributedString *contentAttribute;

@end
