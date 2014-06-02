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
#import "QRCodeViewController.h"
#import "NotificationManager.h"
#import "UserNotificationViewController.h"

#define USER_PROMOTION_TEXT_FIELD_SEARCH_MIN_Y 8.f

@interface UserPromotionViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ASIOperationPostDelegate,homeInfoCellDelegate>

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
    
    _isUserReleaseTouched=true;
    _isCanRefresh=TRUE;
    _isAPIFinished=false;
    _startYAngle=-999;
    
    [UserPromotion markDeleteAllObjects];
    [[DataManager shareInstance] save];
    
    [self storeRect];
    
    txt.hiddenClearButton=true;
    txt.text=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
    
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
    
    [txt l_v_setY:y];
    _txtPerWidth=TEXT_FIELD_SEARCH_DEFAULT_WIDTH/txt.l_v_w;
    
    y+=txt.l_v_h;
    y+=4;//align
    
    table.contentInset=UIEdgeInsetsMake(y, 0, 30, 0);
    table.delegate=self;
    
    _scrollDistanceHeight=txt.l_v_y-USER_PROMOTION_TEXT_FIELD_SEARCH_MIN_Y;
    [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_SEARCH animated:false completed:nil];
    
    [self displayNotification];
    
//    btnNotification.hidden=true;
//    btnNumOfNotification.hidden=true;
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
    NSString *numNoti=[NotificationManager shareInstance].numOfNotification;
    [btnNumOfNotification setTitle:numNoti forState:UIControlStateNormal];
    btnNumOfNotification.hidden=numNoti.length==0 || [NotificationManager shareInstance].totalNotification.integerValue==0;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(_isTrackingTouch)
    {
        _isUserReleaseTouched=true;
        [self callReloadTable];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate && _isTrackingTouch)
    {
        _isUserReleaseTouched=true;
        [self callReloadTable];
    }
}

