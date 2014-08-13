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
#import "Placelist.h"
#import "LabelTopText.h"
#import "ShopList.h"
#import "ASIOperationLoveShop.h"
#import "ShopListViewController.h"

#define SHOP_LIST_CELL_BUTTON_TAG_ADD 0
#define SHOP_LIST_CELL_BUTTON_TAG_REMOVE 1

@interface ShopListCell()<ASIOperationPostDelegate, UIScrollViewDelegate>
{
    ASIOperationLoveShop *_operationLove;
}

@end

@implementation ShopListCell
@synthesize delegate, suggestHeight,isCalculatingSuggestHeight;

+(float)addressHeight
{
    return 44;
}

-(void)loadWithShopList:(ShopList *)shopList
{
    _shop=shopList;
    [self setNeedsLayout];
}

-(void)calculatingSuggestHeight
{
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!_shop.managedObjectContext)
    {
        suggestHeight=0;
        return;
    }
    
    imgvType.image=[[ImageManager sharedInstance] shopImageTypeWithType:_shop.shop.enumShopType];
    
    [self makeScrollSize];
    
    imgvHeartAni.hidden=true;
    imgvHeartAni.transform=CGAffineTransformMakeScale(1, 1);
    
    lblName.text=_shop.shopName;
    lblAddress.text=_shop.address;
    
    [btnNumOfView setTitle:[NSString stringWithFormat:@"%@ lượt xem",[_shop numOfView]] forState:UIControlStateNormal];
    [btnNumOfLove setTitle:[NSString stringWithFormat:@"%@ lượt thích",[_shop numOfLove]] forState:UIControlStateNormal];
    [btnNumOfComment setTitle:[NSString stringWithFormat:@"%@ nhận xét",[_shop numOfComment]] forState:UIControlStateNormal];
    
    lblKM.text=[NSString stringWithFormat:@"Cách bạn %@",_shop.distance];
    btnLove.alpha=_shop.enumLoveStatus==LOVE_STATUS_LOVED?1:0.3f;
    [btnLove l_v_setY:0];
    [btnLove l_v_setH:rightView.l_v_h/2];
    [btnAddRemove l_v_setY:rightView.l_v_h/2];
    [btnAddRemove l_v_setH:rightView.l_v_h/2];
    imgvLineRight.frame=CGRectMake(0, 18, 1, rightView.l_v_h);
    
    [self makeButtonType];
    
    lblName.frame=CGRectMake(30, 5, 270, 0);
    [lblName sizeToFit];
    [lblName l_v_setW:270];
    
    lblAddress.frame=CGRectMake(51, lblName.l_v_y+lblName.l_v_h, 249, 0);
    [lblAddress sizeToFit];
    [lblAddress l_v_setW:249];
    
    lblKM.frame=CGRectMake(51, lblAddress.l_v_y+lblAddress.l_v_h, 249, 0);
    [lblKM sizeToFit];
    [lblKM l_v_setW:249];
    
    NSAttributedString *attStr=[[NSAttributedString alloc] initWithString:_shop.desc attributes:@{NSFontAttributeName:lblContent.font
                                                                                                  , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentJustified]}];
    
    lblContent.attributedText=attStr;
    lblContent.frame=CGRectMake(51, lblKM.l_v_y+lblKM.l_v_h, 249, 0);
    [lblContent sizeToFit];
    
    [scroll l_v_setH:lblContent.l_v_y+lblContent.l_v_h];
    
    [summaryView l_v_setY:scroll.l_v_y+scroll.l_v_h+5];
    [imgvLineBot l_v_setY:summaryView.l_v_y+summaryView.l_v_h+10];
    
    suggestHeight=imgvLineBot.l_v_y+imgvLineBot.l_v_h;
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

-(void)tableDidScroll:(TableShopList *)table
{
    if(scroll.l_co_x>0)
        [scroll l_co_addX:-fabsf(table.offsetY)];
    else
        [scroll l_co_setX:0];
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
        if(![self.cell.delegate shopListCellCanSlide:self.cell])
            return false;
        
        CGPoint velocity=[self.panGestureRecognizer velocityInView:self.panGestureRecognizer.view];
        
        return fabsf(velocity.x)>fabsf(velocity.y);
    }
    
    return true;
}

@end

@implementation UITableView(ShopListCell)

-(void)registerShopListCell
{
    [self registerNib:[UINib nibWithNibName:[ShopListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListCell reuseIdentifier]];
}

-(ShopListCell *)shopListCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopListCell reuseIdentifier]];
}

@end