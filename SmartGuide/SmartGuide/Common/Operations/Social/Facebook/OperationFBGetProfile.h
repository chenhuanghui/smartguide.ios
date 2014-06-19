//
//  OperationFBGetProfile.h
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class FBProfile;

@interface OperationFBGetProfile : ASIOperationPost
{
}

-(OperationFBGetProfile*) initWithAccessToken:(NSString*) accessToken;

@property (nonatomic, strong) NSString *jsonData;

@end