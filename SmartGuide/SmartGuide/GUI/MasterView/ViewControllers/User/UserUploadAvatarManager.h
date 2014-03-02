//
//  UserUploadAvatarManager.h
//  SmartGuide
//
//  Created by MacMini on 02/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIOperationUploadAvatar.h"

@interface UserUploadAvatarManager : NSObject
{
    ASIOperationUploadAvatar *_operationUploadAvatar;
}

+(UserUploadAvatarManager*) shareInstance;

-(void) startUploads;

-(void) uploadAvatar:(NSData*) avatar userLat:(double) userLat userLng:(double) userLng;
-(void) cancelUpload;
-(NSString*) avatarTempPath;

@end
