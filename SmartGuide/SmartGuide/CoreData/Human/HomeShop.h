#import "_HomeShop.h"
#import "Protocols.h"

@interface HomeShop : _HomeShop 
{
}

+(HomeShop*) makeWithData:(NSDictionary*) dict;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect descRect;

@end

@interface HomeShop(MapObject)<MapObject>

@end