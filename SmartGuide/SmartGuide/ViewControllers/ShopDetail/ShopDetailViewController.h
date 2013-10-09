//
//  ShopDetailViewController.h
//  SmartGuide
//
//  Created by Khanh Bao Ha Trinh on 7/28/13.
//  Copyright (c) 2013 Khanh Bao Ha Trinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Shop.h"
#import "ASIOperationShopDetail.h"
#import "ASIOperationUploadUserGallery.h"
#import "ASIOperationPromotionDetail.h"
#import "ASIOperationLikeDislikeShop.h"
#import "THLabel.h"
#import "ButtonImageLeft.h"

enum SHOP_MENU_DIRECTION {
    MENU_FIRST = 0,
    MENU_LEFT_TO_RIGHT = 1,
    MENU_RIGHT_TO_LEFT = 2
};

enum SHOP_MENU_TYPE {
    MENU_INFO = 0,
    MENU_MENU = 1,
    MENU_PICTURE = 3,
    MENU_COMMENT = 4,
    MENU_MAP = 5,
};

enum SHOP_DETAIL_MODE {
    SHOPDETAIL_FROM_LIST = 0,
    SHOPDETAIL_FROM_MAP = 1,
    SHOPDETAIL_FROM_COLLECTION=2,
};

@class ShopInfo,ShopMenu,ShopPicture,PromotionDetailType1View,ShopMenuView,ShopComment,PromotionDetailType2View,ShopLocation,ShopDetailViewController;

@protocol ShopViewHandle <NSObject>
@property (nonatomic, assign) bool isProcessedData;
@property (nonatomic, assign) ShopDetailViewController *handler;

//Tat ca trang dau tien da duoc tra ve trong shop detail

-(void) processFirstDataBackground:(NSMutableArray*) firstData;
-(void) cancel;
-(void) reset;

@end

@protocol PromotionDetailHandle <NSObject>
@property (nonatomic, assign) ShopDetailViewController *handler;

-(void) reloadWithShop:(Shop*) shop;
-(void) reset;
-(void) showLoadingWithTitle:(NSString*) title;
-(void) removeLoading;

@end

@interface ShopDetailViewController : ViewController<ASIOperationPostDelegate,UINavigationControllerDelegate>
{
    __weak IBOutlet UIImageView *imgvCover;
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UIView *viewContaint;
    __weak IBOutlet UIView *rootView;
    __weak IBOutlet UIImageView *bgMenu;
    __weak IBOutlet UIImageView *pick;
    __weak IBOutlet UIImageView *imgvSwitch;
    __weak IBOutlet UIButton *btnLike;
    __weak IBOutlet ButtonImageLeft *btnDislike;
    __weak IBOutlet THLabel *lblName;
    __weak IBOutlet UIButton *btnPromotion;
    __weak IBOutlet UIButton *btnInfo;
    __weak IBOutlet UIButton *btnMenu;
    __weak IBOutlet UIButton *btnGallery;
    __weak IBOutlet UIButton *btnComment;
    __weak IBOutlet UIButton *btnMap;
    __weak IBOutlet UIButton *btnShop;
    __weak IBOutlet UIView *buttonsContaint;
    __weak IBOutlet UIView *blurCover;
    __weak IBOutlet UIImageView *imgvBtnHover;
    
    bool _isShowedShopMenu;
    bool _isAnimationMenu;
    int _lastTag;
    
    __strong Shop* _shop;
    ASIOperationShopDetail *_operationShopDetail;
    ASIOperationLikeDislikeShop *_operationLikeDislike;
    NSNumberFormatter *_likeDislikeFormat;
    
    bool _isStartedLoad;
    bool _isLoadedViews;
    
    UIImageView *imgvTutorial;
    UIImageView *imgvTutorialText;
    bool _isSelfLoaded;
    bool _isAnimationMoveView;
}

-(void) setShop:(Shop*) shop;
-(void) loadWithIDShop:(int) idShop;

@property (nonatomic, assign) enum SHOP_DETAIL_MODE shoplMode;
@property (nonatomic, strong) ShopInfo *shopInfo;
@property (nonatomic, strong) ShopMenu *shopMenuCategory;
@property (nonatomic, strong) ShopPicture *shopPicture;
@property (nonatomic, strong) PromotionDetailType1View *promotionDetailType1View;
@property (nonatomic, strong) PromotionDetailType2View *promotionDetailType2View;
@property (nonatomic, strong) UIView *noPromotionView;
@property (nonatomic, strong) ShopComment *shopComment;
@property (nonatomic, strong) ShopLocation *shopLocation;

@end

@interface ShopDetailView : UIView

@end