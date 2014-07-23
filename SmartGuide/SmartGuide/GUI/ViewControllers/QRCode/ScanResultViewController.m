//
//  ScanResultViewController.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultViewController.h"
#import "ScanResultDisconnectCell.h"
#import "ScanResultInforyCell.h"
#import "ScanResultNonInforyCell.h"
#import "ScanResultRelatedCell.h"
#import "OperationQRCodeDecode.h"
#import "OperationQRCodeGetAllRelated.h"
#import "UserNotificationAction.h"
#import "ScanCodeResult.h"
#import "ScanCodeRelated.h"
#import "ScanCodeDecode.h"
#import "ScanCodeRelatedContain.h"
#import "LoadingMoreCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "OperationNotificationAction.h"
#import "WebViewController.h"
#import "GUIManager.h"
#import "SearchViewController.h"
#import "ScanResultRelatedHeadView.h"
#import "ScanResultObjectHeaderView.h"

enum SCAN_RESULT_SECTION_TYPE
{
    SCAN_RESULT_SECTION_TYPE_DECODE=0,
    SCAN_RESULT_SECTION_TYPE_RELATED=1,
};

@interface ScanResultViewController ()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate, ScanResultInforyCellDelegate,ScanResultRelatedCellDelegate, ScanResultDisconnectCellDelegate>
{
    OperationQRCodeDecode *_opeQRCodeDecode;
    OperationQRCodeGetAllRelated *_opeQRCodeGetAllRelated;
    
    ScanCodeResult *_scanResult;
    NSString *_code;
    
    __weak ScanResultRelatedCell *_relatedCell;
    
    NSArray *_order;
    NSMutableArray *_shops;
    NSMutableArray *_promotions;
    NSMutableArray *_placelists;
    
    __strong MPMoviePlayerController *_player;
}

@end

@implementation ScanResultViewController

-(ScanResultViewController *)initWithCode:(NSString *)code
{
    self=[super initWithNibName:@"ScanResultViewController" bundle:nil];
    
    _code=[code copy];
    
    _scanResult=[ScanCodeResult resultWithCode:code];
    
    if(_scanResult)
    {
        [_scanResult markDeleted];
        [[DataManager shareInstance] save];
    }
    
    [self createScanResultWithCode:code];
    
    return self;
}

-(void) createScanResultWithCode:(NSString*) code
{
    _scanResult=[ScanCodeResult makeWithCode:code];
    _scanResult.decodeType=@(SCAN_CODE_DECODE_TYPE_UNKNOW);
    _scanResult.relatedStatus=@(SCAN_CODE_RELATED_STATUS_UNKNOW);
    [[DataManager shareInstance] save];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_scanResult.managedObjectContext==nil)
    {
        [self.delegate scanResultControllerTouchedBack:self];
    }
    else
    {
        [table reloadData];
        [table killScroll];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [table registerScanResultDisconnectCell];
    [table registerScanResultInforyCell];
    [table registerScanResultNonInforyCell];
    [table registerScanResultRelatedCell];
    [table registerLoadingMoreCell];
    
    if(currentUser().enumDataMode==USER_DATA_FULL)
    {
        [self requestDecode];
        [self requestRelaties];
        
        [self showLoading];
    }
    else
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:nil onCancelled:^
         {
             [self.delegate scanResultControllerTouchedBack:self];
         } onLogined:^(bool isLogined) {
            if(isLogined)
            {
                [self requestDecode];
                [self requestRelaties];
                
                [self showLoading];
            }
        }];
    }
}

-(NSArray *)registerNotifications
{
    return @[MPMoviePlayerWillEnterFullscreenNotification,MPMoviePlayerWillExitFullscreenNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:MPMoviePlayerWillExitFullscreenNotification])
    {
        AppDelegate *app=[UIApplication sharedApplication].delegate;
        
        app.allowRotation=false;
    }
    else if([notification.name isEqualToString:MPMoviePlayerWillEnterFullscreenNotification])
    {
        AppDelegate *app=[UIApplication sharedApplication].delegate;
        
        app.allowRotation=true;
    }
}

-(void) showLoading
{
    [self.view showLoading];
    self.view.loadingView.backgroundView.backgroundColor=[UIColor clearColor];
}

-(void) removeLoading
{
    [self.view removeLoading];
}

-(void) requestDecode
{
    _opeQRCodeDecode=[[OperationQRCodeDecode alloc] initWithCode:_scanResult.code userLat:userLat() userLng:userLng()];
    _opeQRCodeDecode.delegate=self;
    
    [_opeQRCodeDecode addToQueue];
}

