#import "User.h"
#import "Constant.h"
#import "Flags.h"
#import "TokenManager.h"
#import "ImageManager.h"
#import "UserUploadAvatarManager.h"

@implementation User

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    return self;
}

+(User *)userWithIDUser:(int)idUser
{
    return [User queryUserObject:[NSPredicate predicateWithFormat:@"%K == %i",User_IdUser,idUser]];
}

+(User *)makeWithDictionary:(NSDictionary *)dict
{
    int idUser=[[NSNumber makeNumber:dict[@"idUser"]] integerValue];
    User *user=[User userWithIDUser:idUser];
    if(!user)
    {
        user=[User insert];
        user.idUser=@(idUser);
    }
    
    user.name=[NSString makeString:dict[@"name"]];
    user.gender=[NSNumber makeNumber:dict[@"gender"]];
    user.cover=[NSString makeString:dict[@"cover"]];
    user.avatar=[NSString makeString:dict[@"avatar"]];
    user.phone=[NSString makeString:dict[@"phone"]];
    user.socialType=[NSNumber makeNumber:dict[@"socialType"]];
    user.birthday=[NSString makeString:dict[@"dob"]];
    user.idCity=[NSNumber makeNumber:dict[@"idCity"]];
    
    if(user.idCity.integerValue==0)
        user.idCity=@(IDCITY_HCM());
    
    return user;
}

-(NSString *)title
{
    return @"You here";
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
    return self.idUser.integerValue==DEFAULT_USER_ID;
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

-(enum SOCIAL_TYPE)enumSocialType
{
    switch (self.socialType.integerValue) {
        case SOCIAL_FACEBOOK:
            return SOCIAL_FACEBOOK;
            
        case SOCIAL_GOOGLEPLUS:
            return SOCIAL_GOOGLEPLUS;
            
        default:
            return SOCIAL_NONE;
    }
}

-(NSString*) avatarPath
{
    if([[UserUploadAvatarManager shareInstance] avatarTempPath].length>0)
    {
        return [[UserUploadAvatarManager shareInstance] avatarTempPath];
    }
    
    NSString *path=self.avatar;
    path=[path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    return [avatarPath() stringByAppendingPathComponent:path];
}

-(NSString*) avatarBlurPath
{
    if([[UserUploadAvatarManager shareInstance] avatarTempPath].length>0)
    {
        return [[[UserUploadAvatarManager shareInstance] avatarTempPath] stringByAppendingString:@"blur"];
    }
    
    NSString *path=[self.avatar stringByAppendingString:@"blur"];
    path=[path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    return [avatarPath() stringByAppendingPathComponent:path];
}

-(UIImage *)avatarImage
{
    if([self avatarPath]>0)
    {
        NSString *path=[self avatarPath];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
            return [UIImage imageWithContentsOfFile:path];
    }
    
    return nil;
}

-(UIImage *)avatarBlurImage
{
    if([self avatarPath].length>0)
    {
        NSString *path=[self avatarBlurPath];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
            return [UIImage imageWithContentsOfFile:path];
    }
    
    return nil;
}

-(void)makeAvatarImage:(UIImage *)image
{
    if([self avatarPath].length>0)
    {
        NSData *data=UIImageJPEGRepresentation(image, 1);
        
        NSError *error=nil;
        [data writeToFile:[self avatarPath] options:NSDataWritingAtomic error:&error];
    }
}

-(UIImage*) makeAvatarBlurImage:(UIImage *)image isEffected:(bool)isEffected
{
    if([self avatarPath].length>0)
    {
        UIImage *img=image;
        NSData *data=nil;
        if(isEffected)
            data=UIImageJPEGRepresentation(img, 1);
        else
        {
            img=[[image blur] convertToGrayscale];
            data=UIImageJPEGRepresentation(img, 1);
        }
        
        NSError *error=nil;
        [data writeToFile:[self avatarBlurPath] options:NSDataWritingAtomic error:&error];
        return img;
    }
    
    return nil;
}

@end

@implementation UIImageView(SupportLoadAvatar)

-(void)loadUserAvatar:(User *)user onCompleted:(void (^)(UIImage *, UIImage *))completed
{
    UIImage *img=[user avatarImage];
    
    __block void(^_completed)(UIImage*,UIImage*)=nil;
    
    if(completed)
        _completed=[completed copy];
    
    if(img)
    {
        self.image=img;
        
        if(_completed)
        {
            _completed(img,[user avatarBlurImage]);
            _completed=nil;
        }
    }
    else
    {
        [self loadAvatarWithURL:user.avatar completed:^(UIImage *avatar, NSError *error, SDImageCacheType cacheType) {
            
            if(avatar)
            {
                NSError *error=nil;
                NSArray *avatars=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:avatarPath() error:&error];
                
                if(!error && avatars && avatars.count>0)
                {
                    for(NSString *path in avatars)
                    {
                        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
                    }
                }
                
                [user makeAvatarImage:avatar];
                UIImage *blur=[user makeAvatarBlurImage:avatar isEffected:false];
                
                if(_completed)
                {
                    _completed(avatar,blur);
                    _completed=nil;
                }
            }
            else
            {
                if(_completed)
                {
                    _completed(nil,nil);
                    _completed=nil;
                }
            }
            
        }];
    }
}

@end