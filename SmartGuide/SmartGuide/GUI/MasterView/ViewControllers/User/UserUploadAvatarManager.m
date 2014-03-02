//
//  UserUploadAvatarManager.m
//  SmartGuide
//
//  Created by MacMini on 02/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserUploadAvatarManager.h"
#import "Utility.h"

#define AVATAR_TEMP_PATH [avatarPath() stringByAppendingPathComponent:@"userAvatarTemp"]

@interface UserUploadAvatarManager()<ASIOperationPostDelegate>

@end

static UserUploadAvatarManager* _userUploadAvatarManager=nil;
@implementation UserUploadAvatarManager

+(UserUploadAvatarManager *)shareInstance
{
    if(!_userUploadAvatarManager)
        _userUploadAvatarManager=[UserUploadAvatarManager new];
    
    return _userUploadAvatarManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)startUploads
{
    if([[NSFileManager defaultManager] fileExistsAtPath:AVATAR_TEMP_PATH])
    {
        NSData *data=[NSData dataWithContentsOfFile:AVATAR_TEMP_PATH];
        
        double userLat=-1;
        double userLng=-1;
        NSString *lat_lng=[[NSUserDefaults standardUserDefaults] stringForKey:@"userAvatarTemp"];
        
        if(lat_lng.length>0)
        {
            NSArray *array=[lat_lng componentsSeparatedByString:@"&"];
            userLat=[array[0] doubleValue];
            userLng=[array[1] doubleValue];
        }
        
        [self uploadAvatar:data userLat:userLat userLng:userLng];
    }
}

-(void)uploadAvatar:(NSData *)avatar userLat:(double)userLat userLng:(double)userLng
{
    if(_operationUploadAvatar)
    {
        [_operationUploadAvatar clearDelegatesAndCancel];
        _operationUploadAvatar=nil;
    }
    
    NSError *error=nil;
    [avatar writeToFile:AVATAR_TEMP_PATH options:NSDataWritingAtomic error:&error];
    
    if(error)
        NSLog(@"avatarTemp error %@",error);
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f&%f",userLat,userLng] forKey:@"userAvatarTemp"];
        
    }
    
    _operationUploadAvatar=[[ASIOperationUploadAvatar alloc] initWithAvatar:avatar userLat:userLat userLng:userLng];
    _operationUploadAvatar.delegatePost=self;
    _operationUploadAvatar.fScreen=@"background";
    
    [_operationUploadAvatar startAsynchronous];
}

-(void)cancelUpload
{
    //Chưa up hình xong nhưng user cập nhật lại hình bằng 1 hình từ list avatar
    
    if(_operationUploadAvatar)
    {
        [_operationUploadAvatar clearDelegatesAndCancel];
        _operationUploadAvatar=nil;
    }
    
    [[NSFileManager defaultManager] removeItemAtPath:AVATAR_TEMP_PATH error:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userAvatarTemp"];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUploadAvatar class]])
    {
        ASIOperationUploadAvatar *ope=(ASIOperationUploadAvatar*) operation;
        
        if(ope.status==1)
        {
            currentUser().avatar=ope.avatar;
            
            [[DataManager shareInstance] save];
            
            [[NSFileManager defaultManager] removeItemAtPath:AVATAR_TEMP_PATH error:nil];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userAvatarTemp"];
        }
        
        _operationUploadAvatar=nil;
    }
}


-(void) ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUploadAvatar class]])
    {
        _operationUploadAvatar=nil;
    }
}

-(NSString *)avatarTempPath
{
    if([[NSFileManager defaultManager] fileExistsAtPath:AVATAR_TEMP_PATH])
        return AVATAR_TEMP_PATH;
    
    return @"";
}

@end