-(void) requestRelaties
{
    _opeQRCodeGetAllRelated=[[OperationQRCodeGetAllRelated alloc] initWithCode:_scanResult.code userLat:userLat() userLng:userLng()];
    _opeQRCodeGetAllRelated.delegate=self;
    
    [_opeQRCodeGetAllRelated addToQueue];
}

-(void)scanResultRelatedCell:(ScanResultRelatedCell *)cell touchedObject:(ScanCodeRelated *)obj
{
    [self.delegate scanResultController:self touchedRelated:obj];
}

-(void)scanResultRelatedCellTouchedMore:(ScanResultRelatedCell *)cell object:(ScanCodeRelatedContain *)object
{
    [self.delegate scanResultController:self touchedMore:object];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            switch (_scanResult.enumDecodeType) {
                case SCAN_CODE_DECODE_TYPE_ERROR:
                case SCAN_CODE_DECODE_TYPE_NON_INFORY:
                case SCAN_CODE_DECODE_TYPE_IDENTIFYING:
                    return 1;
                    
                case SCAN_CODE_DECODE_TYPE_INFORY:
                    return _scanResult.decodeObjects.count==0?0:1;
                    
                case SCAN_CODE_DECODE_TYPE_UNKNOW:
                    return 0;
            }
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
            return 1;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)indexPath.section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            switch (_scanResult.enumDecodeType) {
                case SCAN_CODE_DECODE_TYPE_ERROR:
                    return [ScanResultDisconnectCell height];
                    
                case SCAN_CODE_DECODE_TYPE_INFORY:
                {
                    ScanResultInforyCell *cell=[tableView scanResultInforyCell];
                    [cell loadWithDecode:_scanResult.decodeObjects];
                    [cell layoutSubviews];
                    
                    return cell.suggestHeight;
                }
                    
                case SCAN_CODE_DECODE_TYPE_NON_INFORY:
                    return [ScanResultNonInforyCell height];
                    
                case SCAN_CODE_DECODE_TYPE_IDENTIFYING:
                    return [LoadingMoreCell height];
                    
                case SCAN_CODE_DECODE_TYPE_UNKNOW:
                    return 0;
            }
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
        {
            switch (_scanResult.enumRelatedStatus) {
                case SCAN_CODE_RELATED_STATUS_QUERYING:
                    return 97;
                    
                case SCAN_CODE_RELATED_STATUS_DONE:
                {
                    ScanResultRelatedCell *cell=[tableView scanResultRelatedCell];
                    [cell loadWithResult:_scanResult height:tableView.l_v_h];
                    [cell layoutSubviews];
                    
                    return cell.suggestHeight;
                }
                    
                case SCAN_CODE_RELATED_STATUS_UNKNOW:
                case SCAN_CODE_RELATED_STATUS_ERROR:
                    return 0;
            }
        }
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)indexPath.section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            switch (_scanResult.enumDecodeType) {
                case SCAN_CODE_DECODE_TYPE_ERROR:
                {
                    ScanResultDisconnectCell *cell=[tableView scanResultDisconnectCell];
                    cell.delegate=self;
                    
                    return cell;
                }
                    break;
                    
                case SCAN_CODE_DECODE_TYPE_INFORY:
                {
                    ScanResultInforyCell *cell=[table scanResultInforyCell];
                    cell.delegate=self;
                    
                    [cell loadWithDecode:_scanResult.decodeObjects];
                    
                    return cell;
                }
                    
                case SCAN_CODE_DECODE_TYPE_NON_INFORY:
                    return [tableView scanResultNonInforyCell];
                    
                case SCAN_CODE_DECODE_TYPE_IDENTIFYING:
                    return [tableView loadingMoreCell];
                    
                case SCAN_CODE_DECODE_TYPE_UNKNOW:
                    return [UITableViewCell new];
            }
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
        {
            switch (_scanResult.enumRelatedStatus) {
                case SCAN_CODE_RELATED_STATUS_QUERYING:
                    return [tableView loadingMoreCell];
                    
                case SCAN_CODE_RELATED_STATUS_UNKNOW:
                case SCAN_CODE_RELATED_STATUS_ERROR:
                    return [UITableViewCell new];
                    
                case SCAN_CODE_RELATED_STATUS_DONE:
                {
                    ScanResultRelatedCell *cell=[tableView scanResultRelatedCell];
                    cell.delegate=self;
                    
                    float height=[tableView rectForRowAtIndexPath:indexPath].size.height;
                    height=MIN(height,tableView.l_v_h);
                    
                    [cell loadWithResult:_scanResult height:height];
                    _relatedCell=cell;
                    
                    return cell;
                }
                    break;
            }
        }
    }
    
    return [UITableViewCell new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            return 0;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
            if(_scanResult.enumRelatedStatus==SCAN_CODE_RELATED_STATUS_UNKNOW)
                return 0;
            
            return [ScanResultRelatedHeadView height];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            return [UIView new];
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
            return [ScanResultRelatedHeadView new];
    }
    
    return [UIView new];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_relatedCell)
    {
        [_relatedCell tableDidScroll:table];
    }
}

