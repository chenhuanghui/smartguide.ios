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
    obj.imageWidth=[NSNumber numberWithObject:dict[@"imageWidth"]];
    obj.imageHeight=[NSNumber numberWithObject:dict[@"imageHeight"]];
    
    return obj;
}

-(CGSize)newsSize
{
    float frameWidthLayoutNews=274;
    return CGSizeMake(frameWidthLayoutNews, MAX(0,frameWidthLayoutNews*self.imageHeight.floatValue/self.imageWidth.floatValue));
}

-(NSNumber *)imageWidth
{
    return [super imageWidth].floatValue==0?@(1):[super imageWidth];
}

-(NSString *)title1
{
    return @"Lorem ipsum dolor sit amet, consectetuer";
}

@end
