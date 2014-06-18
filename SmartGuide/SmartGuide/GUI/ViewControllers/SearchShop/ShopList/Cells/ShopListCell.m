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
#import "ImageManager.h"

#define SHOP_LIST_CELL_BUTTON_TAG_ADD 0
#define SHOP_LIST_CELL_BUTTON_TAG_REMOVE 1

@interface ShopListCell()<ASIOperationPostDelegate>

@end

@implementation ShopListCell
@synthesize delegate;

+(float)addressHeight
{
    return 44;
}

-(void)loadWithShopList:(ShopList *)shopList
{
    _shop=shopList;
    [imgvType setImage:[[ImageManager sharedInstance] shopImageTypeWithType:shopList.shop.enumShopType]];

    [self makeScrollSize];
    
    imgvHeartAni.hidden=true;
    imgvHeartAni.transform=CGAffineTransformMakeScale(1, 1);
    
    lblName.text=shopList.shopName;
    lblAddress.text=shopList.address;
    lblContent.text=shopList.desc;
    [btnNumOfView setTitle:[NSString stringWithFormat:@"%@ lượt xem",[_shop numOfView]] forState:UIControlStateNormal];
    [btnNumOfLove setTitle:[NSString stringWithFormat:@"%@ lượt thích",[_shop numOfLove]] forState:UIControlStateNormal];
    [btnNumOfComment setTitle:[NSString stringWithFormat:@"%@ nhận xét",[_shop numOfComment]] forState:UIControlStateNormal];
    lblKM.text=[NSString stringWithFormat:@"Cách bạn %@",shopList.distance];
    btnLove.alpha=shopList.enumLoveStatus==LOVE_STATUS_LOVED?1:0.3f;

    [self makeButtonType];
}

-(void) addObserver
{
    [_shop.shop addObserver:self forKeyPath:Shop_LoveStatus options:NSKeyValueObservingOptionNew context:nil];
    [_shop.shop addObserver:self forKeyPath:Shop_NumOfView options:NSKeyValueObservingOptionNew context:nil];
    [_shop.shop addObserver:self forKeyPath:Shop_NumOfComment options:NSKeyValueObservingOptionNew context:nil];
    _didAddedObserver=true;
}

-(void)removeObserver
{
    if(_didAddedObserver && _shop.shop.observationInfo)
    {
        [_shop.shop removeObserver:self forKeyPath:Shop_LoveStatus];
        [_shop.shop removeObserver:self forKeyPath:Shop_NumOfView];
        [_shop.shop removeObserver:self forKeyPath:Shop_NumOfComment];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    btnLove.alpha=_shop.enumLoveStatus==LOVE_STATUS_LOVED?1:0.3f;
    [btnNumOfView setTitle:[NSString stringWithFormat:@"%@ lượt xem",[_shop numOfView]] forState:UIControlStateNormal];
    [btnNumOfLove setTitle:[NSString stringWithFormat:@"%@ lượt thích",[_shop numOfLove]] forState:UIControlStateNormal];
    [btnNumOfComment setTitle:[NSString stringWithFormat:@"%@ nhận xét",[_shop numOfComment]] forState:UIControlStateNormal];
}

-(void) makeButtonType
{
    if(_shop.placeList)
    {
        switch (currentUser().enumDataMode) {
            case USER_DATA_TRY:
                [self setButtonTypeIsTypeAdded:true];
                break;
                
            case USER_DATA_CREATING:
            case USER_DATA_FULL:
                [self setButtonTypeIsTypeAdded:currentUser().idUser.integerValue!=_shop.placeList.idAuthor.integerValue];
                break;
        }
    }
    else
    {
        [self setButtonTypeIsTypeAdded:true];
    }
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

+(float)heightWithShopList:(ShopList*) shop
{
    if(shop.desc.length==0)
        return 0;
    
    float height=115;
    
    if(shop.descHeight==0)
        shop.descHeight=[shop.desc sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(249, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    if(shop.descHeight<36)
        height+=shop.descHeight;
    else
        height+=36;
    
    if(height>151)
        height=151;
    
    return height;
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
    _operationLove.delegate=self;
    [_operationLove addToQueue];
    
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
    
    [self removeObserver];
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
        [self.delegate shopListCellTouchedAdd:self shop:_shop];
    else
        [self.delegate shopListCellTouchedRemove:self shop:_shop];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(panGes:)];
    scroll.panGestureRecognizer.minimumNumberOfTouches=1;
    scroll.panGestureRecognizer.maximumNumberOfTouches=1;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    tap.delegate=self;
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    
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
    [self.delegate shopListCellTouched:self shop:_shop];
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
                [scroll l_co_setX:0 animate:true];
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

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationLoveShop class]])
    {
        lblName.text=_shop.shopName;
        lblAddress.text=_shop.address;
        lblContent.text=_shop.desc;
        [btnNumOfView setTitle:[NSString stringWithFormat:@"%@ lượt xem",[_shop numOfView]] forState:UIControlStateNormal];
        [btnNumOfLove setTitle:[NSString stringWithFormat:@"%@ lượt thích",[_shop numOfLove]] forState:UIControlStateNormal];
        [btnNumOfComment setTitle:[NSString stringWithFormat:@"%@ nhận xét",[_shop numOfComment]] forState:UIControlStateNormal];
        
        [self closeLove];
        
        [imgvType setImage:[[ImageManager sharedInstance] shopImageTypeWithType:_shop.shop.enumShopType]];
        
        _operationLove=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationLoveShop class]])
    {
        _operationLove=nil;
    }
}

-(void)closeLove
{
    [scroll l_co_setX:0 animate:true];
    scroll.contentSize=CGSizeMake(414, 0);
    [scroll l_v_setW:UIScreenSize().width];
    scroll.contentInset=UIEdgeInsetsZero;
}

-(void)tableDidScroll
{
    float offsetX=MAX(0,scroll.l_co_x-fabsf(self.table.offsetY/2));
    [scroll l_co_setX:offsetX];
}

@end

@implementation ScrollListCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.panGestureRecognizer.delegate=self;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==self.panGestureRecognizer)
    {
        if([self.cell.controller isZoomedMap])
            return false;
        
        CGPoint velocity=[self.panGestureRecognizer velocityInView:self.panGestureRecognizer.view];
        
        return fabsf(velocity.x)>fabsf(velocity.y);
    }
    
    return true;
}

@end