//
//  UserPromotionViewController.m
//  SmartGuide
//
//  Created by MacMini on 17/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserPromotionViewController.h"
#import "GUIManager.h"
#import "LoadingMoreCell.h"
#import "NotificationManager.h"
#import "UserNotificationController.h"
#import "ScanCodeController.h"

#define USER_PROMOTION_TEXT_FIELD_SEARCH_MIN_Y 8.f

@interface UserPromotionViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ASIOperationPostDelegate,homeInfoCellDelegate,TextFieldRefreshDelegate, ScanCodeControllerDelegate>

@end

@implementation UserPromotionViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"UserPromotionViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) storeRect
{
    _qrFrame=qrView.frame;
    _buttonScanBigFrame=btnScanBig.frame;
    _buttonScanSmallFrame=btnScanSmall.frame;
    _blurBottomFrame=imgvBlurBottom.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    txtRefresh.text=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
    txtRefresh.maximumWidth=232;
    txtRefresh.minimumWidth=38;
    txtRefresh.minimumY=8;
    
    [self storeRect];
    
    [table l_v_addH:QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
    
    [table registerNib:[UINib nibWithNibName:[HomeInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeInfoCell reuseIdentifier]];
    [table registerLoadingMoreCell];
    
    _canLoadingMore=true;
    _isLoadingMore=false;
    _userPromotions=[NSMutableArray new];
    _page=-1;
    
    [self requestUserPromotion];
    
    [self.view showLoadingInsideFrame:CGRectMake(0, 54, self.view.l_v_w, self.view.l_v_h-52)];
    [self.view cleanLoadingBackground];
    
    table.delegate=nil;
    float y=48;
    //    y+=4;//align
    
    [txtRefresh l_v_setY:y];
    
    y+=txtRefresh.l_v_h;
    y+=4;//align
    
    table.contentInset=UIEdgeInsetsMake(y, 0, 0, 0);
    table.delegate=self;
    
    _scrollDistanceHeight=txtRefresh.l_v_y-USER_PROMOTION_TEXT_FIELD_SEARCH_MIN_Y;
    
    [self displayNotification];
}

-(void)textFieldRefreshFinished:(TextField *)txt
{
    _userPromotions=[[NSMutableArray alloc] initWithArray:_userPromotionsAPI];
    _userPromotionsAPI=nil;
    _isLoadingMore=false;
    _canLoadingMore=_userPromotions.count>=10;
    _page++;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        table.alpha=1;
    }];
    
    [table reloadData];
    
    [table setContentOffset:CGPointMake(0, -48) animated:true];
}

-(void)textFieldNeedRefresh:(TextField *)txt
{
    if(_isLoadingMore)
    {
        [_operationUserPromotion clearDelegatesAndCancel];
        _operationUserPromotion=nil;
    }
    
    _page=-1;
    
    [self requestUserPromotion];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        table.alpha=0.1f;
    }];
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_TOTAL_NOTIFICATION_CHANGED];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_TOTAL_NOTIFICATION_CHANGED])
        [self displayNotification];
}

-(void) displayNotification
{
#if BUILD_MODE==1
    
    NSString *numNoti=[NotificationManager shareInstance].numOfNotification;
    
    if(currentUser().enumDataMode!=USER_DATA_FULL)
        numNoti=@"";
    
    [btnNumOfNotification setTitle:numNoti forState:UIControlStateNormal];
    btnNumOfNotification.hidden=numNoti.length==0 || [NotificationManager shareInstance].totalNotification.integerValue==0;
    
#else
    
    NSString *numNoti=[NotificationManager shareInstance].numOfNotification;
    
    [btnNumOfNotification setTitle:numNoti forState:UIControlStateNormal];
    btnNumOfNotification.hidden=numNoti.length==0 || [NotificationManager shareInstance].totalNotification.integerValue==0;
    
#endif
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [txtRefresh tableDidEndDecelerating:table];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [txtRefresh tableDidEndDragging:table willDecelerate:decelerate];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [txtRefresh tableWillBeginDragging:table];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [SGData shareInstance].fScreen=[UserPromotionViewController screenCode];
    
    if(table.l_co_y<-48)
    {
        table.userInteractionEnabled=false;
        _isTouchedTextField=true;
        [table l_co_setY:-48 animate:true];
    }
    else
        [self.delegate userPromotionTouchedTextField:self];
    
    return false;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if(_isTouchedTextField)
    {
        _isTouchedTextField=false;
        table.userInteractionEnabled=true;
        [self.delegate userPromotionTouchedTextField:self];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==table)
    {
        if(table.l_co_y+table.contentInset.top>100)
        {
            if(table.velocityY>=0)
            {
                [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    [qrView l_v_setY:_qrFrame.origin.y+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
                    [imgvBlurBottom l_v_setY:_blurBottomFrame.origin.y+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
                    
                    btnScanSmall.alpha=1;
                    btnScanBig.alpha=0;
                    btnScanBig.frame=_buttonScanSmallFrame;
                    btnScanSmall.frame=_buttonScanBigFrame;
                } completion:^(BOOL finished) {
                    btnScanBig.userInteractionEnabled=false;
                    btnScanSmall.userInteractionEnabled=true;
                }];
            }
            else
            {
                [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    [qrView l_v_setY:_qrFrame.origin.y];
                    [imgvBlurBottom l_v_setY:_blurBottomFrame.origin.y];
                    
                    btnScanBig.alpha=1;
                    btnScanSmall.alpha=0;
                    btnScanBig.frame=_buttonScanBigFrame;
                    btnScanSmall.frame=_buttonScanSmallFrame;
                } completion:^(BOOL finished) {
                    btnScanBig.userInteractionEnabled=true;
                    btnScanSmall.userInteractionEnabled=false;
                }];
            }
        }
        else
        {
            [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                [qrView l_v_setY:_qrFrame.origin.y];
                [imgvBlurBottom l_v_setY:_blurBottomFrame.origin.y];
                
                btnScanBig.alpha=1;
                btnScanSmall.alpha=0;
                btnScanBig.frame=_buttonScanBigFrame;
                btnScanSmall.frame=_buttonScanSmallFrame;
            } completion:^(BOOL finished) {
                btnScanBig.userInteractionEnabled=true;
                btnScanSmall.userInteractionEnabled=false;
            }];
        }
        
        [txtRefresh tableDidScroll:table];
        
        if(CGRectIsEmpty(_logoFrame))
            _logoFrame=imgvLogo.frame;
        
        float y=table.offsetYWithInsetTop;
        float perY=y/_scrollDistanceHeight;
        
        float logoY=_logoFrame.origin.y-y/4;
        logoY=MIN(_logoFrame.origin.y,logoY);
        
        [imgvLogo l_v_setY:logoY];
        imgvLogo.alpha=1-perY*2.f;
        float scaleLogo=MAX(0.1f,1-perY);
        scaleLogo=MIN(1.2f,scaleLogo);
        imgvLogo.transform=CGAffineTransformMakeScale(scaleLogo, scaleLogo);
        
    }
}

