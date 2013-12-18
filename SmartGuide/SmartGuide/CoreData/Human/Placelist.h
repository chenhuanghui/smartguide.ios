#import "_Placelist.h"
#import "Constant.h"

@interface Placelist : _Placelist 
{
}

+(Placelist*) placeListWithID:(int) idPlaceList;
+(Placelist*) makeWithDictionary:(NSDictionary*) dict;

-(enum LOVE_STATUS) enumLoveStatus;

@end
