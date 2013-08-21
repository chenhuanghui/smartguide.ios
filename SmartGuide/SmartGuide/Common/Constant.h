//
//  Constant.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#define VELOCITY_SLIDE 800.f

#define CLASS_NAME NSStringFromClass([self class])

#define FACEBOOK_PERMISSION @[@"email",@"publish_actions",@"user_about_me",@"user_birthday",@"user_work_history"]
#define FACEBOOK_APPID @"1391698407719065"
#define FACEBOOK_GET_PROFILE(accessToken,fields) [NSString stringWithFormat:@"https://graph.facebook.com/me/?fields=%@&access_token=%@",fields,accessToken]
#define CLIENT_ID @"1_orazuv2dl3k8ossssg8804o4kwksw8kwcskkk404w40gwcwws"
#define SECRET_ID @"4xvgf3r9dxs8k8g8o8k0gss0s0wc8so4g4wg40c8s44kgcwsks"

//#define SERVER_API @"http://192.168.1.102/rb-smartguide/web/app.php/api"
//#define SERVER_API @"http://192.168.1.5/app.php/api"
#define SERVER_API @"http://devapi.smartguide.vn/api"
#define SERVER_IP @"http://devapi.smartguide.vn"
#define SERVER_IP_MAKE (api) [NSString stringWithFormat:@"%@/%@",SERVER_IP,api]
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
#define API_UPLOAD_USER_GALLERY @"images/upload"
#define API_SHOP_PROMOTION_DETAIL @"shop/promotion/get"
#define API_USER_COLLECTION @"user/collection"
#define API_GET_ADS @"ads/get"
#define API_USER_LIKE_DISLIKE @"user/like"
#define API_SHOP_SEARCH @"shop/search"

#define API_GET_ACTIVE_CODE(phone) [NSString stringWithFormat:@"%@/user/activation?phone=%@",SERVER_IP,phone]
#define API_VERIFY_ACTIVE_CODE(phone,activeCode) [NSString stringWithFormat:@"%@/user/check?phone=%@&code=%@",SERVER_IP,phone,activeCode]
#define API_GET_TOKEN(phone,activeCode) [NSString stringWithFormat:@"%@/oauth/v2/token?grant_type=http://dev.smartguide.com/app_dev.php/grants/bingo&client_id=%@&client_secret=%@&phone=%@&code=%@",SERVER_IP,CLIENT_ID,SECRET_ID,phone,activeCode]

#define UIIMAGE_SHOP_PIN [UIImage imageNamed:@"pin.png"]
#define UIIMAGE_USER_PIN [UIImage imageNamed:@"icon_pin.png"]
#define UIIMAGE_IMAGE_EMPTY [UIImage imageNamed:@"no_image.png"]
#define UIIMAGE_IMAGE_ERROR [UIImage imageNamed:@"image_error.png"]

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

#define COLOR_BACKGROUND_APP_ALPHA(a) [UIColor colorWithRed:40.f/255 green:46.f/255 blue:58.f/255 alpha:a]
#define COLOR_BACKGROUND_APP COLOR_BACKGROUND_APP_ALPHA(1)

#define DURATION_NAVIGATION_PUSH 0.35f
#define DURATION_SHOW_MAP 0.5f
#define DURATION_SHOW_FILTER DURATION_SHOW_MAP
#define DURATION_SHOW_SETTING DURATION_SHOW_MAP
#define DURATION_SHOW_CATALOGUE DURATION_SHOW_MAP
#define DURATION_SLIDE_BOUNCING 3.f
#define DURATION_NAVI_ICON 0.5f
#define DURATION_NAVI_TITLE 0.7f
#define DURATION_SHOW_QRCODE_REWARD 0.5f
#define DURATION_SHOW_USER_GALLERY_IMAGE 0.5f
#define DURATION_ADS_CHANGE 10.f
#define DURATION_SHOW_SLIDE_QRCODE 0.5f
#define DURATION_SCORE 1.f
#define DURATION_SHOW_MENU_SHOP_DETAIL 0.25f
#define DURATION_SHOW_GALLERY_VIEW_INFO 0.5f

#define MAP_SPAN 1500

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