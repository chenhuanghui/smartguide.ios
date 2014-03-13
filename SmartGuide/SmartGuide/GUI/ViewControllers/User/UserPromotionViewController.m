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
    
    [self storeRect];
    
    txt.placeholder=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
    
    txt.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, txt.frame.size.height)];
    txt.leftView.backgroundColor=[UIColor clearColor];
    txt.leftViewMode=UITextFieldViewModeAlways;
    
    [table l_v_addH:QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
    
    [table registerNib:[UINib nibWithNibName:[HomeInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeInfoCell reuseIdentifier]];
    [table registerLoadingMoreCell];
    
    _canLoadingMore=true;
    _isLoadingMore=false;
    _userPromotions=[NSMutableArray new];
    _page=-1;
    
    [self requestUserPromotion];
    
    [self.view showLoadingInsideFrame:CGRectMake(0, 54, self.view.l_v_w, self.view.l_v_h-54)];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.delegate userPromotionTouchedTextField:self];
    
    return false;
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

    }
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
        
        _isLoadingMore=false;
        _canLoadingMore=ope.userPromotions.count==10;
        _page++;
        
        [_userPromotions addObjectsFromArray:ope.userPromotions];
        
        if(ope.userPromotions.count>0)
            [table reloadData];
        
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

@end
