//
//  ASIOperationFBProfile.h
//  SmartGuide
//
//  Created by XXX on 7/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class FBProfile;

@interface ASIOperationFBProfile : ASIOperationPost
{
}

-(ASIOperationFBProfile*) initWithFBProfile:(FBProfile*) profile;

@property (nonatomic, readonly) bool isSuccessed;

@end