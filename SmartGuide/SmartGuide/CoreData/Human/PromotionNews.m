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
    
    obj.duration=[NSString makeString:dict[@"duration"]];
    obj.title=[NSString makeString:dict[@"title"]];
    obj.content=[NSString makeString:dict[@"content"]];
    
    if([dict[@"image"] isHasString])
    {
        obj.image=[NSString makeString:dict[@"image"]];
        obj.imageWidth=[NSNumber makeNumber:dict[@"imageWidth"]];
        obj.imageHeight=[NSNumber makeNumber:dict[@"imageHeight"]];
    }
    
    if([dict[@"video"] isHasString])
    {
        obj.video=[NSString makeString:dict[@"video"]];
        obj.videoWidth=[NSNumber makeNumber:dict[@"videoWidth"]];
        obj.videoHeight=[NSNumber makeNumber:dict[@"videoHeight"]];
        obj.videoThumbnail=[NSString makeString:dict[@"videoThumbnail"]];
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

@end
