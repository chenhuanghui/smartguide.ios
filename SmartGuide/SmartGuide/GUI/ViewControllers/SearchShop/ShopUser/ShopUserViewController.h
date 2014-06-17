//
//  ShopUserViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Shop.h"
#import "SGNavigationController.h"
#import "TouchView.h"
#import "ShopDetailInfoViewController.h"
#import "ShopMapViewController.h"
#import "ShopCameraViewController.h"
#import "FTCoreTextView.h"
#import "PageControl.h"
#import "ShopGalleryCell.h"
#import "ShopKM1Cell.h"
#import "ShopUserGalleryCell.h"
#import "ShopUserCommentCell.h"
#import "SUShopGalleryCell.h"
#import "SUKM1Cell.h"
#import "SUKM2Cell.h"
#import "SUKMNewsContaintCell.h"
#import "SUInfoCell.h"
#import "SUUserGalleryCell.h"
#import "SUUserCommentCell.h"
#import "ShopList.h"
#import "ASIOperationShopUser.h"
#import "ASIOperationShopComment.h"
#import "ASIOperationPostComment.h"
#import "ASIOperationSocialShare.h"
#import "GalleryViewController.h"
#import "ButtonBackShopUser.h"
#import "GalleryFullViewController.h"
#import "GalleryManager.h"

//Vị trí y của table
#define SHOP_USER_ANIMATION_ALIGN_Y 100.f // cần để thực hiện effect scroll giãn shop gallery
#define SHOP_USER_BUTTON_NEXT_HEIGHT 25.f

@class TableShopUser,PromotionDetailView,ShopUserViewController;

enum SHOP_USER_MODE {
    SHOP_USER_FULL = 0,
    SHOP_USER_SHOP_GALLERY = 1,
    SHOP_USER_INFO = 2,
    SHOP_USER_SCAN = 3,
    SHOP_USER_MAP = 4,
    SHOP_USER_CAMERA = 5,
    SHOP_USER_COMMENT = 6,
    };

@protocol ShopUserDelegate <SGViewControllerDelegate>

-(void) shopUserFinished:(ShopUserViewController*) controller;
-(void) shopUserRequestScanCode:(ShopUserViewController*) controller;

@end

@interface ShopUserViewController : SGViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,SUShopGalleryDelegate,UserGalleryDelegate,InfoCelLDelegate,ASIOperationPostDelegate,UserCommentDelegate,GalleryControllerDelegate,GalleryFullControllerDelegate,ShopCameraControllerDelegate>
{
    __strong IBOutlet SGNavigationController *shopNavi;
    __weak IBOutlet SGViewController *detailController;
    __weak IBOutlet TouchView *touchView;
    __weak IBOutlet UIView *detailView;
    __weak IBOutlet UIButton *btnClose;
    __weak IBOutlet TableShopUser *tableShopUser;
    __weak IBOutlet UIButton *btnNext;
    __weak IBOutlet ButtonBackShopUser *btnBack;
    __weak IBOutlet UIImageView *imgvBG;
    
    __strong SUShopGalleryCell *shopGalleryCell;
    __strong SUKM1Cell *km1Cell;
    __strong SUKM2Cell *km2Cell;
    __strong SUKMNewsContaintCell *kmNewsCell;
    __strong SUInfoCell *infoCell;
    __strong SUUserGalleryCell *userGalleryCell;
    __strong SUUserCommentCell *userCommentCell;
    
    __weak GalleryViewController *galleryController;
    __weak GalleryFullViewController *galleryFullController;
    
    CGRect _btnNextFrame;
    CGRect _cmtTypingFrame;
    CGRect _shopUserContentFrame;
    
    NSMutableArray *_km1Data;
    
    __strong Shop *_shop;
    int _idShop;
    
    enum SORT_SHOP_COMMENT _sortComment;
    
    ASIOperationShopUser *_operationShopUser;
    ASIOperationShopComment *_operationShopComment;
    ASIOperationPostComment *_opeartionPostComment;
    ASIOperationSocialShare *_operationSocialShare;
    
    bool _canLoadMoreComment;
    bool _isLoadingMoreComment;
    int _pageComment;
    
    bool _isKeyboardShowed;
    bool _isDiplayView;
}

-(ShopUserViewController*) initWithShopUser:(Shop*) shop;
-(ShopUserViewController*) initWithIDShop:(int) idShop;

@property (nonatomic, assign) id<ShopUserDelegate> delegate;
@property (nonatomic, readonly) enum SHOP_USER_MODE shopMode;

@end

@interface TableShopUser : UITableView
@property (nonatomic, readonly) CGPoint offset;

@end