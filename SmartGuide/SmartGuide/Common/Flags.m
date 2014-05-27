//
//  Flags.m
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "Flags.h"
#import "Utility.h"
#import "Constant.h"

#define FLAG_FIRST_RUN @"flagFirstRun"
#define FLAG_ACCESS_TOKEN @"accessToken"
#define FLAG_REFRESH_TOKEN @"refreshToken"
#define FLAG_LAST_PHONE_USER @"lastPhoneUser"
#define FLAG_LAST_IDUSER @"lastIDUser"
#define FLAG_LAST_KEYWORD_SEARCH @"lastKeywordSearch"
#define FLAG_ACTIVE_CODE @"activeCode"
#define FLAG_USER_CITY @"userCity"
#define FLAG_FACEBOOK_TOKEN @"facebookToken"
#define FLAG_IS_SHOWED_TUTORIAL @"isShowedTutorial"
#define FLAG_IS_SHOWED_TURORIAL_SLIDE_LIST @"isShowedTurorialSlideList"
#define FLAG_IS_SHOWED_TURORIAL_SLIDE_SHOPDETAIL @"isShowedTutorialSlideShopDetail"
#define FLAG_IS_SHOWED_WELCOME_SCREEN @"isShowedWelcomeScreen"
#define FLAG_IS_READ_TUTORIAL_PLACE @"isReadTutorialPlace"
#define FLAG_IS_READ_TUTORIAL_SHOP_LIST @"isReadTutorialShopList"
#define FLAG_IS_READ_TUTORIAL_STORE_LIST @"isReadTutorialStoreList"
#define FLAG_IDCITY_SEARCH @"idCitySearch"

@implementation Flags

+(bool)isFirstRunApp
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:FLAG_FIRST_RUN])
    {
        return false;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@"x" forKey:FLAG_FIRST_RUN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return true;
}

+(void)setAccessToken:(NSString *)accessToken
{
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:FLAG_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)accessToken
{
    return [NSString stringWithStringDefault:[[NSUserDefaults standardUserDefaults] objectForKey:FLAG_ACCESS_TOKEN]];
}

+(void)setRefreshToken:(NSString *)refreshToken
{
    [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:FLAG_REFRESH_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)refreshToken
{
    return [NSString stringWithStringDefault:[[NSUserDefaults standardUserDefaults] objectForKey:FLAG_REFRESH_TOKEN]];
}

+(void)setActiveCode:(NSString *)activeCode
{
    [[NSUserDefaults standardUserDefaults] setObject:activeCode forKey:FLAG_ACTIVE_CODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)activeCode
{
    return [NSString stringWithStringDefault:[[NSUserDefaults standardUserDefaults] objectForKey:FLAG_ACTIVE_CODE]];
}

+(void)removeToken
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:FLAG_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:FLAG_REFRESH_TOKEN];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)setFacebookToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:FLAG_FACEBOOK_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)facebookToken
{
    return [NSString stringWithStringDefault:[[NSUserDefaults standardUserDefaults] objectForKey:FLAG_FACEBOOK_TOKEN]];
}

+(NSString*)lastPhoneUser
{
    return [NSString stringWithStringDefault:[[NSUserDefaults standardUserDefaults] objectForKey:FLAG_LAST_PHONE_USER]];
}

+(void)setLastPhoneUser:(NSString *)phoneUser
{
    [[NSUserDefaults standardUserDefaults] setObject:phoneUser forKey:FLAG_LAST_PHONE_USER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)lastIDUser
{
    id obj=[[NSUserDefaults standardUserDefaults] objectForKey:FLAG_LAST_IDUSER];
    if(obj)
        return [obj integerValue];
    
    return -1;
}

+(void)setLastIDUser:(int)idUser
{
    [[NSUserDefaults standardUserDefaults] setInteger:idUser forKey:FLAG_LAST_IDUSER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)removeLastIDUser
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:FLAG_LAST_IDUSER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)keywordSearch
{
    return [NSString stringWithStringDefault:[[NSUserDefaults standardUserDefaults] objectForKey:FLAG_LAST_KEYWORD_SEARCH]];
}

+(void)setKeywordSearch:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:key forKey:FLAG_LAST_KEYWORD_SEARCH];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)userCity
{
    return 1;
    id obj=[[NSUserDefaults standardUserDefaults] objectForKey:FLAG_USER_CITY];
    if(obj)
        return [obj integerValue];
    
    return -1;
}

