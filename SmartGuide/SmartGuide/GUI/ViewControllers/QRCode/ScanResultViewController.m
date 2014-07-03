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
#import "ScanResultRelatedHeadView.h"
#import "ScanResultRelatedCell.h"
#import "OperationQRCodeDecode.h"
#import "OperationQRCodeGetRelated.h"
#import "UserNotificationAction.h"
#import "ScanCodeResult.h"
#import "ScanCodeRelated.h"
#import "ScanCodeDecode.h"
#import "ScanCodeRelatedContain.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "OperationNotificationAction.h"
#import "WebViewController.h"
#import "GUIManager.h"
#import "SearchViewController.h"

enum SCAN_RESULT_SECTION_TYPE
{
    SCAN_RESULT_SECTION_TYPE_DECODE=0,
    SCAN_RESULT_SECTION_TYPE_RELATED=1,
};

@interface ScanResultViewController ()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate, ScanResultRelatedHeadViewDelegate, ScanResultInforyCellDelegate>
{
    OperationQRCodeDecode *_opeQRCodeDecode;
    OperationQRCodeGetRelated *_opeQRCodeGetRelated;
    
    bool _isRequestedDecode;
    bool _isRequestedRelated;
    int _currentRelatedIndex;
    
    ScanCodeResult *_scanResult;
    
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
    
#if DEBUG
    code=@"e649f7f9806b67623335e43a8d82ecb7";
#endif
    
    _scanResult=[ScanCodeResult resultWithCode:code];
    [_scanResult markDeleted];
    
    [[DataManager shareInstance] save];
    
    _scanResult=[ScanCodeResult makeWithCode:code];
    [[DataManager shareInstance] save];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _currentRelatedIndex=0;
    
    [table registerScanResultDisconnectCell];
    [table registerScanResultInforyCell];
    [table registerScanResultNonInforyCell];
    [table registerScanResultRelatedCell];
    
    [self requestDecode];
    [self requestRelaties:QRCODE_RELATED_TYPE_ALL page:0 groupIndex:-1];
    
    [self showLoading];
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

-(void) requestRelaties:(enum QRCODE_RELATED_TYPE) relatedType page:(int) page groupIndex:(int) groupIndex
{
    _opeQRCodeGetRelated=[[OperationQRCodeGetRelated alloc] initWithCode:_scanResult.code type:relatedType page:page userLat:userLat() userLng:userLng() groupIndex:groupIndex];
    _opeQRCodeGetRelated.delegate=self;
    
    [_opeQRCodeGetRelated addToQueue];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            switch (_scanResult.enumType) {
                case SCAN_CODE_RESULT_TYPE_ERROR:
                    return 1;
                    
                case SCAN_CODE_RESULT_TYPE_INFORY:
                    return _scanResult.decodeObjects.count==0?0:1;
                    
                case SCAN_CODE_RESULT_TYPE_NON_INFORY:
                    return 1;
                    
                case SCAN_CODE_RESULT_TYPE_IDENTIFYING:
                    return 0;
            }
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
            return [ScanResultRelatedCell heightWithRelated:[_scanResult relatedContaintWithIndex:_currentRelatedIndex]];
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)indexPath.section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            switch (_scanResult.enumType) {
                case SCAN_CODE_RESULT_TYPE_ERROR:
                    return [ScanResultDisconnectCell height];
                    
                case SCAN_CODE_RESULT_TYPE_INFORY:
                    return [ScanResultInforyCell heightWithDecode:_scanResult.decodeObjects];
                    
                case SCAN_CODE_RESULT_TYPE_NON_INFORY:
                    return [ScanResultNonInforyCell height];
                    
                case SCAN_CODE_RESULT_TYPE_IDENTIFYING:
                    return 0;
            }
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
            return [ScanResultRelatedCell heightWithRelated:[_scanResult relatedContaintWithIndex:_currentRelatedIndex]];
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)indexPath.section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            switch (_scanResult.enumType) {
                case SCAN_CODE_RESULT_TYPE_ERROR:
                    return [tableView scanResultDisconnectCell];
                    
                case SCAN_CODE_RESULT_TYPE_INFORY:
                {
                    ScanResultInforyCell *cell=[table scanResultInforyCell];
                    cell.delegate=self;
                    
                    [cell loadWithDecode:_scanResult.decodeObjects];
                    
                    return cell;
                }
                    
                case SCAN_CODE_RESULT_TYPE_NON_INFORY:
                    return [tableView scanResultNonInforyCell];
                    
                case SCAN_CODE_RESULT_TYPE_IDENTIFYING:
                    return [UITableViewCell new];
            }
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
        {
            ScanResultRelatedCell *cell=[tableView scanResultRelatedCell];
            
            [cell loadWithRelatedContain:[_scanResult relatedContaintWithIndex:_currentRelatedIndex]];
            
            return cell;
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
        {
            if(_scanResult.relatedContainObjects.count==0)
                return [ScanResultRelatedHeadView heightEmptyTitles];
        }
            return [ScanResultRelatedHeadView height];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            return [UIView new];
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
        {
            ScanResultRelatedHeadView *head=[ScanResultRelatedHeadView new];
            
            head.delegate=self;
            
            NSArray *titles=[_scanResult.relatedContainObjects valueForKeyPath:ScanCodeRelatedContain_Title];
            
            [head loadWithTitles:titles];
            
            return head;
        }
    }
    
    return [UIView new];
}

