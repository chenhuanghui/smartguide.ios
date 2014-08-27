#import "_SearchPlacelist.h"

@interface SearchPlacelist : _SearchPlacelist 
{
}

+(SearchPlacelist*) makeWithdata:(NSDictionary*) dict;

-(enum LOVE_STATUS) enumLoveStatus;

@end
