#import "HomeImages.h"
#import "HomeImage.h"

@implementation HomeImages
@synthesize homeImageSize;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.homeImageSize=CGSizeZero;
    
    return self;
}

+(HomeImages *)makeWithData:(NSDictionary *)dict
{
    HomeImages *obj=[HomeImages insert];
    obj.imageWidth=[NSNumber makeNumber:dict[@"imageWidth"]];
    obj.imageHeight=[NSNumber makeNumber:dict[@"imageHeight"]];
    
    if([dict[@"idPlacelist"] hasData])
        obj.idPlacelist=[NSNumber makeNumber:dict[@"idPlacelist"]];
    else if([dict[@"idShops"] hasData])
        obj.idShops=[NSString makeString:dict[@"idShops"]];
    
    if([dict[@"images"] hasData])
    {
        int count=0;
        for(NSString *str in dict[@"images"])
        {
            HomeImage *img=[HomeImage insert];
            img.sortOrder=@(count++);
            img.image=[NSString makeString:str];
            
            [obj addImagesObject:img];
        }
    }
    
    return obj;
}

-(NSArray *)imagesObjects
{
    return [[super imagesObjects] sortedArrayUsingDescriptors:@[sortDesc(HomeImage_SortOrder, true)]];
}

@end
