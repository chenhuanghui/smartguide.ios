//
//  ASIOperationUpdateUserProfile.h
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUpdateUserProfile : ASIOperationPost

-(ASIOperationUpdateUserProfile*) initWithName:(NSString*) name cover:(NSData*) cover avatar:(NSString*) avatar avatarImage:(NSData*) avatarImage gender:(enum GENDER_TYPE) gender socialType:(enum SOCIAL_TYPE) socialType;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) NSString *avatar;
@property (nonatomic, readonly) NSString *cover;

@end
