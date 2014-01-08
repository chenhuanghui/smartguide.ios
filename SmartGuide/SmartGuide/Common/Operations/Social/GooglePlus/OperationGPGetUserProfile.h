//
//  OperationGPGetUserProfile.h
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationGPGetUserProfile : OperationURL

-(OperationGPGetUserProfile*) initWithAccessToken:(NSString*) accessToken clientID:(NSString*) clientID;

@property (nonatomic, readonly) NSString *jsonData;

@end