-(void) reloadData
{
    _page=-1;
    _isLoadingMore=false;
    _canLoadingMore=true;
    
    [self requestUserPromotion];
}

-(void) requestUserPromotion
{
    _operationUserPromotion=[[ASIOperationUserPromotion alloc] initWithPage:_page+1 userLat:userLat() userLng:userLng()];
    _operationUserPromotion.delegate=self;
    
    [_operationUserPromotion addToQueue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnScanBigTouchUpInside:(id)sender {
    [self showScanCodeWithDelegate:self animationType:SCANCODE_ANIMATION_TOP];
}

- (IBAction)btnScanSmallTouchUpInside:(id)sender {
    [self showScanCodeWithDelegate:self animationType:SCANCODE_ANIMATION_TOP_BOT];
}

+(NSString *)screenCode
{
    return SCREEN_CODE_USER_PROMOTION_LIST;
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    [SGData shareInstance].fScreen=[UserPromotionViewController screenCode];
    [self.delegate userPromotionTouchedNavigation:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _userPromotions.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userPromotions.count+(_canLoadingMore?1:0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_canLoadingMore && indexPath.row==_userPromotions.count)
        return 80;
    
    HomeInfoCell *cell=[tableView homeInfoCell];
    [cell loadWithUserPromotion:_userPromotions[indexPath.row]];
    [cell calculatingSuggestHeight];
    
    return cell.suggestHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_canLoadingMore && indexPath.row==_userPromotions.count)
    {
        if(!_isLoadingMore)
        {
            _isLoadingMore=true;
            
            [self requestUserPromotion];
        }
        
        return [tableView loadingMoreCell];
    }
    
    HomeInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeInfoCell reuseIdentifier]];
    cell.delegate=self;
    
    [cell loadWithUserPromotion:_userPromotions[indexPath.row]];
    
    return cell;
}

-(void)homeInfoCellTouchedGoTo:(id)home
{
    if([home isKindOfClass:[UserPromotion class]])
    {
        UserPromotion *promotion=home;
        
        switch (promotion.promotionType) {
            case USER_PROMOTION_BRAND:
                [self.delegate userPromotionTouchedIDShops:self idShops:promotion.idShops];
                break;
                
            case USER_PROMOTION_SHOP:
                [[GUIManager shareInstance].rootViewController presentShopUserWithIDShop:promotion.idShop.integerValue];
                break;
                
            case USER_PROMOTION_ITEM_STORE:
            case USER_PROMOTION_STORE:
            case USER_PROMOTION_UNKNOW:
                break;
        }
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserPromotion class]])
    {
        [self.view removeLoading];
        
        ASIOperationUserPromotion* ope=(ASIOperationUserPromotion*) operation;
        
        if(txtRefresh.refreshState==TEXTFIELD_REFRESH_STATE_REFRESHING)
        {
            _userPromotionsAPI=[[NSMutableArray alloc] initWithArray:ope.userPromotions];
            [txtRefresh markRefreshDone:table];
        }
        else if(txtRefresh.refreshState==TEXTFIELD_REFRESH_STATE_NORMAL)
        {
            [_userPromotions addObjectsFromArray:ope.userPromotions];
            _canLoadingMore=ope.userPromotions.count>=10;
            _isLoadingMore=false;
            _page++;
            
            [table reloadData];
        }
        
        _operationUserPromotion=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserPromotion class]])
    {
        [self.view removeLoading];
        _operationUserPromotion=nil;
    }
}

- (IBAction)btnNotificationTouchUpInside:(id)sender {
    if(currentUser().enumDataMode!=USER_DATA_FULL)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^{
            [SGData shareInstance].fScreen=[UserPromotionViewController screenCode];
        } onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self.navigationController pushViewController:[UserNotificationController new] animated:true];
        }];
    }
    else
    {
        [txtRefresh markTableDidEndScroll:table];
        [self.navigationController pushViewController:[UserNotificationController new] animated:true];
    }
}

@end

@implementation TableUserPromotion

-(void)setContentOffset:(CGPoint)contentOffset
{
    _velocityY=contentOffset.y-self.contentOffset.y;
    
    [super setContentOffset:contentOffset];
}

@end