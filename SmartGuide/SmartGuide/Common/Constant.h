//
//  Constant.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "Flurry.h"
#import "SGData.h"

#define SMARTUIDE_VERSION ((NSString*)[[NSBundle mainBundle] infoDictionary][(NSString*)kCFBundleVersionKey])
#define VELOCITY_SLIDE 800.f

#define DEFAULT_USER_ID 1
#define DEFAULT_USER_ACCESS_TOKEN @"abc"
#define DEFAULT_USER_IDCITY 1

#define CLASS_NAME NSStringFromClass([self class])
#define DEALLOC_LOG NSLog(@"dealloc %@",CLASS_NAME);
#define CALL_DEALLOC_LOG -(void) dealloc{DEALLOC_LOG}

#define FACEBOOK_READ_PERMISSION @[@"basic_info",@"user_about_me",@"user_birthday",@"user_work_history",@"email"]
#define FACEBOOK_POST_TO_WALL_PERMISSION @"publish_actions"
#define FACEBOOK_PUBLISH_PERMISSION @[FACEBOOK_POST_TO_WALL_PERMISSION]
#define FACEBOOK_APPID @"642818172421223"
#define FACEBOOK_GET_PROFILE @"https://graph.facebook.com/me/"

static NSString * const kClientId = @"790158294934-p5pnscmrt4avj698ncvhp14fit0f4qvb.apps.googleusercontent.com";

#define TEXTFIELD_SEARCH_PLACEHOLDER_TEXT @"Tìm kiếm địa điểm"

#define BUILD_SOSMART 1

#define SERVER_API [[SGData shareInstance] serverAPI]
#define SERVER_IP [[SGData shareInstance] serverIP]

#define CLIENT_ID [[SGData shareInstance] clientID]
#define SECRET_ID [[SGData shareInstance] secrectID]
#define API_ELASTIC_AUTOCOMPLETE_NATIVE [[SGData shareInstance] elasticAPI]

#define SERVER_IP_MAKE(api) [NSString stringWithFormat:@"%@/%@",SERVER_IP,api]
#define SERVER_API_MAKE(api) [NSString stringWithFormat:@"%@/%@",SERVER_API,api]
#define SERVER_API_URL_MAKE(api) [NSURL URLWithString:SERVER_API_MAKE(api)]
#define SERVER_API_IMAGE SERVER_API_MAKE(@"photo/upload")
#define SERVER_API_UPLOAD_PROFILE_FACEBOOK SERVER_API_MAKE(@"user/info/update")

#define API_VERSION @"version"
#define API_CITY @"city/list"
#define API_GROUP_IN_CITY @"group"
#define API_SHOP_IN_GROUP(userID,cityID,groupID,pageIndex,userLat,userLong) [NSString stringWithFormat:@"promotion/%i/%i/%i/%i/%f/%f",userID,cityID,groupID,pageIndex,userLat,userLong]
#define API_SHOP_DETAIL @"shop/user_v3"
#define API_SHOP_IN_GROUP_POST @"shop/list"
#define API_SHOP_GALLERY @"images/gallery/get"
#define API_SHOP_USER_GALLERY @"images/user/get"
#define API_SHOP_COMMENTS @"comment/getShopComment"
#define API_SHOP_POST_COMMENT @"comment/postShopComment"
#define API_SHOP_PROMOTION_DETAIL @"shop/promotion/get"
#define API_USER_COLLECTION @"user/collection"
#define API_GET_ADS @"ads/get"
#define API_USER_LIKE_DISLIKE @"user/like"
#define API_GET_REWARDS @"reward/list"
#define API_GET_FEEDBACK @"get_feedback"
#define API_GET_SG @"score/get"
#define API_POST_FEEDBACK @"feedback"
#define API_GET_TOTAL_SP @"score/get"
#define API_UPDATE_USER_INFO @"user/sginfo/update"
#define API_UPLOAD_FB_ACCESS_TOKEN @"user/facebook/access_token"
#define API_GET_AVATARS @"user/avatar/get"
#define API_NOTIFICATIONS @"notification_v2"
#define API_STORE_ALL_STORE @"store/getAll"
#define API_STORE_GET_LIST @"store/getList"
#define API_STORE_GET_ITEMS @"store/getItem"
#define API_SHOP_SEARCH @"elastic/searchV2"
#define API_PLACELIST_GET_LIST @"placelist/getList"
#define API_PLACELIST_GET @"placelist/get"
#define API_PLACELIST_GET_DETAIL @"placelist/getDetail"
#define API_LOVE_SHOP @"user/loveShop"
#define API_AGREE_COMMENT @"user/agreeComment"
#define API_SHOP_DETAIL_INFO @"shop/detailinfo"
#define API_USER_HOME @"user/home"
#define API_GET_SHOP_LIST @"shop/getShopList"
#define API_USER_PROFILE @"user/profile"
#define API_USER_UPDATE_PROFILE @"user/updateProfile"
#define API_USER_UPLOAD_SOCIAL_PROFILE @"user/uploadSocialProfile"
#define API_USER_PLACELIST @"user/getPlacelist"
#define API_CREATE_PLACELIST @"placelist/create"
#define API_ADD_SHOP_PLACELISTS @"placelist/addShopPlacelists"
#define API_REMOVE_SHOP_PLACELISTS @"placelist/removeShop"
#define API_SOCIAL_SHARE @"social/share"
#define API_SCAN_CODE @"user/scanSGCode_v2"
#define API_USER_PROMOTION @"user/promotion"
#define API_USER_POST_PICTURE @"user/postpicture"
#define API_USER_UPLOAD_USER_GALLERY @"user/uploadUserGallery"
#define API_USER_UPLOAD_AVATAR @"user/uploadAvatar"
#define API_GET_SHOP_GALLERY @"images/getShopGallery"
#define API_GET_USER_GALLERY @"images/getUserGallery"
#define API_USER_NOTIFICATION_COUNT @"user/notification/count"
#define API_USER_NOTIFICATION_NEWEST @"user/notification/getNewest"
#define API_USER_NOTIFICATION_LIST_BY_SENDER @"user/notification/listBySender"
#define API_USER_NOTIFICATION_MARK_READ @"user/notification/markRead"
#define API_USER_NOTIFICATION_REMOVE @"user/notification/remove"
#define API_USER_NOTICE @"user/notice"
#define API_USER_NOTIFICATION_TOKEN @"user/notification/updateUUID"

