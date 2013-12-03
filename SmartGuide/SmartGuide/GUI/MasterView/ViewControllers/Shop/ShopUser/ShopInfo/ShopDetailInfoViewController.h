//
//  ShopDetailInfoViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@interface ShopDetailInfoViewController : SGViewController<UITableViewDataSource,UITableViewDelegate>
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

    CGRect _introFrame;
    CGRect _toolFrame;
    CGRect _detailFrame;
    CGRect _imageFrame;
    CGRect _contentFrame;
    CGRect _tableToolFrame;
    CGRect _tableDetailFrame;
    CGRect _tableImageFrame;
}

@end
