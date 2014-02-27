//
//  GooglePlusManager.h
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface GooglePlusManager : NSObject

+(GooglePlusManager*) shareInstance;

@property (nonatomic, strong) GTMOAuth2Authentication *authentication;

@end