#define API_GET_ACTIVE_CODE @"user/activation"
#define API_USER_CHECK @"user/check_v2"
#define API_GET_TOKEN @"oauth/v2/token"
#define API_REFRESH_TOKEN @"oauth/v2/token"

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
#define NOTIFICATION_USER_CHANGED_CITY_SEARCH @"UserChangedCitySearch"
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
#define NOTIFICATION_USER_NOTICE_FINISHED @"userNoticeFinished"
#define NOTIFICATION_USER_LOGIN @"userLogin"
#define NOTIFICATION_USER_LOGOUT @"userLogout"
#define NOTIFICATION_INFORY_LAUNCHED @"inforyLaunched"
#define NOTIFICATION_TOTAL_NOTIFICATION_CHANGED @"totalNotificationChanged"
#define NOTIFICATION_RECEIVED_REMOTE_NOTIFICATION @"receivedRemoteNotification"
#define NOTIFICATION_USER_CITY_CHANGED @"userCityChangedNotification"
#define NOTIFICATION_USER_REMOVE_NOTIFICATION @"userRemoteNotification" //userInfo: [idNotification,idSender]
#define NOTIFICATION_HOME_FINISHED_LOAD @"homeControllerFinishedLoadData"

#define COLOR_BACKGROUND_APP_ALPHA(a) [UIColor colorWithRed:40.f/255 green:46.f/255 blue:58.f/255 alpha:a]
#define COLOR_BACKGROUND_APP COLOR_BACKGROUND_APP_ALPHA(1)
#define COLOR_BACKGROUND_SHOP_SERIES [UIColor colorWithRed:57.f/255 green:55.f/255 blue:53.f/255 alpha:1]

#define QRCODE_BIG_HEIGHT 56
#define QRCODE_SMALL_HEIGHT 32
#define QRCODE_RAY_HEIGHT 7
#define STORE_RAY_HEIGHT 7

#define NEW_FEED_CELL_SPACING 15

#define DURATION_DEFAULT 0.3f
#define DURATION_NAVIGATION_PUSH 0.35f
#define DURATION_SHOW_MAP 0.3f
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
#define DURATION_PRESENT_VIEW_CONTROLLER 0.3f
#define DURATION_LOADING 1.f

#define MAP_SPAN 1000

#pragma mark FONTS

#define FONT_NAME_NORMAL @"Avenir-Roman"
#define FONT_NAME_BOLD @"Avenir-Heavy"
#define FONT_NAME_OBLIQUE @"Avenir-Oblique"

#define FONT_SIZE_NORMAL(fSize) [UIFont fontWithName:FONT_NAME_NORMAL size:fSize]
#define FONT_SIZE_BOLD(fSize) [UIFont fontWithName:FONT_NAME_BOLD size:fSize]
#define FONT_SIZE_OBLIQUE(fSize) [UIFont fontWithName:FONT_NAME_OBLIQUE size:fSize]

#define FONT_TOKEN FONT_SIZE_NORMAL(13)