-(void)scanResultInforyCell:(ScanResultInforyCell *)cell touchedAction:(UserNotificationAction *)action
{
    [self.delegate scanResultController:self touchedAction:action];
}

-(void)scanResultDisconnectCellTouchedTry:(ScanResultDisconnectCell *)cell
{
    [self.delegate scanResultControllerTouchedBack:self];
}

-(MPMoviePlayerController *)scanResultInforyCellRequestMoviePlayer:(ScanResultInforyCell *)cell
{
    if(!_player)
    {
        _player=[MPMoviePlayerController new];
        _player.shouldAutoplay=false;
    }
    
    return _player;
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.delegate scanResultControllerTouchedBack:self];
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationQRCodeDecode class]])
    {
        [self removeLoading];

        _scanResult.decodeType=@(SCAN_CODE_DECODE_TYPE_INFORY);
        
        [_scanResult removeAllDecode];
        [[DataManager shareInstance] save];
        
        [_scanResult addDecode:[NSSet setWithArray:_opeQRCodeDecode.decodes]];

        [[DataManager shareInstance] save];
        
        [table reloadData];
        
        _opeQRCodeDecode=nil;
    }
    else if([operation isKindOfClass:[OperationQRCodeGetAllRelated class]])
    {
        [_scanResult removeAllRelatedContain];
        [[DataManager shareInstance] save];
        
        _scanResult.relatedStatus=@(SCAN_CODE_RELATED_STATUS_DONE);
        [_scanResult addRelatedContain:[NSSet setWithArray:_opeQRCodeGetAllRelated.relatedContains]];
        
        if(_scanResult.enumDecodeType!=SCAN_CODE_DECODE_TYPE_IDENTIFYING)
            [table reloadData];
        
        _opeQRCodeGetAllRelated=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationQRCodeDecode class]])
    {
        [self removeLoading];
        
        _scanResult.decodeType=@(SCAN_CODE_DECODE_TYPE_ERROR);
        [_scanResult removeAllDecode];
        
        [[DataManager shareInstance] save];
        
        [table reloadData];

        _opeQRCodeDecode=nil;
    }
    else if([operation isKindOfClass:[OperationQRCodeGetAllRelated class]])
    {
        [_scanResult removeAllRelatedContain];
        [[DataManager shareInstance] save];
        
        _scanResult.relatedStatus=@(SCAN_CODE_RELATED_STATUS_ERROR);
        
        [[DataManager shareInstance] save];
        
        [table reloadData];
        
        _opeQRCodeGetAllRelated=nil;
    }
}

-(void)dealloc
{
    if(_player)
    {
        [_player stop];
        [_player.view removeFromSuperview];
        _player=nil;
    }
    
    if(_opeQRCodeDecode)
    {
        [_opeQRCodeDecode clearDelegatesAndCancel];
        _opeQRCodeDecode=nil;
    }
    
    if(_opeQRCodeGetAllRelated)
    {
        [_opeQRCodeGetAllRelated clearDelegatesAndCancel];
        _opeQRCodeGetAllRelated=nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    UIView *hitTestView=[table hitTest:[touch locationInView:table] withEvent:event];
    
    // Fix khi table scroll vượt qua header section view thì không thể detect touch - không biết lý do tại sao
    // Touch nhận được lúc này lại là controller view
    if(hitTestView)
    {
        if([hitTestView isKindOfClass:[ScanResultObjectHeaderView class]])
        {
            ScanResultObjectHeaderView *headerView=(ScanResultObjectHeaderView*)hitTestView;
            
            [self.delegate scanResultController:self touchedMore:headerView.object];
        }
    }
}

@end

@interface TableResult()<UIGestureRecognizerDelegate>

@end

@implementation TableResult

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.panGestureRecognizer.delegate=self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return true;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return true;
}

@end