-(void) callReloadTable
{
    if(_isUserReleaseTouched && _isAPIFinished && txt.refreshState!=TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING)
    {
        _isTrackingTouch=false;
        _isCanRefresh=true;
        table.maxY=-1;
        table.userInteractionEnabled=true;
        
        [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_SEARCH animated:false completed:nil];
        [UIView animateWithDuration:0.3f animations:^{
            [self scrollViewDidScroll:table];
        }];
        
        [UIView animateWithDuration:0.3f animations:^{
            table.alpha=1;
        }];
        
        [table reloadData];
    }
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isUserReleaseTouched=false;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [SGData shareInstance].fScreen=[UserPromotionViewController screenCode];
    
    if(table.l_co_y<-54)
    {
        table.userInteractionEnabled=false;
        _isTouchedTextField=true;
        [table l_co_setY:-54 animate:true];
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
            [UIView animateWithDuration:0.3f animations:^{
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
            [UIView animateWithDuration:0.3f animations:^{
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

        if(CGRectIsEmpty(_textFieldFrame))
            _textFieldFrame=txt.frame;
        if(CGRectIsEmpty(_logoFrame))
            _logoFrame=imgvLogo.frame;
        
        float y=table.offsetYWithInsetTop;
        float perY=y/_scrollDistanceHeight;
        
        float txtY=_textFieldFrame.origin.y-y;
        txtY=MAX(8,txtY);
        
        if(txtY>_textFieldFrame.origin.y)
            txtY=_textFieldFrame.origin.y;
        
        [txt l_v_setY:txtY];
        
        if(txt.refreshState==TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING || txt.refreshState==TEXT_FIELD_SEARCH_REFRESH_STATE_DONE)
        {
            CGRect rect=txt.frame;
            rect.size.width=TEXT_FIELD_SEARCH_MIN_WIDTH;
            rect.origin.x=(self.l_v_w-rect.size.width)/2;
            txt.frame=rect;
        }
        else
        {
            if(y>0)
            {
                if(y<_scrollDistanceHeight)
                {
                    float w=_textFieldFrame.size.width+perY*(TEXT_FIELD_SEARCH_DEFAULT_WIDTH-_textFieldFrame.size.width);
                    [txt l_v_setW:w];
                    [txt l_v_setX:_textFieldFrame.origin.x-(perY*(TEXT_FIELD_SEARCH_DEFAULT_WIDTH-_textFieldFrame.size.width))/2+4.f*perY];
                }
                else
                {
                    txt.frame=CGRectMake((self.l_v_w-TEXT_FIELD_SEARCH_DEFAULT_WIDTH)/2+MIN(4.f*perY,4), USER_PROMOTION_TEXT_FIELD_SEARCH_MIN_Y, TEXT_FIELD_SEARCH_DEFAULT_WIDTH, _textFieldFrame.size.height);
                }
            }
            else
            {
                CGRect rect=_textFieldFrame;
                
                float yy=rect.size.width*perY;
                yy*=1.5f;
                
                rect.size.width+=yy;
                
                if(rect.size.width<TEXT_FIELD_SEARCH_MIN_WIDTH)
                {
                    rect.size.width=TEXT_FIELD_SEARCH_MIN_WIDTH;
                    rect.origin.x=(self.l_v_w-rect.size.width)/2;
                    
                    if(_startYAngle==-999)
                        _startYAngle=y;
                    
                    switch (txt.refreshState) {
                        case TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING:
                            break;
                            
                        case TEXT_FIELD_SEARCH_REFRESH_STATE_SEARCH:
                        {
                            float angle=180-((perY+0.5f)*180.f)*3.5f;
                            angle=DEGREES_TO_RADIANS(angle);
                            
                            [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_ROTATE animated:false completed:nil];
                            
                            [txt setAngle:angle];
                        }
                            break;
                            
                        case TEXT_FIELD_SEARCH_REFRESH_STATE_ROTATE:
                        {
                            float angle=180-((perY+0.5f)*180.f)*3.5f;
                            angle=DEGREES_TO_RADIANS(angle);
                            
                            [txt setAngle:angle];
                            
                            if(angle>M_PI*3)
                            {
                                angle=M_PI*3;
                                
                                if(_isCanRefresh)
                                {
                                    _isTrackingTouch=true;
                                    _isCanRefresh=FALSE;
                                    table.maxY=-table.contentInset.top;
                                    [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING animated:true completed:nil];
                                    [self reloadData];
                                    
                                    [UIView animateWithDuration:0.3f animations:^{
                                        table.alpha=0.1f;
                                    }];
                                }
                            }
                        }
                            break;
                            
                        case TEXT_FIELD_SEARCH_REFRESH_STATE_DONE:
                            
                            break;
                    }
                }
                else
                {
                    rect.origin.x-=yy/2;
                    rect.size.width=MAX(TEXT_FIELD_SEARCH_MIN_WIDTH,rect.size.width);
                    
                    [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_SEARCH animated:false completed:nil];
                }
                
                txt.frame=rect;
            }
        }
        
        if(txt.l_v_w<95.f)
            txt.text=@"";
        else
            txt.text=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
        
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
    table.userInteractionEnabled=false;
    _isLoadingMore=false;
    _canLoadingMore=true;
    _isAPIFinished=false;
    
    [self requestUserPromotion];
}

-(void) requestUserPromotion
{
    _operationUserPromotion=[[ASIOperationUserPromotion alloc] initWithPage:_page+1 userLat:userLat() userLng:userLng()];
    _operationUserPromotion.delegatePost=self;
    
    [_operationUserPromotion startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnScanBigTouchUpInside:(id)sender {
    [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP screenCode:[UserPromotionViewController screenCode]];
}

- (IBAction)btnScanSmallTouchUpInside:(id)sender {
    [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP_BOT screenCode:[UserPromotionViewController screenCode]];
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
    
    return [HomeInfoCell heightWithUserPromotion:_userPromotions[indexPath.row]];
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
        
        if(txt.refreshState==TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING)
        {
            _userPromotions=[NSMutableArray new];
            
            __weak UserPromotionViewController *wSelf=self;
            [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_DONE animated:true completed:^(enum TEXT_FIELD_SEARCH_REFRESH_STATE state) {
                if(wSelf)
                    [wSelf callReloadTable];
            }];
        }

        _isLoadingMore=false;
        _canLoadingMore=ope.userPromotions.count==10;
        _page++;
        _isAPIFinished=true;
        [_userPromotions addObjectsFromArray:ope.userPromotions];
        
        [self callReloadTable];
        
        _operationUserPromotion=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserPromotion class]])
    {
        [self.view removeLoading];
        
        if(txt.refreshState==TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING)
        {
            _userPromotions=[NSMutableArray new];
            
            __weak UserPromotionViewController *wSelf=self;
            [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_DONE animated:true completed:^(enum TEXT_FIELD_SEARCH_REFRESH_STATE state) {
                if(wSelf)
                    [wSelf callReloadTable];
            }];
        }
        
        _isAPIFinished=true;
        
        [self callReloadTable];
        
        _operationUserPromotion=nil;
    }
}

- (IBAction)btnNotificationTouchUpInside:(id)sender {
    [self.navigationController pushViewController:[UserNotificationViewController new] animated:true];
}

@end

@implementation TableUserPromotion

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.maxY=-1;
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(self.maxY!=-1)
    {
        if(contentOffset.y>self.maxY)
            contentOffset.y=self.maxY;
    }
    
    [super setContentOffset:contentOffset];
}

@end