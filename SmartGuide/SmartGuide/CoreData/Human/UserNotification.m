#import "UserNotification.h"

@implementation UserNotification
@synthesize contentHeight;
@synthesize contentAttribute;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.contentHeight=@(-1);
    self.contentAttribute=nil;
    
    return self;
}

+(UserNotification *)makeWithDictionary:(NSDictionary *)data
{
    UserNotification *obj=[UserNotification insert];

    obj.content=[NSString stringWithStringDefault:data[@"content"]];
    obj.time=[NSString stringWithStringDefault:data[@"time"]];
    obj.status=[NSNumber numberWithObject:data[@"status"]];
    
    obj.highlight=@"";
    NSMutableArray *array=data[@"highlight"];
    
    if(array && [array isKindOfClass:[NSArray class]])
    {
        obj.highlight=[array componentsJoinedByString:@";"];
    }
    
    return obj;
}

-(NSArray *)highlightIndex
{
    if(self.highlight.length>0)
        return [self.highlight componentsSeparatedByString:@";"];
    
    return [NSArray new];
}

-(NSString *)content
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
}

-(NSString *)time1
{
    return @"Nov 22, 2013 11:23 AM";
}

-(NSNumber *)status1
{
    return @(rand()%2==0);
}

-(enum USER_NOTIFICATION_STATUS)enumStatus
{
    switch (self.status.intValue) {
        case USER_NOTIFICATION_STATUS_READ:
            return USER_NOTIFICATION_STATUS_READ;

        case USER_NOTIFICATION_STATUS_UNREAD:
            return USER_NOTIFICATION_STATUS_UNREAD;
            
        default:
            return USER_NOTIFICATION_STATUS_READ;
    }
}

@end
