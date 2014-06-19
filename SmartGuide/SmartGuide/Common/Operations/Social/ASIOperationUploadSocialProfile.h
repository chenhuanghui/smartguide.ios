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

@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSNumber *errorCode;

@end
