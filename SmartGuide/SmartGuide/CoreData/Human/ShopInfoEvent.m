#import "ShopInfoEvent.h"

@implementation ShopInfoEvent

+(ShopInfoEvent *)makeWithData:(NSDictionary *)dict
{
    ShopInfoEvent *obj = [ShopInfoEvent insert];
    
    obj.duration=[NSString makeString:dict[@"duration"]];
    obj.title=[NSString makeString:dict[@"title"]];
    obj.content=[NSString makeString:dict[@"content"]];
    
    if([dict[@"image"] hasData])
    {
        obj.image=[NSString makeString:dict[@"image"]];
        obj.imageWidth=[NSNumber makeNumber:dict[@"imageWidth"]];
        obj.imageHeight=[NSNumber makeNumber:dict[@"imageHeight"]];
    }
    
    if([dict[@"video"] hasData])
    {
        obj.video=[NSString makeString:dict[@"video"]];
        obj.videoWidth=[NSNumber makeNumber:dict[@"videoWidth"]];
        obj.videoHeight=[NSNumber makeNumber:dict[@"videoHeight"]];
        obj.videoThumbnail=[NSString makeString:dict[@"videoThumbnail"]];
    }
    
    return obj;
}

@end
