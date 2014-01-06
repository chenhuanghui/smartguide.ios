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

+(User *)userWithIDUser:(int)idUser
{
    return [User queryUserObject:[NSPredicate predicateWithFormat:@"%K == %i",User_IdUser,idUser]];
}

+(User *)makeWithDictionary:(NSDictionary *)dict
{
    int idUser=[[NSNumber numberWithObject:dict[@"idUser"]] integerValue];
    User *user=[User userWithIDUser:idUser];
    if(!user)
    {
        user=[User insert];
        user.idUser=@(idUser);
    }
    
    user.name=[NSString stringWithStringDefault:dict[@"name"]];
    user.gender=[NSNumber numberWithObject:dict[@"gender"]];
    user.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    user.avatar=[NSString stringWithStringDefault:dict[@"avatar"]];
    user.phone=[NSString stringWithStringDefault:dict[@"phone"]];
    user.socialType=[NSNumber numberWithObject:dict[@"socialType"]];
    
    return user;
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
