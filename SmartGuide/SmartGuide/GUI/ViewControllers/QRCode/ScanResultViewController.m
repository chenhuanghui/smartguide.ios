//
//  ScanResultViewController.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultViewController.h"
#import "ScanResultDisconnectCell.h"
#import "ScanResultNonInforyCell.h"
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
#import "ScanResultInforyHeaderCell.h"
#import "ScanResultInforyTitleCell.h"
#import "ScanResultInforyTextCell.h"
#import "ScanResultInforyImageCell.h"
#import "ScanResultInforyVideoCell.h"
#import "ScanResultInforyButtonCell.h"
#import "ScanResultInforyShareCell.h"
#import "ScanResultRelated/ScanResultRelatedCell.h"

enum SCAN_RESULT_SECTION_TYPE
{
    SCAN_RESULT_SECTION_TYPE_DECODE=0,
    SCAN_RESULT_SECTION_TYPE_RELATED=1,
};

enum SCAN_RESULT_CELL_TYPE
{
    SCAN_RESULT_CELL_TYPE_UNKNOW=-1,
    SCAN_RESULT_CELL_TYPE_BUTTON=0,
    SCAN_RESULT_CELL_TYPE_HEADER=1,
    SCAN_RESULT_CELL_TYPE_IMAGE=2,
    SCAN_RESULT_CELL_TYPE_TEXT=3,
    SCAN_RESULT_CELL_TYPE_TITLE=4,
    SCAN_RESULT_CELL_TYPE_VIDEO=5,
    SCAN_RESULT_CELL_TYPE_SHARE=6,
};

@interface ScanResultCell : NSObject

@property (nonatomic, assign) enum SCAN_RESULT_CELL_TYPE cellType;
@property (nonatomic, strong) id object;

@end

@implementation ScanResultCell
@end

@interface ScanResultViewController ()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate, ScanResultDisconnectCellDelegate>
{
    OperationQRCodeDecode *_opeQRCodeDecode;
    OperationQRCodeGetAllRelated *_opeQRCodeGetAllRelated;
    
    ScanCodeResult *_scanResult;
    NSString *_code;
    
    NSArray *_order;
    NSMutableArray *_shops;
    NSMutableArray *_promotions;
    NSMutableArray *_placelists;
    
    __strong MPMoviePlayerController *_player;
}

@property (nonatomic, strong) NSMutableArray *decodeCells;
@property (nonatomic, strong) NSMutableArray *relatedSections;

@end

@implementation ScanResultViewController

-(ScanResultViewController *)initWithCode:(NSString *)code
{
    self=[super initWithNibName:@"ScanResultViewController" bundle:nil];
    
    _code=[code copy];
    
    [self createScanResultWithCode:code];
    
    return self;
}

