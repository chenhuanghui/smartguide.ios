#import "_Placelist.h"
#import "Constant.h"

@interface Placelist : _Placelist 
{
}

+(Placelist*) placeListWithID:(int) idPlaceList;
+(Placelist*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, assign) float titleHeight;
@property (nonatomic, assign) float contentHeight;

-(enum LOVE_STATUS) enumLoveStatus;

@end