-(void)scanResultInforyCell:(ScanResultInforyCell *)cell touchedAction:(UserNotificationAction *)action
{
    [self.delegate scanResultController:self touchedAction:action];
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

-(void)scanResultRelatedHeadView:(ScanResultRelatedHeadView *)headView selectedIndex:(int)index
{
    _currentRelatedIndex=index;

    [table reloadData];
    
    CGRect rect=[table rectForSection:0];
    
    if(table.contentOffset.y>rect.size.height)
    {
        [table setContentOffset:CGPointMake(0, rect.size.height)];
    }
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [table reloadData];
    [self.delegate scanResultControllerTouchedBack:self];
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationQRCodeDecode class]])
    {
        [self removeLoading];
        
        _scanResult.type=@(SCAN_CODE_RESULT_TYPE_INFORY);
        
        [_scanResult removeAllDecode];
        [[DataManager shareInstance] save];
        
        [_scanResult addDecode:[NSSet setWithArray:_opeQRCodeDecode.decodes]];

#if DEBUG
        
        ScanCodeDecode *obj=[ScanCodeDecode insert];
        obj.type=@(SCANCODE_DECODE_TYPE_BUTTONS);
        
        UserNotificationAction *action=[UserNotificationAction insert];
        action.actionTitle=@"Đồng ý";
        action.actionType=@(NOTIFICATION_ACTION_TYPE_USER_SETTING);
        action.idPlacelist=@(1);
        action.sortOrder=@(0);
        
        [obj addActionObject:action];
        
        action=[UserNotificationAction insert];
        action.actionTitle=@"Từ chối";
        action.actionType=@(NOTIFICATION_ACTION_TYPE_SHOP_USER);
        action.idShop=@(1);
        action.sortOrder=@(1);
        
        [obj addActionObject:action];
        
        [_scanResult addDecodeObject:obj];
        
        obj=[ScanCodeDecode insert];
        obj.type=@(SCANCODE_DECODE_TYPE_VIDEO);
        obj.videoThumbnail=@"http://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Video_image_stabilization.ogv/480px-seek%3D8-Video_image_stabilization.ogv.jpg";
        obj.videoWidth=@(480);
        obj.videoHeight=@(176);
        obj.video=@"http://r5---sn-a8au-hjpe.googlevideo.com/videoplayback?fexp=902408%2C914071%2C916612%2C924213%2C924217%2C924222%2C930008%2C934024%2C934030%2C935661%2C937425%2C945005&mws=yes&itag=17&key=yt5&ip=2607%3A5300%3A60%3A513c%3A%3A54&upn=AeFo326xodo&signature=112CE0F27F82254222962C1FFC27C1AB2056C59E.69035C034E1C946CE0289E1AA80EEC7C5A834A66&ipbits=0&ms=au&sparams=id%2Cip%2Cipbits%2Citag%2Csource%2Cupn%2Cexpire&source=youtube&mv=m&id=o-AGS9P4TUfJtT-bnDVcazqDe26lT_FpnFuibrmd40_Ptx&expire=1404421200&sver=3&mt=1404397575&signature=&title=Video";
        
        [_scanResult addDecodeObject:obj];
#endif
        
        [[DataManager shareInstance] save];
        
        [table reloadData];
        
        _isRequestedDecode=true;
        _opeQRCodeDecode=nil;
    }
    else if([operation isKindOfClass:[OperationQRCodeGetRelated class]])
    {
        switch (_opeQRCodeGetRelated.type) {
            case QRCODE_RELATED_TYPE_ALL:
            {
                [_scanResult removeAllRelatedContain];
                [[DataManager shareInstance] save];
                
                int order=0;
                for(NSArray* array in _opeQRCodeGetRelated.relaties)
                {
                    ScanCodeRelated *related=array[0];
                    
                    switch (related.enumType) {
                        case SCANCODE_RELATED_TYPE_SHOPS:
                        {
                            ScanCodeRelatedContain *contain=[ScanCodeRelatedContain insert];
                            contain.order=@(order++);
                            contain.title=@"Cửa hàng";
                            [contain addRelaties:[NSSet setWithArray:array]];
                            contain.currentPage=@(0);
                            contain.canLoadMore=@(array.count>=5);
                            
                            [_scanResult addRelatedContainObject:contain];
                        }
                            break;
                            
                        case SCANCODE_RELATED_TYPE_PLACELISTS:
                        {
                            ScanCodeRelatedContain *contain=[ScanCodeRelatedContain insert];
                            contain.order=@(order++);
                            contain.title=@"Địa điểm";
                            [contain addRelaties:[NSSet setWithArray:array]];
                            contain.currentPage=@(0);
                            contain.canLoadMore=@(array.count>=5);
                            
                            [_scanResult addRelatedContainObject:contain];
                        }
                            break;
                            
                        case SCANCODE_RELATED_TYPE_PROMOTIONS:
                        {
                            ScanCodeRelatedContain *contain=[ScanCodeRelatedContain insert];
                            contain.order=@(order++);
                            contain.title=@"Khuyến mãi";
                            [contain addRelaties:[NSSet setWithArray:array]];
                            contain.currentPage=@(0);
                            contain.canLoadMore=@(array.count>=5);
                            
                            [_scanResult addRelatedContainObject:contain];
                        }
                            break;
                            
                        case SCANCODE_RELATED_TYPE_UNKNOW:
                            break;
                    }
                }
            }
                break;
                
            default:
            {
                ScanCodeRelatedContain *containt=[_scanResult relatedContaintWithIndex:_opeQRCodeGetRelated.groupIndex];
                NSArray *array=[_opeQRCodeGetRelated.relaties firstObject];
                
                if(containt && [array hasData])
                {
                    containt.currentPage=@(containt.currentPage.integerValue+1);
                    containt.canLoadMore=@(array.count>=5);
                    [containt addRelaties:[NSSet setWithArray:array]];
                    
                    [[DataManager shareInstance] save];
                }
            }
                break;
        }
        
        [table reloadData];
        
        _isRequestedRelated=true;
        _opeQRCodeGetRelated=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationQRCodeDecode class]])
    {
        [self removeLoading];
        
        _scanResult.type=@(SCAN_CODE_RESULT_TYPE_ERROR);
        [_scanResult removeAllRelatedContain];
        
        [[DataManager shareInstance] save];
        
        [table reloadData];
        
        _isRequestedDecode=true;
        _opeQRCodeDecode=nil;
    }
    else if([operation isKindOfClass:[OperationQRCodeGetRelated class]])
    {
        
        _isRequestedRelated=true;
        _opeQRCodeGetRelated=nil;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end