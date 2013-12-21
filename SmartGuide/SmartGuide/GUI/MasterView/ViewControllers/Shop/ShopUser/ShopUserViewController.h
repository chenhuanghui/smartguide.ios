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
#import "HitTestView.h"
#import "ShopDetailInfoViewController.h"
#import "ShopMapViewController.h"
#import "ShopCameraViewController.h"
#import "ShopGalleryViewController.h"
#import "ShopScanQRCodeViewController.h"
#import "FTCoreTextView.h"
#import "PageControl.h"
#import "SGTableTemplate.h"
#import "ShopGalleryCell.h"
#import "ShopKM1Cell.h"
#import "ShopUserGalleryCell.h"
#import "ShopUserCommentCell.h"
#import "SUShopGalleryCell.h"
#import "SUKM1Cell.h"
#import "SUInfoCell.h"
#import "SUUserGalleryCell.h"
#import "CommentTyping.h"
#import "SUUserCommentCell.h"
#import "ShopList.h"
#import "ASIOperationShopUser.h"
#import "ASIOperationShopComment.h"

//Vị trí y của table
#define SHOP_USER_ANIMATION_ALIGN_Y 100.f
#define SHOP_USER_BUTTON_NEXT_HEIGHT 25.f

@class TableShopUser,PromotionDetailView;

enum SHOP_USER_MODE {
    SHOP_USER_FULL = 0,
    SHOP_USER_SHOP_GALLERY = 1,
    SHOP_USER_INFO = 2,
    SHOP_USER_SCAN = 3,
    SHOP_USER_MAP = 4,
    SHOP_USER_CAMERA = 5,
    SHOP_USER_COMMENT = 6,
    };

enum SHOP_USER_DATA_MODE
{
    SHOP_USER_DATA_SHOP_LIST = 0,
    SHOP_USER_DATA_SHOP_USER = 1
};

@protocol ShopUserDelegate <SGViewControllerDelegate>

-(void) shopUserFinished;

@end

@interface ShopUserViewController : SGViewController<UIScrollViewDelegate,UINavigationControllerDelegate,SGTableTemplateDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,SUShopGalleryDelegate,UserGalleryDelegate,InfoCelLDelegate,ASIOperationPostDelegate,UserCommentDelegate>
{
    __strong IBOutlet SGNavigationController *shopNavi;
    __weak IBOutlet SGViewController *detailController;
    __weak IBOutlet HitTestView *detailView;
    __weak IBOutlet UIButton *btnClose;
    __weak IBOutlet TableShopUser *tableShopUser;
    __weak IBOutlet UIButton *btnNext;
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UIImageView *imgvBG;
    
    __strong SUShopGalleryCell *shopGalleryCell;
    __strong SUKM1Cell *km1Cell;
    __strong SUInfoCell *infoCell;
    __strong SUUserGalleryCell *userGalleryCell;
    __strong SUUserCommentCell *userCommentCell;
    
    CGRect _btnNextFrame;
    CGRect _cmtTypingFrame;
    CGRect _shopUserContentFrame;
    
    NSMutableArray *_km1Data;
    NSMutableArray *_comments;
    
    __weak ShopList *_shopList;
    __weak Shop *_shop;
    
    enum SHOP_USER_DATA_MODE _dataMode;
    enum SORT_SHOP_COMMENT _sortComment;
    
    ASIOperationShopUser *_operationShopUser;
    ASIOperationShopComment *_operationShopTopComment;
    ASIOperationShopComment *_operationShopTimeComment;
    
    NSMutableArray *_topComments;
    NSMutableArray *_timeComments;
    bool _canLoadMoreTopComment;
    bool _canLoadMoreTimeComment;
    bool _isLoadingMoreTopComment;
    bool _isLoadingMoreTimeComment;
    int _pageTopComment;
    int _pageTimeComment;
    bool _markStartLoadTimeComment;
    
    bool _allowCommentCellScrolling;
}

-(ShopUserViewController*) initWithShopList:(ShopList*) shopList;

//-(void) setShop:(Shop*) shop;

@property (nonatomic, assign) id<ShopUserDelegate> delegate;
@property (nonatomic, readonly) enum SHOP_USER_MODE shopMode;

//-(IBAction) btnInfoTouchUpInside:(id)sender;
//-(IBAction) btnNextPageTouchUpInside:(id)sender;
//-(IBAction) btnSendCommentTouchUpInside:(id)sender;

@end

@interface TableShopUser : UITableView
@property (nonatomic, readonly) CGPoint offset;

@end