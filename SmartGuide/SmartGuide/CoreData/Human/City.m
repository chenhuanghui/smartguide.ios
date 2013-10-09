#import "City.h"
#import "DataManager.h"

@implementation City

+(City *)cityWithID:(int)idCity
{
    return [City queryCityObject:[NSPredicate predicateWithFormat:@"%K == %i",City_IdCity,idCity]];
}

+(City *)HCMCity
{
    City *city=[City cityWithID:1];
    
    if(!city)
    {
        city=[City insert];
        city.idCity=[NSNumber numberWithInt:1];
        city.name=@"Hồ Chí Minh";
        
        [[DataManager shareInstance] save];
        
        city=[City cityWithID:1];
    }

    return city;
}

@end
