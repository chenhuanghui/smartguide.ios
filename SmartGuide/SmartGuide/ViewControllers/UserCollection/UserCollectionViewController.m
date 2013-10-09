//
//  UserCollectionViewController.m
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserCollectionViewController.h"
#import "UIImageView+AFNetworking.h"
#import "RootViewController.h"
#import "UserCollectionCell.h"
#import "Shop.h"
#import "UIImageView+AFNetworking.h"
#import "FrontViewController.h"

@interface UserCollectionViewController ()

@end

@implementation UserCollectionViewController

- (id)init
{
    self = [super initWithNibName:NIB_PHONE(@"UserCollectionViewController") bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    btnPoint.enabled=false;
    
    self.title=[[DataManager shareInstance].currentUser.name uppercaseString];
    self.view.backgroundColor=COLOR_BACKGROUND_APP;
    
    userBlurMid.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"user_blurmid.png"]];
    
    blurTop.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_bottom.png"]];
    blurTop.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
    blurBottom.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_bottom.png"]];
    
    [table registerNib:[UINib nibWithNibName:[UserCollectionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserCollectionCell reuseIdentifier]];
    [tableReward registerNib:[UINib nibWithNibName:[RewardCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[RewardCell reuseIdentifier]];
    
    templateTable=[[TableTemplate alloc] initWithTableView:table withDelegate:self];
    templateReward=[[TableTemplate alloc] initWithTableView:tableReward withDelegate:self];
    
    CGRect rect=table.frame;
    rect.origin=CGPointZero;
    rect.size.height=5;
    UIView *vi =[[UIView alloc] initWithFrame:rect];
    vi.backgroundColor=[UIColor clearColor];
    table.tableHeaderView=vi;
    
    rect=tableReward.frame;
    rect.origin=CGPointZero;
    rect.size.height=5;
    vi =[[UIView alloc] initWithFrame:rect];
    vi.backgroundColor=[UIColor clearColor];
    tableReward.tableHeaderView=vi;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userScanedQRCode:) name:NOTIFICATION_USER_SCANED_QR_CODE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUpdatedInfo:) name:NOTIFICATION_USER_UPDATED_INFO object:nil];
}

