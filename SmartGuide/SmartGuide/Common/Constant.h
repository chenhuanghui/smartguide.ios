//
//  Constant.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "Flurry.h"

#define SMARTUIDE_VERSION @"1"
#define VELOCITY_SLIDE 800.f

#define CLASS_NAME NSStringFromClass([self class])

#define FACEBOOK_READ_PERMISSION @[@"basic_info",@"user_about_me",@"user_birthday",@"user_work_history",@"email"]
#define FACEBOOK_PUBLISH_PERMISSION @[@"publish_actions"]
#define FACEBOOK_APPID @"1391698407719065"
#define FACEBOOK_GET_PROFILE(accessToken,fields) [NSString stringWithFormat:@"https://graph.facebook.com/me/?fields=%@&access_token=%@",fields,accessToken]
//#define CLIENT_ID @"1_orazuv2dl3k8ossssg8804o4kwksw8kwcskkk404w40gwcwws"//dev
#define CLIENT_ID @"1_407qlmrvr5esg8s8wkocw8wgog84kkk40o8k00oososgcs8sc4"//dev2
//#define CLIENT_ID @"1_53obx9yqlcco80w8wkoowgccw44o0w0ook0okogwosg84wscg8"//product
//#define SECRET_ID @"4xvgf3r9dxs8k8g8o8k0gss0s0wc8so4g4wg40c8s44kgcwsks"//dev
#define SECRET_ID @"1jcvy0kw4tk0o4wcgcos8s84kssw08c0w8w04c0k08gwc48cks"//dev2
//#define SECRET_ID @"t3p0k1rvstcgwcsggo8ossgcwo8cckso88sscgcsks8w0wsk8"//product

//#define SERVER_API @"http://192.168.1.102/rb-smartguide/web/app.php/api"
//#define SERVER_API @"http://192.168.1.5/app.php/api"
#define SERVER_API @"http://dev2.smartguide.vn/api"
#define SERVER_IP @"http://dev2.smartguide.vn"
//#define SERVER_API @"https://api.smartguide.vn/api"
//#define SERVER_IP @"https://api.smartguide.vn"
#define SERVER_IP_MAKE(api) [NSString stringWithFormat:@"%@/%@",SERVER_IP,api]
#define SERVER_API_MAKE(api) [NSString stringWithFormat:@"%@/%@",SERVER_API,api]
#define SERVER_API_IMAGE SERVER_API_MAKE(@"photo/upload")
#define SERVER_API_UPLOAD_PROFILE_FACEBOOK SERVER_API_MAKE(@"user/info/update")

#define API_VERSION @"version"
#define API_CITY @"city/list"
#define API_GROUP_IN_CITY @"group"
#define API_SHOP_IN_GROUP(userID,cityID,groupID,pageIndex,userLat,userLong) [NSString stringWithFormat:@"promotion/%i/%i/%i/%i/%f/%f",userID,cityID,groupID,pageIndex,userLat,userLong]
#define API_SHOP_DETAIL @"shop/user"
#define API_SHOP_IN_GROUP_POST @"shop/list"
#define API_SHOP_GALLERY @"images/gallery/get"
#define API_SHOP_USER_GALLERY @"images/user/get"
#define API_SHOP_COMMENTS @"comment/get"
#define API_SHOP_POST_COMMENT @"comment/post"
#define API_GET_SGP @"user/get/promotion1/point"
#define API_GET_REWARD @"user/get/promotion2"
#define API_SGP_TO_REWARD @"user/get/promotion1/award"
#define API_SG_TO_REWARD @"reward/receive"
#define API_UPLOAD_USER_GALLERY @"images/upload"
#define API_SHOP_PROMOTION_DETAIL @"shop/promotion/get"
#define API_USER_COLLECTION @"user/collection"
#define API_GET_ADS @"ads/get"
#define API_USER_LIKE_DISLIKE @"user/like"
#define API_SHOP_SEARCH @"shop/search"
#define API_GET_REWARDS @"reward/list"
#define API_GET_FEEDBACK @"get_feedback"
#define API_GET_SG @"score/get"
#define API_POST_FEEDBACK @"feedback"
#define API_GET_TOTAL_SP @"score/get"
#define API_UPDATE_USER_INFO @"user/sginfo/update"
#define API_UPLOAD_FB_ACCESS_TOKEN @"user/facebook/access_token"
#define API_GET_AVATARS @"user/avatar/get"
#define API_NOTIFICATIONS(accessToken,version) [NSString stringWithFormat:@"notification?access_token=%@&version=%@",accessToken,version]

#define API_GET_ACTIVE_CODE(phone) [NSString stringWithFormat:@"%@/user/activation?phone=%@",SERVER_IP,phone]
#define API_VERIFY_ACTIVE_CODE(phone,activeCode) [NSString stringWithFormat:@"%@/user/check?phone=%@&code=%@",SERVER_IP,phone,activeCode]
#define API_GET_TOKEN(phone,activeCode) [NSString stringWithFormat:@"%@/oauth/v2/token?grant_type=http://dev.smartguide.com/app_dev.php/grants/bingo&client_id=%@&client_secret=%@&phone=%@&code=%@",SERVER_IP,CLIENT_ID,SECRET_ID,phone,activeCode]

#define UIIMAGE_LOADING_SHOP_LOGO [UIImage imageNamed:@"ava_loading.png"]
#define UIIMAGE_LOADING_AVATAR [UIImage imageNamed:@"ava_default.png"]
#define UIIMAGE_LOADING_AVATAR_COMMENT UIIMAGE_LOADING_AVATAR
#define UIIMAGE_LOADING_SHOP_COVER [UIImage imageNamed:@"cover_loading.png"]
#define UIIMAGE_LOADING_SHOP_GALLERY UIIMAGE_LOADING_SHOP_LOGO
#define UIIMAGE_LOADING_REWARD [UIImage imageNamed:@"gift_reward.png"]