enum SORT_STORE_SHOP_LIST_TYPE {
    SORT_STORE_SHOP_LIST_LATEST = 0,
    SORT_STORE_SHOP_LIST_TOP_SELLER = 1
    };

#define SHOP_PROMOTION_FILTER_KEY @"hasPromotion"
enum SHOP_PROMOTION_FILTER_TYPE{
    SHOP_PROMOTION_FILTER_HAS_PROMOTION = 1,
    SHOP_PROMOTION_FILTER_ALL = 0,
};

enum LIKE_STATUS {
    NOLIKE_NODISLIKE = 0,
    LIKE = 1,
    DISLIKE = 2,
};

enum SHOP_PROMOTION_TYPE {
    SHOP_PROMOTION_NONE = 0,
    SHOP_PROMOTION_KM1 = 1,
    SHOP_PROMOTION_KM2 = 2,
    };

enum SHOP_TYPE
{
    SHOP_TYPE_ALL = 0,
    SHOP_TYPE_FOOD = 1,
    SHOP_TYPE_CAFE = 2,
    SHOP_TYPE_HEALTH = 3,
    SHOP_TYPE_ENTERTAIMENT = 4,
    SHOP_TYPE_FASHION = 5,
    SHOP_TYPE_TRAVEL = 6,
    SHOP_TYPE_PRODUCTION = 7,
    SHOP_TYPE_EDUCATION = 8,
};

enum LOVE_STATUS
{
    LOVE_STATUS_NONE = 0,
    LOVE_STATUS_LOVED = 1
};
enum AGREE_STATUS
{
    AGREE_STATUS_NONE = 0,
    AGREE_STATUS_AGREED = 1
};

enum SORT_LIST {
    SORT_LIST_DISTANCE = 0,
    SORT_LIST_VIEW = 1,
    SORT_LIST_LOVE = 2,
    SORT_LIST_DEFAULT = 3
    };

enum SORT_SHOP_COMMENT {
    SORT_SHOP_COMMENT_TOP_AGREED = 0,
    SORT_SHOP_COMMENT_TIME = 1
};

enum SOCIAL_TYPE {
    SOCIAL_NONE = 0,
    SOCIAL_FACEBOOK = 1,
    SOCIAL_GOOGLEPLUS =2
    };

enum GENDER_TYPE {
    GENDER_NONE = -1,
    GENDER_FEMALE = 0,
    GENDER_MALE = 1
    };

enum CELL_POSITION
{
    CELL_POSITION_MIDDLE = 0,
    CELL_POSITION_TOP = 1,
    CELL_POSITION_BOTTOM = 2
};

enum NOTIFICATION_STATUS
{
    NOTIFICATION_STATUS_UNREAD=0,
    NOTIFICATION_STATUS_READ=1,
};

enum NOTIFICATION_ACTION_TYPE
{
    NOTIFICATION_ACTION_TYPE_UNKNOW=INT32_MAX,
    NOTIFICATION_ACTION_TYPE_CALL_API=0,
    NOTIFICATION_ACTION_TYPE_SHOP_USER=1,
    NOTIFICATION_ACTION_TYPE_SHOP_LIST=2,
    NOTIFICATION_ACTION_TYPE_POPUP_URL=3,
    NOTIFICATION_ACTION_TYPE_USER_SETTING=4,
    NOTIFICATION_ACTION_TYPE_USER_PROMOTION=5,
};

enum NOTIFICATION_ACTION_SHOP_LIST_TYPE
{
     NOTIFICATION_ACTION_SHOP_LIST_TYPE_IDPLACELIST=0,
     NOTIFICATION_ACTION_SHOP_LIST_TYPE_KEYWORDS=1,
     NOTIFICATION_ACTION_SHOP_LIST_TYPE_IDSHOPS=2,
};

@class ShopCatalog;
@protocol CatalogueBlockViewDelegate <NSObject>

-(void) catalogueBlockDidSelectedGroup:(ShopCatalog*) group;
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

@protocol GestureHandleDelegate <NSObject>

-(bool) gestureShouldBegin:(id) object ges:(UIGestureRecognizer*) ges;

@end

@protocol ScrollViewDelegate <UIScrollViewDelegate>

@optional
-(CGPoint) scrollViewWillChangeContentOffset:(UIScrollView*) scrollView contentOffset:(CGPoint) offset;

@end

@class SGViewController;

@protocol SGViewControllerDelegate <NSObject>

@optional
-(void) SGControllerLoadView:(SGViewController*) sgController;
-(void) SGControllerViewWillAppear:(SGViewController*) sgController;

@end

@protocol AuthorizationDelegate <SGViewControllerDelegate>

-(void) authorizationSuccessed;
-(void) authorizationCancelled;

@end