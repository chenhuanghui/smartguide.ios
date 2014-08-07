//
//  ShopUserViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
//Vị trí y của table
#define SHOP_USER_ANIMATION_ALIGN_Y 100.f // cần để thực hiện effect scroll giãn shop gallery
#define SHOP_USER_BUTTON_NEXT_HEIGHT 25.f

@class TableShopUser, ShopUserViewController, GalleryFullViewController, ShopUserController, Shop;

@protocol ShopUserViewControllerDelegate <SGViewControllerDelegate>

-(void) shopUserViewControllerTouchedQRCode:(ShopUserViewController*) controller;
-(void) shopUserViewControllerPresentGallery:(ShopUserViewController*) controller galleryController:(GalleryFullViewController*) galleryController;
-(void) shopUserViewControllerTouchedIDShop:(ShopUserViewController*) controller idShop:(int) idShop;
-(void) shopUserViewControllerTouchedURL:(ShopUserViewController*) controller url:(NSURL*) url;
-(void) shopUserViewController404Error:(ShopUserViewController*) controller;

@optional
-(void) shopUserViewControllerTouchedDetail:(ShopUserViewController*) controller;
-(void) shopUserViewControllerTouchedMap:(ShopUserViewController*) controller;

@end

@interface ShopUserViewController : SGViewController
{
    __weak IBOutlet TableShopUser *table;
    
    __strong Shop *_shop;
    int _idShop;
}

-(ShopUserViewController*) initWithShopUser:(Shop*) shop;
-(ShopUserViewController*) initWithIDShop:(int) idShop;

-(Shop*) shop;

@property (nonatomic, weak) id<ShopUserViewControllerDelegate> delegate;
@property (nonatomic, weak) ShopUserController *shopController;

@end

@interface TableShopUser : UITableView

@end