#define UIIMAGE_SHOP_PIN [UIImage imageNamed:@"pin.png"]
#define UIIMAGE_USER_PIN [UIImage imageNamed:@"icon_pin.png"]

#define NOTIFICATION_LOGIN @"UserLogin"
#define NOTIFICATION_LOGOUT @"UserLogout"
#define NOTIFICATION_LOCATION_AUTHORIZE_CHANGED @"LocationAuthorizeChanged"
#define NOTIFICATION_LOCATION_CITY_AVAILABLE @"UserCityAvailable"
#define NOTIFICATION_LOCATION_AVAILABLE @"UserLocationAvailable"
#define NOTIFICATION_LOCATION_PERMISSION_DENIED @"PermissionLocationDenied"
#define NOTIFICATION_ANNOUNCEMENT_HIDED @"AnnouncementHided"
#define NOTIFICATION_ANNOUNCEMENT_TOUCHED @"AnnouncementTouched"
#define NOTIFICATION_ANNOUNCEMENT_SHOWED @"AnnouncemtnShowed"
#define NOTIFICATION_DETECTED_USER_CITY @"DetectedUserCity"
#define NOTIFICATION_USER_CHANGED_CITY @"UserChangedCity"
#define NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED @"FacebookMiningFinished"
#define NOTIFICATION_FILTER_CHANGED @"FilterChanged"
#define NOTIFICATION_GET_SGP @"GetSGP"
#define NOTIFICATION_GET_REWARD @"GetReward"
#define NOTIFICATION_REFRESH_TOKEN_FAILED @"refreshTokenFailed"
#define NOTIFICATION_REFRESH_TOKEN_SUCCESS @"refreshTokenSuccess"
#define NOTIFICATION_USER_POST_PICTURE @"userPostPicture"
#define NOTIFICATION_USER_SCANED_QR_CODE @"userScanedQRCode"
#define NOTIFICATION_USER_CANCELED_SCAN_QR_CODE @"userCanceledQRCode"
#define NOTIFICATION_SCORE_FINISHED @"animationScoreFinished"
#define NOTIFICATION_FACEBOOK_LOGIN_SUCCESS @"facebookLoginedSuccess"
#define NOTIFICATION_FACEBOOK_LOGIN_FAILED @"facebookLoginedFailed"
#define NOTIFICATION_LOADING_SCREEN_FINISHED @"loadingScreenFinished"
#define NOTIFICATION_CATALOGUEBLOCK_FINISHED @"catalogueBlockFinished"
#define NOTIFICATION_CATALOGUE_LIST_FINISHED @"catalogueListFinished"
#define NOTIFICATION_SHOPDETAIL_LOAD_FINISHED @"shopDetailLoadFinished"
#define NOTIFICATION_USER_FINISHED_TUTORIAL_SLIDE_LIST @"userFinishedReadTutorial"
#define NOTIFICATION_USER_FINISHED_READ_FIRST_TUTORIAL @"userFinishedReadFirstTutorial"
#define NOTIFICATION_USER_UPDATED_INFO @"userUpdatedInfo"

#define COLOR_BACKGROUND_APP_ALPHA(a) [UIColor colorWithRed:40.f/255 green:46.f/255 blue:58.f/255 alpha:a]
#define COLOR_BACKGROUND_APP COLOR_BACKGROUND_APP_ALPHA(1)

#define DURATION_DEFAULT 0.3f
#define DURATION_NAVIGATION_PUSH 0.35f
#define DURATION_SHOW_MAP 0.5f
#define DURATION_SHOW_FILTER DURATION_SHOW_MAP
#define DURATION_SHOW_SETTING DURATION_SHOW_MAP
#define DURATION_SHOW_CATALOGUE DURATION_SHOW_MAP
#define DURATION_SLIDE_BOUNCING 3.f
#define DURATION_NAVI_ICON 0.5f
#define DURATION_NAVI_TITLE 0.7f
#define DURATION_SHOW_QRCODE_REWARD 0.5f
#define DURATION_SHOW_USER_GALLERY_IMAGE DURATION_DEFAULT
#define DURATION_ADS_CHANGE 10.f
#define DURATION_SHOW_SLIDE_QRCODE 0.3f
#define DURATION_SCORE 1.f
#define DURATION_SHOW_MENU_SHOP_DETAIL 0.25f
#define DURATION_SHOW_GALLERY_VIEW_INFO 0.5f
#define DURATION_SETTING 0.2f

#define MAP_SPAN 3000

enum SORT_BY {
    SORT_DISTANCE = 0,
    SORT_VISITED = 1,
    SORT_LIKED = 2,
    SORT_POINT = 3,
    SORT_REWARD = 4,
};

enum LIKE_STATUS {
    NOLIKE_NODISLIKE = 0,
    LIKE = 1,
    DISLIKE = 2,
};

@class Group;
@protocol CatalogueBlockViewDelegate <NSObject>

-(void) catalogueBlockDidSelectedGroup:(Group*) group;
-(void) catalogueBlockUpdated;

@end

@protocol NavigationViewControllerDelegate <UINavigationControllerDelegate>

@optional
-(void)navigationController:(UINavigationController*) navigationController presentModalViewController:(UIViewController*) viewController;

@end

@class CatalogueListViewController;
@protocol CatalogueListViewDelegate <NSObject>

-(void) catalogueListLoadShopFinished:(CatalogueListViewController*) catalogueListView;

@end