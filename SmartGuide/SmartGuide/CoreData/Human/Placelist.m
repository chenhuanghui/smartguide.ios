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
    int idPlace=[[NSNumber makeNumber:dict[@"idPlacelist"]] integerValue];
    Placelist *obj = [Placelist placeListWithID:idPlace];
    
    if(!obj)
    {
        obj=[Placelist insert];
        obj.idPlacelist=@(idPlace);
    }
    
    obj.title=[NSString makeString:dict[@"title"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    obj.image=[NSString makeString:dict[@"image"]];
    obj.numOfView=[NSString makeString:dict[@"numOfView"]];
    obj.loveStatus=[NSNumber makeNumber:dict[@"loveStatus"]];
    obj.authorName=[NSString makeString:dict[@"authorName"]];
    obj.authorAvatar=[NSString makeString:dict[@"authorAvatar"]];
    obj.idAuthor=[NSNumber makeNumber:dict[@"idAuthor"]];
    
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

@end
