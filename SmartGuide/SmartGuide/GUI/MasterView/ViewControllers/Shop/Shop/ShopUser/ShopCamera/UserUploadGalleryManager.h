//
//  UserUploadGalleryManager.h
//  SmartGuide
//
//  Created by MacMini on 01/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserGalleryUpload.h"

@interface UserUploadGalleryManager : NSObject
{
    UserGalleryUpload *_currentUpload;
}

+(UserUploadGalleryManager*) shareInstance;
-(void) startUploads;

-(UserGalleryUpload*) addUploadWithIDShop:(int) idShop image:(UIImage*) image;
-(void) updateDesc:(UserGalleryUpload*) upload desc:(NSString*) desc;
-(void) cancelUpload:(UserGalleryUpload*) upload;

@end
