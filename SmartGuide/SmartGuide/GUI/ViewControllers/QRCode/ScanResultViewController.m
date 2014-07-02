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

enum SCAN_RESULT_SECTION_TYPE
{
    SCAN_RESULT_SECTION_TYPE_DECODE=0,
    SCAN_RESULT_SECTION_TYPE_RELATED=1,
};

@interface ScanResultViewController ()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate, ScanResultRelatedHeadViewDelegate>
{
    OperationQRCodeDecode *_opeQRCodeDecode;
    OperationQRCodeDecode *_opeQRCodeGetRelated;
    
    ScanQRCodeObject *_qrCodeObject;
    int _currentIndex;
    
    NSArray *_order;
    NSMutableArray *_shops;
    NSMutableArray *_promotions;
    NSMutableArray *_placelists;
}

@end

@implementation ScanResultViewController

-(ScanResultViewController *)initWithCode:(NSString *)code
{
    self=[super initWithNibName:@"ScanResultViewController" bundle:nil];
    
    _code=code;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [table registerScanResultDisconnectCell];
    [table registerScanResultInforyCell];
    [table registerScanResultNonInforyCell];
    [table registerScanResultRelatedCell];
    
    _currentIndex=0;
    
    [self.view showLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view removeLoading];
        [self displayResult];
    });
}

-(void) displayResult
{
    _qrCodeObject=[ScanQRCodeObject new];
    _qrCodeObject.type=@(SCAN_RESULT_CODE_TYPE_INFORY);
    
    _qrCodeObject.qrCodeDecodes=[NSMutableArray new];
    
    QRCodeDecode *obj=[QRCodeDecode new];
    obj.type=@(QRCODE_DECODE_TYPE_HEADER);
    obj.text=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
    
    [_qrCodeObject.qrCodeDecodes addObject:obj];
    
    obj=[QRCodeDecode new];
    obj.type=@(QRCODE_DECODE_TYPE_TITLE);
    obj.text=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
    
    [_qrCodeObject.qrCodeDecodes addObject:obj];
    
    obj=[QRCodeDecode new];
    obj.type=@(QRCODE_DECODE_TYPE_TEXT);
    obj.text=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
    
    [_qrCodeObject.qrCodeDecodes addObject:obj];
    
    obj=[QRCodeDecode new];
    obj.type=@(QRCODE_DECODE_TYPE_IMAGE);
    obj.image=@"http://bglabs.evade.netdna-cdn.com/wp-content/uploads/2013/02/slide012.jpg";
    obj.imageWidth=@(581);
    obj.imageHeight=@(250);
    
    obj=[QRCodeDecode new];
    obj.type=@(QRCODE_DECODE_TYPE_VIDEO);
    obj.video=@"http://r6---sn-a8au-naje.googlevideo.com/videoplayback?expire=1404356400&ipbits=0&sparams=id%2Cip%2Cipbits%2Citag%2Csource%2Cupn%2Cexpire&mws=yes&id=o-AN1biUoqvIt-DB2wc4yXR6-LGC8ZZlOvwhJWvrACTxUz&upn=zhNP263k5Pg&signature=098B95001E43329A3A4DF7C75ECEF191618B54F7.1B3E4FED14AB45C8B70CF174241A6581641A20C2&ms=au&mt=1404331201&mv=m&source=youtube&itag=17&sver=3&fexp=902408%2C902533%2C924213%2C924217%2C924222%2C930008%2C934024%2C934030%2C936117%2C941297&key=yt5&ip=2607%3A5300%3A60%3A513c%3A%3A229&signature=&title=Video";
    obj.videoThumbnail=@"http://bglabs.evade.netdna-cdn.com/wp-content/uploads/2013/02/slide012.jpg";
    obj.videoWidth=@(581);
    obj.videoHeight=@(250);
    
    [_qrCodeObject.qrCodeDecodes addObject:obj];
    
    obj=[QRCodeDecode new];
    obj.action=[UserNotificationAction insert];
    obj.action.actionTitle=@"Go to Shop";
    
    [_qrCodeObject.qrCodeDecodes addObject:obj];
    
    [[DataManager shareInstance] save];
    
    [table reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_qrCodeObject==nil)
        return 0;
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)indexPath.section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            switch (_qrCodeObject.enumType) {
                case SCAN_RESULT_CODE_TYPE_ERROR:
                    return [ScanResultDisconnectCell height];
                    
                case SCAN_RESULT_CODE_TYPE_INFORY:
                    return [ScanResultInforyCell heightWithDecode:_qrCodeObject.qrCodeDecodes];
                    
                case SCAN_RESULT_CODE_TYPE_NON_INFORY:
                    return [ScanResultNonInforyCell height];
            }
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
            return [ScanResultRelatedCell height];
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SCAN_RESULT_SECTION_TYPE)indexPath.section) {
        case SCAN_RESULT_SECTION_TYPE_DECODE:
            switch (_qrCodeObject.enumType) {
                case SCAN_RESULT_CODE_TYPE_ERROR:
                    return [tableView scanResultDisconnectCell];
                    
                case SCAN_RESULT_CODE_TYPE_INFORY:
                    return [tableView scanResultInforyCell];
                    
                case SCAN_RESULT_CODE_TYPE_NON_INFORY:
                    return [tableView scanResultNonInforyCell];
            }
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
        {
            ScanResultRelatedCell *cell=[tableView scanResultRelatedCell];
            
            [cell loadWithRelaties:[NSString stringWithFormat:@"%i ",_currentIndex]];
            
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
            [head loadWithTitles:@[@"Cửa hàng", @"Khuyến mãi", @"Địa điểm"]];
            [head setTitleIndex:_currentIndex animate:false];
            
            return head;
        }
    }
    
    return [UIView new];
}

