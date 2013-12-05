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
#import "ShopCommentViewController.h"
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

@protocol ShopUserDelegate <SGViewControllerDelegate>

-(void) shopUserFinished;

@end

@interface ShopUserViewController : SGViewController<UIScrollViewDelegate,UINavigationControllerDelegate,SGTableTemplateDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,SUShopGalleryDelegate>
{
    __strong IBOutlet SGNavigationController *shopNavi;
    __weak IBOutlet SGViewController *detailController;
    __weak IBOutlet HitTestView *detailView;
    __weak IBOutlet UIButton *btnClose;
    /*
    __weak IBOutlet ScrollShopUser *scrollShopUser;
    __weak IBOutlet UIView *promotionView;
    __weak IBOutlet UIView *infoView;
    __weak IBOutlet UIView *galleryView;
    __weak IBOutlet UIButton *btnNextPage;
    __weak IBOutlet UIView *commentView;
    __weak IBOutlet UITableView *promotionTableShopGallery;
    __weak IBOutlet UIImageView *promotionShopLogo;
    __weak IBOutlet UILabel *promotionShopName;
    __weak IBOutlet UILabel *promotionShopType;
    __weak IBOutlet UILabel *promotionNumOfLove;
    __weak IBOutlet UIButton *btnLove;
    __weak IBOutlet UILabel *promotionNumOfView;
    __weak IBOutlet UILabel *promotionNumOfComment;
    __weak IBOutlet UILabel *promotionDuration;
    __weak IBOutlet FTCoreTextView *promotionInfo;
    __weak IBOutlet UILabel *promotionSGP;
    __weak IBOutlet UIButton *btnReward;
    __weak IBOutlet FTCoreTextView *promotionSP;
    __weak IBOutlet FTCoreTextView *promotionP;
    __weak IBOutlet UIView *promotionContainListPromotionView;
    __weak IBOutlet UITableView *tableListPromotion;
    __weak IBOutlet UIView *promotionBottomView;
    __weak IBOutlet PageControlNext *promotionPageControl;
    __weak IBOutlet UIButton *btnInfo;
    __weak IBOutlet PromotionDetailView *promotionDetail;
    __weak IBOutlet UIView *promotionDetailScrollContent;
    __weak IBOutlet UIView *promotionDetailKM1;
    __weak IBOutlet UIView *promotionDetailKM2;
    __weak IBOutlet UIView *promotionDetailKM3;
    __weak IBOutlet UIView *bottomView;
    __weak IBOutlet UIView *promotionShop;
    __weak IBOutlet UITextView *txtComment;
    __weak IBOutlet UIView *statusView;
    __weak IBOutlet UITableView *tableUserGallery;
    __weak IBOutlet UIImageView *imgvFirsttime;
    __weak IBOutlet UITableView *tableUserComment;
    __weak IBOutlet MKMapView *map;
    
    __weak Shop* _shop;
    
    SGTableTemplate *_templateShopGallery;
    SGTableTemplate *_templateUserGallery;
    SGTableTemplate *_templateUserComment;
    
    CGPoint tableShopGalleryCenter;
    CGPoint btnNextPageCenter;
    CGSize _tableUserGalleryContentSize;
    CGPoint _pntCenterUserGallery;
    
    CGPoint _pntPanShopUserGallery;
    bool _buttonDirectionGoDown;
     */
    
    __weak IBOutlet TableShopUser *tableShopUser;
    __weak SUShopGalleryCell *shopGalleryCell;
    __weak IBOutlet UIButton *btnNext;
    
    CGRect _btnNextFrame;
    
    NSMutableArray *_km1Data;
}

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

@interface PromotionDetailView : UIView
{
    UIImage *img;
}

@end