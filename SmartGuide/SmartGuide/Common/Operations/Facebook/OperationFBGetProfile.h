//
//  OperationFBGetProfile.h
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

@class FBProfile;

@interface OperationFBGetProfile : OperationURL
{
    NSString *_accessToken;
}

-(OperationFBGetProfile*) initWithAccessToken:(NSString*) accessToken;

@property (nonatomic, readonly) FBProfile *profile;

@end

@interface FBProfile : NSObject<NSCopying>

@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fbID;
@property (nonatomic, strong) NSString *token;

-(bool) sex;

@end