#import "Placelist.h"
#import "Utility.h"

@implementation Placelist
@synthesize titleHeight,contentHeight;

+(Placelist *)placeListWithID:(int)idPlaceList
{
    return [Placelist queryPlacelistObject:[NSPredicate predicateWithFormat:@"%K == %i",Placelist_IdPlacelist,idPlaceList]];
}

+(Placelist *)makeWithDictionary:(NSDictionary *)dict
{
    int idPlace=[[NSNumber numberWithObject:dict[@"idPlacelist"]] integerValue];
    Placelist *obj = [Placelist placeListWithID:idPlace];
    
    if(!obj)
    {
        obj=[Placelist insert];
        obj.idPlacelist=@(idPlace);
    }
    
    obj.title=[NSString stringWithStringDefault:dict[@"title"]];
    obj.desc=[NSString stringWithStringDefault:dict[@"description"]];
    obj.image=[NSString stringWithStringDefault:dict[@"image"]];
    obj.numOfView=[NSString stringWithStringDefault:dict[@"numOfView"]];
    obj.loveStatus=[NSNumber numberWithObject:dict[@"loveStatus"]];
    obj.authorName=[NSString stringWithStringDefault:dict[@"authorName"]];
    obj.authorAvatar=[NSString stringWithStringDefault:dict[@"authorAvatar"]];
    
    return obj;
}

-(enum LOVE_STATUS)enumLoveStatus
{
    switch (self.loveStatus.integerValue) {
        case 0:
            return LOVE_STATUS_NONE;
            
        case 1:
            return LOVE_STATUS_LOVED;
            
        default:
            return LOVE_STATUS_NONE;
    }
}

-(NSString *)title
{
    return @"Mục tiêu  trận gặp U19 .";
}

-(NSString *)desc
{
    return @"Mục tiêu của U19 Việt Nam trong trận gặp U19 Tottenham là trình diễn lối chơi thuyết phục như ở trận ra quân với U19 AS Roma.";
}

@end
