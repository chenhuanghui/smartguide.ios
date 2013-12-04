//
//  ShopDetailInfoViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ShopDetailInfoScrollView;

@interface ShopDetailInfoViewController : SGViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    __weak IBOutlet UIImageView *imgvCover;
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UILabel *lblShopType;
    __weak IBOutlet UIImageView *imgvShopType;
    __weak IBOutlet UILabel *lblAddress;
    __weak IBOutlet UILabel *lblCity;
    __weak IBOutlet UIView *introView;
    __weak IBOutlet UIView *toolView;
    __weak IBOutlet UIView *detailView;
    __weak IBOutlet UIView *imageView;
    __weak IBOutlet UIButton *btnMoreIntro;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UITableView *tableTool;
    __weak IBOutlet UITableView *tableDetail;
    __weak IBOutlet UITableView *tableImage;
    __weak IBOutlet ShopDetailInfoScrollView *scroll;
    __weak IBOutlet UIView *infoView;
    __weak IBOutlet UIImageView *imgvBgCover;
    __weak IBOutlet UIView *coverView;
    
    CGRect _contentFrame;
    CGRect _tableToolFrame;
    CGRect _tableDetailFrame;
    CGRect _tableImageFrame;
    CGRect _infoFrame;
    CGRect _coverFrame;
}

@end

@interface ShopDetailInfoScrollView : UIScrollView
@property (nonatomic, assign) CGPoint offset;

@end