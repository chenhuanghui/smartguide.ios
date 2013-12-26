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
+(int) lastIDUser;
+(void) setLastIDUser:(int) idUser;
+(void) removeLastIDUser;
+(int) userCity;
+(void) setUserCity:(int) idCity;
+(bool) isShowedTutorial;
+(void) setIsShowedTutorial:(bool) isShowed;
+(bool) isShowedTutorialSlideList;
+(void) setIsShowedTutorialSlideList:(bool) isShowed;
+(bool) isShowedTutorialSlideShopDetail;
+(void) setIsShowedTutorialSlideShopDetail:(bool) isShowed;
+(bool) isShowedWelcomeScreen;
+(void) setIsShowedWelcomeScreen:(bool) isShowed;
+(bool) isUserReadTutorialPlace;
+(bool) isUserReadTutorialShopList;
+(bool) isUserReadTutorialStoreList;
+(void) setIsUserReadTutorialPlace:(bool) isRead;
+(void) setIsUserReadTutorialShopList:(bool) isRead;
+(void) setIsUserReadTutorialStoreList:(bool) isRead;


+(void) removeToken;

+(NSString*) keywordSearch;
+(void) setKeywordSearch:(NSString*) key;

@end