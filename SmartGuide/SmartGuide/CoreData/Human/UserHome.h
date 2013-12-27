#import "_UserHome.h"
#import "UserHome1.h"
#import "UserHome2.h"
#import "UserHome3.h"
#import "UserHome4.h"
#import "UserHome5.h"
#import "UserHome6.h"
#import "UserHome7.h"
#import "UserHomeImage.h"

enum USER_HOME_TYPE {
    USER_HOME_TYPE_UNKNOW = 0,
    USER_HOME_TYPE_1 = 1,
    USER_HOME_TYPE_2 = 2,
    USER_HOME_TYPE_3 = 3,
    USER_HOME_TYPE_4 = 4,
    USER_HOME_TYPE_5 = 5,
    USER_HOME_TYPE_6 = 6,
    USER_HOME_TYPE_7 = 7,
    };

@interface UserHome : _UserHome 
{
}

+(UserHome*) makeWithDictionary:(NSDictionary*) dict;

-(enum USER_HOME_TYPE) enumType;

@end
