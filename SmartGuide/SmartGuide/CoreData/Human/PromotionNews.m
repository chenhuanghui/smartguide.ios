#import "PromotionNews.h"
#import "Utility.h"

@implementation PromotionNews
@synthesize titleHeight,contentHeight;

+(PromotionNews *)makeWithDictionary:(NSDictionary *)dict
{
    PromotionNews *obj = [PromotionNews insert];
    
    obj.duration=[NSString stringWithStringDefault:dict[@"duration"]];
    obj.image=[NSString stringWithStringDefault:dict[@"image"]];
    obj.title=[NSString stringWithStringDefault:dict[@"title"]];
    obj.content=[NSString stringWithStringDefault:dict[@"content"]];
    
    return obj;
}

-(NSString *)title1
{
    return @"Lorem ipsum dolor sit amet, consectetuer";
}

@end