-(void) userUpdatedInfo:(NSNotification*) notification
{
    self.title=[DataManager shareInstance].currentUser.name;
    [avatar setSmartGuideImageWithURL:[NSURL URLWithString:[DataManager shareInstance].currentUser.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
    
    if([RootViewController shareInstance].isShowedUserCollection)
    {
        [self configMenu];
    }
}

-(void) userScanedQRCode:(NSNotification*) notification
{
    if(![RootViewController shareInstance].isShowedUserCollection)
        return;
    
    if(!notification.object)
        return;
    
    QRCode *code=[notification.object objectAtIndex:0];
    
    bool isContainShop=false;
    for(Shop *shop in templateTable.datasource)
        if(shop.idShop.integerValue==code.idShop)
        {
            isContainShop=true;
            break;
        }
    
    if(isContainShop)
    {
        [table reloadData];
    
        [self refreshP];
    }
    else
    {
        [self reloadCollection];
    }
}

-(void) reloadCollection
{
    [templateTable resetData];
    _isReloadUserCollection=true;
    
    [self loadCollectionAtPage:0];
    
    [table showLoadingWithTitle:nil];
}

-(bool)tableTemplateAllowLoadMore:(TableTemplate *)tableTemplate
{
    return tableTemplate.tableView==table;
}

-(void)tableTemplateLoadNext:(TableTemplate *)tableTemplate wait:(bool *)isWait
{
    [self loadCollectionAtPage:templateTable.page];
    
    *isWait=true;
}

- (void)viewDidUnload {
    lblPoint = nil;
    btnPoint = nil;
    avatar = nil;
    table = nil;
    blurTop = nil;
    blurBottom = nil;
    tableReward = nil;
    userBlurMid = nil;
    lblP = nil;
    [super viewDidUnload];
}

- (IBAction)btnPointTouchUpInside:(id)sender {
    
    btnPoint.enabled=false;
    
    if(tableReward.hidden)
    {
        [btnPoint setTitle:@"Cửa hàng" forState:UIControlStateNormal];
        
        CGRect rect=tableReward.frame;
        rect.origin.x=table.frame.origin.x+table.frame.size.width;
        tableReward.frame=rect;
        
        tableReward.alpha=0;
        tableReward.hidden=false;

        [UIView animateWithDuration:0.2f animations:^{
            tableReward.alpha=1;
            table.alpha=0;
            blurBottom.frame=CGRectMake(blurBottom.frame.origin.x, blurBottom.frame.origin.y, tableReward.frame.size.width, blurBottom.frame.size.height);
            blurTop.frame=CGRectMake(blurTop.frame.origin.x, blurTop.frame.origin.y, tableReward.frame.size.width, blurTop.frame.size.height);
            
            CGRect rectAnim=table.frame;
            rectAnim.origin.x-=rectAnim.size.width;
            table.frame=rectAnim;
            
            rectAnim=tableReward.frame;
            rectAnim.origin.x=67;
            tableReward.frame=rectAnim;
        } completion:^(BOOL finished) {
            table.hidden=true;
            
            btnPoint.enabled=true;
        }];
    }
    else
    {
        [btnPoint setTitle:@"Đổi điểm lấy quà" forState:UIControlStateNormal];
        
        table.frame=CGRectMake(tableReward.frame.origin.x-table.frame.size.width, table.frame.origin.y, table.frame.size.width, table.frame.size.height);
        table.alpha=0;
        table.hidden=false;
        
        [UIView animateWithDuration:0.2f animations:^{
            table.alpha=1;
            tableReward.alpha=0;
            blurBottom.frame=CGRectMake(blurBottom.frame.origin.x, blurBottom.frame.origin.y, table.frame.size.width, blurBottom.frame.size.height);
            blurTop.frame=CGRectMake(blurTop.frame.origin.x, blurTop.frame.origin.y, table.frame.size.width, blurTop.frame.size.height);
            
            table.frame=CGRectMake(67, table.frame.origin.y, table.frame.size.width, table.frame.size.height);
            CGRect rect=tableReward.frame;
            rect.origin.x=table.frame.origin.x+table.frame.size.width;
            tableReward.frame=rect;
        } completion:^(BOOL finished) {
            tableReward.hidden=true;
            
            btnPoint.enabled=true;
        }];
    }
}

- (IBAction)btnUpTouchUpInside:(id)sender {
    if(!tableReward.hidden)
        [tableReward setContentOffset:CGPointZero];
    if(!table.hidden)
        [table setContentOffset:CGPointZero];
}

- (IBAction)btnDownTouchUpInside:(id)sender {
    if(!tableReward.hidden)
    {
        if([tableReward numberOfRowsInSection:0]>0)
            [tableReward scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[tableReward numberOfRowsInSection:0]-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:true];
    }
    
    if(!table.hidden)
    {
        if([table numberOfRowsInSection:0]>0)
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[table numberOfRowsInSection:0]-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:true];
    }
}

-(NSArray *)rightNavigationItems
{
    return @[@(ITEM_FILTER),@(ITEM_COLLECTION),@(ITEM_LIST)];
}

-(void)loadUserCollection
{
    [btnPoint setTitle:@"Đổi điểm lấy quà" forState:UIControlStateNormal];
    table.alpha=0;
    table.hidden=false;
    
    self.title=[[DataManager shareInstance].currentUser.name uppercaseString];
    
    _isReloadUserCollection=false;
    
    lblPoint.text=@"";
    
    lblP.frame=CGRectMake(83, 57, 42, 21);
    lblP.alpha=0;
    
    tableReward.frame=CGRECT_PHONE(CGRectMake(67, 152, 238, 212), CGRectMake(67, 152, 238, 262));
    table.frame=CGRECT_PHONE(CGRectMake(67, 152, 206, 212), CGRectMake(67, 152, 206, 262));
    
    [UIView animateWithDuration:0.2f animations:^{
        table.alpha=1;
        tableReward.alpha=0;
        blurBottom.frame=CGRectMake(blurBottom.frame.origin.x, blurBottom.frame.origin.y, table.frame.size.width, blurBottom.frame.size.height);
        blurTop.frame=CGRectMake(blurTop.frame.origin.x, blurTop.frame.origin.y, table.frame.size.width, blurTop.frame.size.height);
    } completion:^(BOOL finished) {
        tableReward.hidden=true;
    }];
    
    if(_operation)
    {
        [_operation cancel];
        _operation=nil;
    }
    
    if(_getRewards)
    {
        [_getRewards cancel];
        _getRewards=nil;
    }
    
    templateTable.datasource=[[NSMutableArray alloc] init];
    templateTable.page=0;
    [table reloadData];
    
    templateReward.datasource=[[NSMutableArray alloc] init];
    templateReward.page=0;
    [tableReward reloadData];
    
    [avatar setSmartGuideImageWithURL:[NSURL URLWithString:[DataManager shareInstance].currentUser.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
    
    [self loadCollectionAtPage:0];
    
    [self.view showLoadingWithTitle:nil];
}

-(void) loadCollectionAtPage:(int) page
{
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    double lat=[DataManager shareInstance].currentUser.location.latitude;
    double lon=[DataManager shareInstance].currentUser.location.longitude;
    
    _operation=[[ASIOperationUserCollection alloc] initWithUserID:idUser lat:lat lon:lon page:page status:true];
    _operation.delegatePost=self;
    
    [_operation startAsynchronous];
}

-(void) getListRewards
{
    _getRewards=[[ASIOperationGetRewards alloc] initGetRewardsWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue];
    _getRewards.delegatePost=self;
    
    [_getRewards startAsynchronous];

    [tableReward showLoadingWithTitle:nil];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserCollection class]])
    {
        if(templateTable.page==0 || !_isReloadUserCollection)
        {
            [self getListRewards];
        }
        
        if(_isReloadUserCollection)
        {
            [table removeLoading];
            
            _isReloadUserCollection=false;
        }
        
        btnPoint.enabled=true;
        
        ASIOperationUserCollection *ope=(ASIOperationUserCollection*)operation;
        
        if(ope.userCollection.count>0)
        {
            [templateTable.datasource addObjectsFromArray:ope.userCollection];
            templateTable.page++;
        }
        
        NSNumberFormatter *numF=[[NSNumberFormatter alloc] init];
        numF.groupingSeparator=@".";
        numF.numberStyle=NSNumberFormatterNoStyle;
        [numF setMaximumFractionDigits:0];
        
        lblPoint.text=@"";
        _totalPoint=ope.totalSP;
        
        [UIView animateWithDuration:1 animations:^{
            lblP.alpha=1;
            lblP.frame=CGRectMake(83+[[[NSNumberFormatter numberFormat] stringFromNumber:@(_totalPoint)] sizeWithFont:lblPoint.font].width/2-2, 57, 42, 21);
        }];
        
        [lblPoint animationScoreWithDuration:1 startValue:0 endValue:_totalPoint format:[NSNumberFormatter numberFormat]];
        
        [templateTable setAllowLoadMore:ope.userCollection.count==5];
        
        [self.view removeLoading];
        
        [templateTable endLoadNext];
    }
    else if([operation isKindOfClass:[ASIOperationGetRewards class]])
    {
        ASIOperationGetRewards *ope=(ASIOperationGetRewards*)operation;
        
        if(ope.rewards.count>0)
        {
            templateReward.datasource=[[NSMutableArray alloc] initWithArray:ope.rewards];
        }
        
        [tableReward removeLoading];
        [tableReward reloadData];
        
        _getRewards=nil;
    }
    else if([operation isKindOfClass:[ASIOperationSGToReward class]])
    {
        ASIOperationSGToReward *ope=(ASIOperationSGToReward*) operation;
        
        if(ope.status==2)
        {
            [AlertView showAlertOKWithTitle:@"Thông báo" withMessage:ope.reward onOK:nil];
        }
        else
        {
            [AlertView showAlertOKWithTitle:@"Thông báo" withMessage:ope.content onOK:nil];
        }
        
        [self refreshP];
    }
    else if([operation isKindOfClass:[ASIOperationGetSG class]])
    {
        [lblPoint stopFlashLabel];
        _totalPoint=((ASIOperationGetSG*)operation).sg;
        lblPoint.text=[NSNumberFormatter numberFromNSNumber:@(_totalPoint)];
        lblP.frame=CGRectMake(83+([[NSNumberFormatter numberFormat] stringFromNumber:@(_totalPoint)].length*[@"0" sizeWithFont:lblPoint.font].width), 57, 42, 21);
        lblP.alpha=1;
        
        [tableReward reloadData];
        
        [self.view removeLoading];
    }
}

