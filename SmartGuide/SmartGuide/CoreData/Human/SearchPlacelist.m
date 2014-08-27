#import "SearchPlacelist.h"

@implementation SearchPlacelist

+(SearchPlacelist *)makeWithdata:(NSDictionary *)dict
{
    SearchPlacelist *obj=[SearchPlacelist insert];
    
    obj.idPlacelist=[NSNumber makeNumber:dict[@"idPlacelist"]];
    obj.title=[NSString makeString:dict[@"title"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    obj.image=[NSString makeString:dict[@"image"]];
    obj.numOfView=[NSString makeString:dict[@"numOfView"]];
    obj.loveStatus=[NSNumber makeNumber:dict[@"loveStatus"]];
    obj.idAuthor=[NSNumber makeNumber:dict[@"idAuthor"]];
    obj.authorName=[NSString makeString:dict[@"authorName"]];
    obj.authorAvatar=[NSString makeString:dict[@"authorAvatar"]];
    
    return obj;
}

-(enum LOVE_STATUS)enumLoveStatus
{
    switch ((enum LOVE_STATUS)self.loveStatus.integerValue) {
        case LOVE_STATUS_LOVED:
            return LOVE_STATUS_LOVED;
            
        case LOVE_STATUS_NONE:
            return LOVE_STATUS_NONE;
    }
    
    return LOVE_STATUS_NONE;
}

@end
