#import "PromotionNews.h"
#import "Utility.h"

@implementation PromotionNews
@synthesize titleHeight,contentHeight,imageHeightForShop,videoHeightForShop,kmHeight;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.titleHeight=@(-1);
    self.contentHeight=@(-1);
    self.imageHeightForShop=@(-1);
    self.videoHeightForShop=@(-1);
    self.kmHeight=@(-1);
    
    return self;
}

+(PromotionNews *)makeWithDictionary:(NSDictionary *)dict
{
    PromotionNews *obj = [PromotionNews insert];
    
    obj.duration=[NSString stringWithStringDefault:dict[@"duration"]];
    obj.title=[NSString stringWithStringDefault:dict[@"title"]];
    obj.content=[NSString stringWithStringDefault:dict[@"content"]];
    
    if([dict[@"image"] isHasString])
    {
        obj.image=[NSString stringWithStringDefault:dict[@"image"]];
        obj.imageWidth=[NSNumber numberWithObject:dict[@"imageWidth"]];
        obj.imageHeight=[NSNumber numberWithObject:dict[@"imageHeight"]];
    }
    
    if([dict[@"video"] isHasString])
    {
        obj.video=[NSString stringWithStringDefault:dict[@"video"]];
        obj.videoWidth=[NSNumber numberWithObject:dict[@"videoWidth"]];
        obj.videoHeight=[NSNumber numberWithObject:dict[@"videoHeight"]];
        obj.videoThumbnail=[NSString stringWithStringDefault:dict[@"videoThumbnail"]];
    }
    
    return obj;
}

-(NSNumber *)imageWidth
{
    NSNumber *num=[super imageWidth];
    
    if(num.floatValue==0)
        return @(1);
    
    return num;
}

-(NSNumber *)videoWidth
{
    NSNumber *num=[super videoWidth];
    
    if(num.floatValue==0)
        return @(1);
    
    return num;
}

-(NSString *)title1
{
    return @"Lorem ipsum dolor sit amet, consectetuer";
}

-(NSString *)title
{
    return [[super title] stringByAppendingFormat:@" %i",self.sortOrder.integerValue];
}

@end
