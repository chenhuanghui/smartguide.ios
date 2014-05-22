//
//  ASIOperationUpdateUserProfile.h
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUpdateUserProfile : ASIOperationPost

-(ASIOperationUpdateUserProfile*) initWithName:(NSString*) name avatar:(NSString*) avatar gender:(enum GENDER_TYPE) gender socialType:(enum SOCIAL_TYPE) socialType birthday:(NSString*) birthday idCity:(int) idCity;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *message;

@end
