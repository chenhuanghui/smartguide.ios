#import "_UserHome7.h"
#import "StoreShop.h"

@interface UserHome7 : _UserHome7 
{
}

+(UserHome7*) makeWithDictionary:(NSDictionary*) dict;

-(NSString*) storeName;

@property (nonatomic, assign) float titleHeight;
@property (nonatomic, assign) float contentHeight;

@end
