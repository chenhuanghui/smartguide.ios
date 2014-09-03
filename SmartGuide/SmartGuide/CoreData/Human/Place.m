#import "Place.h"

@implementation Place
@synthesize descRect, nameRect;

+(Place *)makeWithData:(NSDictionary *)dict
{
    Place *obj = [Place insert];
    
    obj.idPlace=[NSNumber makeNumber:dict[@"idPlacelist"]];
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

@end
