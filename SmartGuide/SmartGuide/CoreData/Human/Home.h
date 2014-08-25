#import "_Home.h"

enum HOME_TYPE
{
    HOME_TYPE_UNKNOW=0,
    HOME_TYPE_SHOP=1,
    HOME_TYPE_IMAGES=2,
};

@interface Home : _Home 
{
}

+(Home*) makeHomeWithData:(NSDictionary*) dict;

-(enum HOME_TYPE) enumType;

@end
