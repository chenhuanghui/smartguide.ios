#import "User.h"
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
