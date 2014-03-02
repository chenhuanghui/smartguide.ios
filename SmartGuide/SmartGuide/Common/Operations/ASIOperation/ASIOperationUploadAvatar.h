//
//  ASIOperationUploadAvatar.h
//  SmartGuide
//
//  Created by MacMini on 02/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUploadAvatar : ASIOperationPost

-(ASIOperationUploadAvatar*) initWithAvatar:(NSData*) avatarBinary userLat:(double) userLat userLng:(double) userLng;

-(double) userLat;
-(double) userLng;

@property (nonatomic, readonly) int status;
@property (nonatomic, strong) NSString *avatar;

@end
