#import "User.h"
#import "Filter.h"
#import "Constant.h"
#import "Flags.h"

@implementation User
@synthesize location,idCity,city;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.location=CLLocationCoordinate2DMake(-1, -1);
    
    return self;
}

+(User *)userWithIDUser:(int)idUser
{
    NSArray *arr=[User allObjects];
    
    if(arr.count>0)
        return [arr objectAtIndex:0];
    
    return nil;
}

-(NSString *)title
{
    return @"You here";
}

-(CLLocationCoordinate2D)coordinate
{
    return self.location;
}

-(enum SORT_BY)currentSort
{
    if(self.filter)
    {
        if(self.filter.mostGetPoint.boolValue)
            return SORT_POINT;
        else if(self.filter.mostGetReward.boolValue)
            return SORT_REWARD;
        else if(self.filter.mostLike.boolValue)
            return SORT_LIKED;
        else if(self.filter.mostView.boolValue)
            return SORT_VISITED;
        else if(self.filter.distance.boolValue)
            return SORT_DISTANCE;
    }
    
    return SORT_DISTANCE;
}

-(NSNumber *)idUser
{
    return @([Flags lastIDUser]);
}

-(void)setIdUser:(NSNumber *)num
{
    [Flags setLastIDUser:num.integerValue];
}

-(NSNumber *)isConnectedFacebook1
{
    return @(false);
}

-(NSString *)name1
{
    return @"";
}

-(bool)isUserDefault
{
    return self.idUser.integerValue==DEFAULT_USER_ID;
}

@end
