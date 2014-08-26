#import "_Home.h"

enum HOME_TYPE
{
    HOME_TYPE_UNKNOW=-1,
    HOME_TYPE_SHOP=6,
    HOME_TYPE_IMAGES=9,
};

@interface Home : _Home 
{
}

+(Home*) makeHomeWithData:(NSDictionary*) dict;

-(enum HOME_TYPE) enumType;

@end
