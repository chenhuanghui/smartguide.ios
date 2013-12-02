//
//  ShopListCell.h
//  SmartGuide
//
//  Created by MacMini on 15/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelTopText.h"

@class ScrollListCell;

@interface ShopListCell : UITableViewCell<UIScrollViewDelegate>
{
    __weak IBOutlet UIImageView *imgvVoucher;
    __weak IBOutlet UIImageView *imgvType;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet LabelTopText *lblContent;
    __weak IBOutlet UIImageView *imgvLine;
    __weak IBOutlet UIImageView *imgvLineVerContent;
    __weak IBOutlet UIView *slideView;
    __weak IBOutlet UIButton *btnLove;
    __weak IBOutlet UIButton *btnShare;
    __weak IBOutlet UIView *visibleView;
    __weak IBOutlet ScrollListCell *scroll;
}

-(void) loadContent;
+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface ScrollListCell : UIScrollView<UIGestureRecognizerDelegate>
@property CGPoint offset;

@end