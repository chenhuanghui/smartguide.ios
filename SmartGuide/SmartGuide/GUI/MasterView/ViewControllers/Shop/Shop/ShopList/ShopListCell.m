//
//  ShopListCell.m
//  SmartGuide
//
//  Created by MacMini on 15/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopListCell.h"
#import "Utility.h"
#import "Constant.h"
#import "GUIManager.h"

#define SHOP_LIST_CELL_BUTTON_TAG_ADD 0
#define SHOP_LIST_CELL_BUTTON_TAG_REMOVE 1

@implementation ShopListCell
@synthesize delegate;

-(void)loadWithShopList:(ShopList *)shopList
{
    _shop=shopList;
    imgvVoucher.highlighted=rand()%2==0;

    [self makeScrollSize];
    
    imgvHeartAni.hidden=true;
    imgvHeartAni.transform=CGAffineTransformMakeScale(1, 1);
    
    lblName.text=shopList.shopName;
    lblAddress.text=shopList.address;
    lblContent.text=shopList.desc;
    [btnNumOfView setTitle:[NSString stringWithFormat:@"%@ đã xem",[_shop numOfView]] forState:UIControlStateNormal];
    [btnNumOfLove setTitle:[NSString stringWithFormat:@"%@ lượt thích",[_shop numOfLove]] forState:UIControlStateNormal];
    [btnNumOfComment setTitle:[NSString stringWithFormat:@"%@ bình luận",[_shop numOfComment]] forState:UIControlStateNormal];
}

-(void)setButtonTypeIsTypeAdded:(bool)isTypeAdded
{
    if(isTypeAdded)
    {
        [btnAddRemove setImage:[UIImage imageNamed:@"button_addslide.png"] forState:UIControlStateNormal];
        btnAddRemove.tag=SHOP_LIST_CELL_BUTTON_TAG_ADD;
    }
    else
    {
        [btnAddRemove setImage:[UIImage imageNamed:@"button_removeslide.png"] forState:UIControlStateNormal];
        btnAddRemove.tag=SHOP_LIST_CELL_BUTTON_TAG_REMOVE;
    }
}

-(void) makeScrollSize
{
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(414, 0);
}

+(NSString *)reuseIdentifier
{
    return @"ShopListCell";
}

+(float)heightWithContent:(NSString *)content
{
    float height=[content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(249, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+20;
    
    if(height>126)
        height=126;
    
    return height+44;
}

-(void) love_unlove
{
    if(_operationLove)
    {
        [_operationLove clearDelegatesAndCancel];
        _operationLove=nil;
    }
    
    switch (_shop.enumLoveStatus) {
        case LOVE_STATUS_LOVED:
            _shop.shop.loveStatus=@(LOVE_STATUS_NONE);
            break;
            
        case LOVE_STATUS_NONE:
            _shop.shop.loveStatus=@(LOVE_STATUS_LOVED);
            break;
            
    }
    
    _operationLove=[[ASIOperationLoveShop alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() loveStatus:_shop.enumLoveStatus];
    [_operationLove startAsynchronous];
    
    imgvHeartAni.alpha=0;
    imgvHeartAni.hidden=false;
    [UIView animateWithDuration:0.3f animations:^{
        imgvHeartAni.alpha=1;
        imgvHeartAni.transform=CGAffineTransformMakeScale(4, 4);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            imgvHeartAni.transform=CGAffineTransformMakeScale(1.5f, 1.5f);
        } completion:^(BOOL finished) {
            imgvHeartAni.hidden=true;
            
            [scroll setContentOffset:CGPointZero animated:true];
        }];
    }];
}

-(void)dealloc
{
    _operationLove=nil;
}

- (IBAction)btnLoveTouchUpInside:(id)sender {

    if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^
        {
            [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_LIST;
            [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
        } onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self love_unlove];
        }];
        return;
    }
    
    if(currentUser().enumDataMode==USER_DATA_CREATING)
    {
        [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_LIST;
        [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeUserProfileRequire() onOK:^
        {
            [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_LIST;
            [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
        } onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self love_unlove];
        }];
        
        return;
    }
    
    [self love_unlove];
}

-(IBAction) btnAddRemoveTouchUpInside:(id)sender
{
    if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^
        {
            [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_LIST;
            [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
        } onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self add_removeShop];
        }];
        return;
    }
    
    if(currentUser().enumDataMode==USER_DATA_CREATING)
    {
        [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_LIST;
        [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
        
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeUserProfileRequire() onOK:^
        {
            [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_LIST;
            [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
        } onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self add_removeShop];
        }];
        
        return;
    }
    
    [self add_removeShop];
}

-(void) add_removeShop
{
    if(btnAddRemove.tag==SHOP_LIST_CELL_BUTTON_TAG_ADD)
        [self.delegate shopListCellTouchedAdd:_shop];
    else
        [self.delegate shopListCellTouchedRemove:_shop];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(panGes:)];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    tap.delegate=self;
    
    [scroll addGestureRecognizer:tap];
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(scroll.contentOffset.x>5)
    {
        return false;
    }
    
    return true;
}

-(void) tapGes:(UITapGestureRecognizer*) tap
{
    [self.delegate shopListCellTouched:_shop];
}

-(void) panGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
            
            if(scroll.contentOffset.x>rightView.l_v_w/2)
            {
                scroll.contentInset=UIEdgeInsetsMake(0, 0, 0, rightView.l_v_w);
                [scroll setContentOffset:CGPointMake(rightView.l_v_w, 0) animated:true];
            }
            else
            {
                [scroll setContentOffsetX:CGPointZero animated:true completed:^{
                    //scroll.contentInset=UIEdgeInsetsZero;
                }];
            }
            
            break;
            
        default:
            break;
    }
}

-(ShopList *)shopList
{
    return _shop;
}

@end

@implementation ScrollListCell

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
    {
        self.panGestureRecognizer.delegate=self;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==self.panGestureRecognizer)
    {
        CGPoint velocity=[self.panGestureRecognizer velocityInView:self.panGestureRecognizer.view];
        
        return fabsf(velocity.x)>fabsf(velocity.y);
    }
    
    return true;
}

@end