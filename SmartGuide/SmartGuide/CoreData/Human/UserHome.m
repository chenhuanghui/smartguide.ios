#import "UserHome.h"
#import "Utility.h"

@implementation UserHome

+(UserHome *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome *home=[UserHome insert];
    
    home.type=[NSNumber numberWithObject:dict[@"type"]];
    
    return home;
}

-(enum USER_HOME_TYPE)enumType
{
    switch (self.type.integerValue) {
        case 1:
            return USER_HOME_TYPE_1;
            
        case 2:
            return USER_HOME_TYPE_2;
            
        case 3:
            return USER_HOME_TYPE_3;
            
        case 4:
            return USER_HOME_TYPE_4;
            
        case 5:
            return USER_HOME_TYPE_5;
            
        case 6:
            return USER_HOME_TYPE_6;
            
        case 7:
            return USER_HOME_TYPE_7;
            
        default:
            return USER_HOME_TYPE_UNKNOW;
    }
}

@end
