#import "UserNotificationDetail.h"

@implementation UserNotificationDetail
@synthesize titleHeight,contentHeight;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    titleHeight=@(-1);
    contentHeight=@(-1);
    
    return self;
}

-(NSString *)title
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut";
}

-(NSString *)desc
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut";
}

-(NSString *)time
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut";
}

-(NSString *)icon
{
    return @"http://t3.gstatic.com/images?q=tbn:ANd9GcTqa22F4TsnxuXPU_jxYz4UJAoEdqLIdLFHOTjQheEc9zscFIynnQ";
}

-(NSString *)actionTitle
{
    return @"Lorem ipsum dolor sit amet";
}

@end