-(void) refreshP
{
    
    [lblPoint startFlashLabel];
    
    if(_getSG)
    {
        [_getSG cancel];
        _getSG=nil;
    }
    
    _getSG=[[ASIOperationGetSG alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue];
    _getSG.delegatePost=self;
    
    [_getSG startAsynchronous];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self.view removeLoading];
    
    if([operation isKindOfClass:[ASIOperationUserCollection class]])
    {
        btnPoint.enabled=true;
        [self getListRewards];
    }
    else if([operation isKindOfClass:[ASIOperationGetRewards class]])
        [tableReward removeLoading];
    else if([operation isKindOfClass:[ASIOperationGetSG class]])
    {
        [lblPoint stopFlashLabel];
        _getSG=nil;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==templateTable.tableView)
        return templateTable.datasource.count==0?0:1;
    
    return templateReward.datasource.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==templateTable.tableView)
        return templateTable.datasource.count;
    
    return templateReward.datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==templateTable.tableView)
    {
        UserCollectionCell *cell=[tableView dequeueReusableCellWithIdentifier:[UserCollectionCell reuseIdentifier]];
        Shop *collection=[templateTable.datasource objectAtIndex:indexPath.row];
        
        [cell loadData:collection];
        
        return cell;
    }
    else
    {
        RewardCell *cell=[tableView dequeueReusableCellWithIdentifier:[RewardCell reuseIdentifier]];
        cell.delegate=self;
        Reward *reward=[templateReward.datasource objectAtIndex:indexPath.row];
        
        [cell setReward:reward totalPoint:_totalPoint];
        
        return cell;
    }
}

-(void)rewardCellRequestReward:(RewardCell *)cell
{
    NSString *msg=[NSString stringWithFormat:@"Bạn có muốn đổi điểm lấy phần quà: %@",cell.reward.content];
    [AlertView showAlertOKCancelWithTitle:@"Thông báo" withMessage:msg onOK:^{
        ASIOperationSGToReward *ope=[[ASIOperationSGToReward alloc] initWithIDReward:cell.reward.idReward.integerValue idUser:[DataManager shareInstance].currentUser.idUser.integerValue];
        ope.delegatePost=self;
        
        [ope startAsynchronous];
        
        [self.view showLoadingWithTitle:nil];
    } onCancel:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==templateTable.tableView)
    {
        Shop *collection=[templateTable.datasource objectAtIndex:indexPath.row];
        [[RootViewController shareInstance] showShopDetailFromUserCollection:collection];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UserCollectionCell size].height+10;
}

-(NSArray *)disableRightNavigationItems
{
    return @[@(ITEM_FILTER),@(ITEM_LIST)];
}

@end

@implementation UserCollectionView



@end