-(void) createScanResultWithCode:(NSString*) code
{
    _scanResult=[ScanCodeResult makeWithCode:code];
    _scanResult.decodeType=@(SCAN_CODE_DECODE_TYPE_QUERYING);
    _scanResult.relatedStatus=@(SCAN_CODE_RELATED_STATUS_QUERYING);
    
    [[DataManager shareInstance] save];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_scanResult.managedObjectContext==nil)
    {
        [self.navigationController popViewControllerAnimated:true];
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
    
    self.decodeCells=[NSMutableArray new];
    self.relatedSections=[NSMutableArray new];
    
    [table registerScanResultDisconnectCell];
    [table registerScanResultNonInforyCell];
    [table registerScanResultInforyHeaderCell];
    [table registerScanResultInforyTitleCell];
    [table registerScanResultInforyTextCell];
    [table registerScanResultInforyImageCell];
    [table registerScanResultInforyVideoCell];
    [table registerScanResultInforyButtonCell];
    [table registerScanResultInforyShareCell];
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
             [self.navigationController popViewControllerAnimated:true];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int count=0;
    
    // decode
    count++;
    
    // related
    count+=MIN(_relatedSections.count, 1);
    
    return count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch ((enum SCAN_RESULT_SECTION_TYPE) section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            
            switch (_scanResult.enumDecodeType) {
                case SCAN_CODE_DECODE_TYPE_ERROR:
                case SCAN_CODE_DECODE_TYPE_NON_INFORY:
                case SCAN_CODE_DECODE_TYPE_QUERYING:
                    return 1;
                    
                case SCAN_CODE_DECODE_TYPE_INFORY:
                    return _decodeCells.count;
                    
                case SCAN_CODE_DECODE_TYPE_UNKNOW:
                    return 0;
            }
            
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
            return MIN(_relatedSections.count, 1);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SCAN_RESULT_SECTION_TYPE) indexPath.section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
        {
            switch (_scanResult.enumDecodeType) {
                case SCAN_CODE_DECODE_TYPE_ERROR:
                    return [ScanResultDisconnectCell height];
                    
                case SCAN_CODE_DECODE_TYPE_NON_INFORY:
                    return [ScanResultNonInforyCell height];
                    
                case SCAN_CODE_DECODE_TYPE_QUERYING:
                    return [LoadingMoreCell height];
                    
                case SCAN_CODE_DECODE_TYPE_UNKNOW:
                    return 0;
                    
                case SCAN_CODE_DECODE_TYPE_INFORY:
                {
                    ScanResultCell *obj=_decodeCells[indexPath.row];
                    
                    switch (obj.cellType) {
                        case SCAN_RESULT_CELL_TYPE_BUTTON:
                            return [ScanResultInforyButtonCell height];
                            
                        case SCAN_RESULT_CELL_TYPE_HEADER:
                            return [[tableView scanResultInforyHeaderPrototypeCell] calculatorHeight:obj.object];
                            
                        case SCAN_RESULT_CELL_TYPE_IMAGE:
                            return [[tableView scanResultInforyImagePrototypeCell] calculatorHeight:obj.object];
                            
                        case SCAN_RESULT_CELL_TYPE_SHARE:
                            return [ScanResultInforyShareCell height];
                            
                        case SCAN_RESULT_CELL_TYPE_TEXT:
                            return [[tableView scanResultInforyTextPrototypeCell] calculatorHeight:obj.object];
                            
                        case SCAN_RESULT_CELL_TYPE_TITLE:
                            return [[tableView scanResultInforyTitlePrototypeCell] calculatorHeight:obj.object];
                            
                        case SCAN_RESULT_CELL_TYPE_VIDEO:
                            return [[tableView scanResultInforyVideoPrototypeCell] calculatorHeight:obj.object];
                            
                        default:
                            return 0;
                    }
                }
            }
        }
            break;

        case SCAN_RESULT_SECTION_TYPE_RELATED:
            switch (_scanResult.enumRelatedStatus) {
                case SCAN_CODE_RELATED_STATUS_QUERYING:
                    return 80;
                    
                case SCAN_CODE_RELATED_STATUS_DONE:
                    return [[tableView scanResultRelatedPrototypeCell] calculatorHeight:_relatedSections];
                    
                case SCAN_CODE_RELATED_STATUS_ERROR:
                case SCAN_CODE_RELATED_STATUS_UNKNOW:
                    return 0;
            }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SCAN_RESULT_SECTION_TYPE) indexPath.section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
        {
            switch (_scanResult.enumDecodeType) {
                case SCAN_CODE_DECODE_TYPE_ERROR:
                {
                    ScanResultDisconnectCell *cell=[tableView scanResultDisconnectCell];
                    cell.delegate=self;
                    
                    return cell;
                }
                    
                case SCAN_CODE_DECODE_TYPE_NON_INFORY:
                    return [tableView scanResultNonInforyCell];
                    
                case SCAN_CODE_DECODE_TYPE_QUERYING:
                    return [tableView loadingMoreCell];
                    
                case SCAN_CODE_DECODE_TYPE_UNKNOW:
                    return [UITableViewCell new];
                    
                case SCAN_CODE_DECODE_TYPE_INFORY:
                {
                    ScanResultCell *obj=_decodeCells[indexPath.row];
                    
                    switch (obj.cellType) {
                        case SCAN_RESULT_CELL_TYPE_BUTTON:
                        {
                            ScanResultInforyButtonCell *cell=[tableView scanResultInforyButtonCell];
                            
                            [cell loadWithDecode:obj.object];
                            
                            return cell;
                        }
                            
                        case SCAN_RESULT_CELL_TYPE_HEADER:
                        {
                            ScanResultInforyHeaderCell *cell=[tableView scanResultInforyHeaderCell];
                            
                            [cell loadWithDecode:obj.object];
                            
                            return cell;
                        }
                            
                        case SCAN_RESULT_CELL_TYPE_IMAGE:
                        {
                            ScanResultInforyImageCell *cell=[tableView scanResultInforyImageCell];
                            
                            [cell loadWithDecode:obj.object];
                            
                            return cell;
                        }
                            
                        case SCAN_RESULT_CELL_TYPE_SHARE:
                        {
                            ScanResultInforyShareCell *cell=[tableView scanResultInforyShareCell];
                            
                            [cell loadWithLink:[obj.object linkShare]];
                            
                            return cell;
                        }
                            
                        case SCAN_RESULT_CELL_TYPE_TEXT:
                        {
                            ScanResultInforyTextCell *cell=[tableView scanResultInforyTextCell];
                            
                            [cell loadWithDecode:obj.object];
                            
                            return cell;
                        }
                            
                        case SCAN_RESULT_CELL_TYPE_TITLE:
                        {
                            ScanResultInforyTitleCell *cell=[tableView scanResultInforyTitleCell];
                            
                            [cell loadWithDecode:obj.object];
                            
                            return cell;
                        }
                            
                        case SCAN_RESULT_CELL_TYPE_VIDEO:
                        {
                            ScanResultInforyVideoCell *cell=[tableView scanResultInforyVideoCell];
                            
                            [cell loadWithDecode:obj.object];
                            
                            return cell;
                        }
                            
                        default:
                            return [tableView emptyCell];
                    }
                }
            }
        }

        case SCAN_RESULT_SECTION_TYPE_RELATED:
        {
            switch (_scanResult.enumRelatedStatus) {
                case SCAN_CODE_RELATED_STATUS_QUERYING:
                    return [tableView loadingMoreCell];
                    
                case SCAN_CODE_RELATED_STATUS_UNKNOW:
                case SCAN_CODE_RELATED_STATUS_ERROR:
                    return [table emptyCell];
                    
                case SCAN_CODE_RELATED_STATUS_DONE:
                {
                    ScanResultRelatedCell *cell=[tableView scanResultRelatedCell];
                    
                    [cell loadWithRelatedContain:_relatedSections];
                    cell.tableParent=tableView;
                    
                    return cell;
                }
            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            return 0;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
            if(_scanResult.enumRelatedStatus==SCAN_CODE_RELATED_STATUS_UNKNOW
               || _scanResult.enumRelatedStatus==SCAN_CODE_RELATED_STATUS_ERROR)
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
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

-(void)scanResultDisconnectCellTouchedTry:(ScanResultDisconnectCell *)cell
{
    [self.navigationController popViewControllerAnimated:true];
}
//
//-(MPMoviePlayerController *)scanResultInforyCellRequestMoviePlayer:(ScanResultInforyCell *)cell
//{
//    if(!_player)
//    {
//        _player=[MPMoviePlayerController new];
//        _player.shouldAutoplay=false;
//    }
//    
//    return _player;
//}
//
- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationQRCodeDecode class]])
    {
        [self removeLoading];
        
        OperationQRCodeDecode *ope=(id)operation;
        
        _scanResult.decodeType=@(SCAN_CODE_DECODE_TYPE_INFORY);
        [_scanResult addDecode:[NSSet setWithArray:ope.decodes]];
        
        for(ScanCodeDecode *obj in ope.decodes)
        {
            ScanResultCell *cell=[ScanResultCell new];
            
            switch (obj.enumType) {
                case SCANCODE_DECODE_TYPE_BIGTEXT:
                    cell.cellType=SCAN_RESULT_CELL_TYPE_HEADER;
                    break;
                    
                case SCANCODE_DECODE_TYPE_BUTTONS:
                    cell.cellType=SCAN_RESULT_CELL_TYPE_BUTTON;
                    break;
                    
                case SCANCODE_DECODE_TYPE_HEADER:
                    cell.cellType=SCAN_RESULT_CELL_TYPE_TITLE;
                    
                case SCANCODE_DECODE_TYPE_IMAGE:
                    cell.cellType=SCAN_RESULT_CELL_TYPE_IMAGE;
                    break;
                    
                case SCANCODE_DECODE_TYPE_SHARE:
                    cell.cellType=SCAN_RESULT_CELL_TYPE_SHARE;
                    break;
                    
                case SCANCODE_DECODE_TYPE_SMALLTEXT:
                    cell.cellType=SCAN_RESULT_CELL_TYPE_TEXT;
                    break;
                    
                case SCANCODE_DECODE_TYPE_VIDEO:
                    cell.cellType=SCAN_RESULT_CELL_TYPE_VIDEO;
                    break;
                    
                case SCANCODE_DECODE_TYPE_UNKNOW:
                    cell.cellType=SCAN_RESULT_CELL_TYPE_UNKNOW;
                    break;
            }
            
            cell.object=obj;
            
            [_decodeCells addObject:cell];
        }
        
        [[DataManager shareInstance] save];
        
        [table reloadData];
        
        _opeQRCodeDecode=nil;
    }
    else if([operation isKindOfClass:[OperationQRCodeGetAllRelated class]])
    {
        OperationQRCodeGetAllRelated *ope=(id)operation;
        
        _scanResult.relatedStatus=@(SCAN_CODE_RELATED_STATUS_DONE);
        [_scanResult addRelatedContain:[NSSet setWithArray:ope.relatedContains]];
        
        [_relatedSections addObjectsFromArray:ope.relatedContains];
        
        [[DataManager shareInstance] save];
        
        if(_scanResult.enumDecodeType!=SCAN_CODE_DECODE_TYPE_QUERYING)
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
//    UITouch *touch=[touches anyObject];
//    UIView *hitTestView=[table hitTest:[touch locationInView:table] withEvent:event];
//    
//    // Fix khi table scroll vượt qua header section view thì không thể detect touch - không biết lý do tại sao
//    // Touch nhận được lúc này lại là controller view
//    if(hitTestView)
//    {
//        if([hitTestView isKindOfClass:[ScanResultObjectHeaderView class]])
//        {
//            ScanResultObjectHeaderView *headerView=(ScanResultObjectHeaderView*)hitTestView;
//            
//            [self.delegate scanResultController:self touchedMore:headerView.object];
//        }
//    }
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