+(void)setUserCity:(int)idCity
{
    idCity=1;
    [[NSUserDefaults standardUserDefaults] setInteger:idCity forKey:FLAG_USER_CITY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(bool)isShowedTutorial
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:FLAG_IS_SHOWED_TUTORIAL];
    if(obj)
        return [obj boolValue];
    
    return false;
}

+(void)setIsShowedTutorial:(bool)isShowed
{
    [[NSUserDefaults standardUserDefaults] setBool:isShowed forKey:FLAG_IS_SHOWED_TUTORIAL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(bool)isShowedTutorialSlideList
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:FLAG_IS_SHOWED_TURORIAL_SLIDE_LIST];
    if(obj)
        return [obj boolValue];
    
    return false;
}

+(void)setIsShowedTutorialSlideList:(bool)isShowed
{
    [[NSUserDefaults standardUserDefaults] setBool:isShowed forKey:FLAG_IS_SHOWED_TURORIAL_SLIDE_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_FINISHED_TUTORIAL_SLIDE_LIST object:nil];
}

+(bool)isShowedTutorialSlideShopDetail
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:FLAG_IS_SHOWED_TURORIAL_SLIDE_SHOPDETAIL];
    if(obj)
        return [obj boolValue];
    
    return false;
}

+(void)setIsShowedTutorialSlideShopDetail:(bool)isShowed
{
    [[NSUserDefaults standardUserDefaults] setBool:isShowed forKey:FLAG_IS_SHOWED_TURORIAL_SLIDE_SHOPDETAIL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(bool)isShowedWelcomeScreen
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:FLAG_IS_SHOWED_WELCOME_SCREEN];
    if(obj)
        return [obj boolValue];
    
    return false;
}

+(void)setIsShowedWelcomeScreen:(bool)isShowed
{
    [[NSUserDefaults standardUserDefaults] setBool:isShowed forKey:FLAG_IS_SHOWED_WELCOME_SCREEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(bool) isUserReadTutorialPlace
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:FLAG_IS_READ_TUTORIAL_PLACE];
    if(obj)
        return [obj boolValue];
    
    return false;
}

+(bool) isUserReadTutorialShopList
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:FLAG_IS_READ_TUTORIAL_SHOP_LIST];
    if(obj)
        return [obj boolValue];
    
    return false;
}

+(bool) isUserReadTutorialStoreList
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:FLAG_IS_READ_TUTORIAL_STORE_LIST];
    if(obj)
        return [obj boolValue];
    
    return false;
}

+(void) setIsUserReadTutorialPlace:(bool) isRead
{
    [[NSUserDefaults standardUserDefaults] setBool:isRead forKey:FLAG_IS_READ_TUTORIAL_PLACE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void) setIsUserReadTutorialShopList:(bool) isRead
{
    [[NSUserDefaults standardUserDefaults] setBool:isRead forKey:FLAG_IS_READ_TUTORIAL_SHOP_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void) setIsUserReadTutorialStoreList:(bool) isRead
{
    [[NSUserDefaults standardUserDefaults] setBool:isRead forKey:FLAG_IS_READ_TUTORIAL_STORE_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSNumber *)idCitySearch
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:FLAG_IDCITY_SEARCH];
}

+(void)setIDCitySearch:(int)idCity
{
    [[NSUserDefaults standardUserDefaults] setInteger:idCity forKey:FLAG_IDCITY_SEARCH];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end