//
//  Flags.h
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flags : NSObject

+(bool) isFirstRunApp;
+(NSString*) accessToken;
+(void) setAccessToken:(NSString*) accessToken;
+(NSString*) refreshToken;
+(void) setRefreshToken:(NSString*) refreshToken;
+(NSString*) activeCode;
+(void) setActiveCode:(NSString*) activeCode;
+(NSString*) facebookToken;
+(void) setFacebookToken:(NSString*) token;
+(NSString*) lastPhoneUser;
+(void) setLastPhoneUser:(NSString*) phoneUser;

+(NSString*) keywordSearch;
+(void) setKeywordSearch:(NSString*) key;

@end