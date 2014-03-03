//
//  ASIOperationUploadSocialProfile.h
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUploadSocialProfile : ASIOperationPost

-(ASIOperationUploadSocialProfile*) initWithProfile:(NSString*) profile socialType:(enum SOCIAL_TYPE) socialType accessToken:(NSString*) accessToken;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) int errorCode;

@end
