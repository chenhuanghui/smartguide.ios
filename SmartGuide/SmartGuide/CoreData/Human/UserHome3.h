#import "_UserHome3.h"
#import "Constant.h"

@interface UserHome3 : _UserHome3 
{
}

+(UserHome3*) makeWithDictionary:(NSDictionary*) dict;
-(enum LOVE_STATUS) enumLoveStatus;

@end
