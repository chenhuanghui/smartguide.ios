#import "User.h"
#import "Constant.h"
#import "Flags.h"
#import "TokenManager.h"

@implementation User

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    _location=CLLocationCoordinate2DMake(-1, -1);
    
    return self;
}

-(NSString *)title
{
    return @"You here";
}

-(CLLocationCoordinate2D)coordinate
{
    return _location;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _location=newCoordinate;
}

-(NSNumber *)idUser
{
    return @([Flags lastIDUser]);
}

-(void)setIdUser:(NSNumber *)num
{
    [Flags setLastIDUser:num.integerValue];
}

-(bool)save
{
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

-(enum GENDER_TYPE)enumGender
{
    switch (self.gender.integerValue) {
        case 0:
            return GENDER_FEMALE;
            
        case 1:
            return GENDER_MALE;
            
        default:
            return GENDER_NONE;
    }
}

-(bool)isDefaultUser
{
    return [[self accessToken] isEqualToString:DEFAULT_USER_ACCESS_TOKEN];
}

-(NSString *)accessToken
{
    return [[TokenManager shareInstance] accessToken];
}

-(enum USER_DATA_MODE)enumDataMode
{
    if([self isDefaultUser])
        return USER_DATA_TRY;
    else if([self.name stringByTrimmingWhiteSpace].length==0 || [self.avatar stringByTrimmingWhiteSpace].length==0)
        return USER_DATA_CREATING;
    else
        return USER_DATA_FULL;
}

@end