-(void)scanResultRelatedHeadView:(ScanResultRelatedHeadView *)headView selectedIndex:(int)index
{
    _currentIndex=index;

    [table reloadData];
    
    CGRect rect=[table rectForSection:0];
    
    if(table.contentOffset.y>rect.size.height)
    {
        [table setContentOffset:CGPointMake(0, rect.size.height)];
    }
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.delegate scanResultControllerTouchedBack:self];
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation ScanResult

-(enum SCAN_RESULT_TYPE)enumType
{
    switch ((enum SCAN_RESULT_TYPE)self.type.integerValue) {
        case SCAN_RESULT_TYPE_PLACELIST:
            return SCAN_RESULT_TYPE_PLACELIST;
            
        case SCAN_RESULT_TYPE_PROMOTION:
            return SCAN_RESULT_TYPE_PROMOTION;
            
        case SCAN_RESULT_TYPE_SHOP:
            return SCAN_RESULT_TYPE_SHOP;
            
        case SCAN_RESULT_TYPE_UNKNOW:
            return SCAN_RESULT_TYPE_UNKNOW;
    }
    
    return SCAN_RESULT_TYPE_UNKNOW;
}

@end

@implementation ScanQRCodeObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.related=[NSMutableArray new];
    }
    return self;
}

-(enum SCAN_RESULT_CODE_TYPE)enumType
{
    switch ((enum SCAN_RESULT_CODE_TYPE)self.type.integerValue) {
        case SCAN_RESULT_CODE_TYPE_ERROR:
            return SCAN_RESULT_CODE_TYPE_ERROR;
            
        case SCAN_RESULT_CODE_TYPE_INFORY:
            return SCAN_RESULT_CODE_TYPE_INFORY;
            
        case SCAN_RESULT_CODE_TYPE_NON_INFORY:
            return SCAN_RESULT_CODE_TYPE_NON_INFORY;
    }
    
    return SCAN_RESULT_CODE_TYPE_ERROR;
}

@end