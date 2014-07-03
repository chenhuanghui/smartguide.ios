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
    
    [self requestDecode];
    [self requestRelaties];
}

-(void) requestDecode
{
    
}

-(void) requestRelaties
{
    
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
            return [ScanResultRelatedCell heightWithRelated:nil];
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
                {
                    ScanResultInforyCell *cell=[table scanResultInforyCell];
                    
                    [cell loadWithDecode:_qrCodeObject.qrCodeDecodes];
                    
                    return cell;
                }
                    
                case SCAN_RESULT_CODE_TYPE_NON_INFORY:
                    return [tableView scanResultNonInforyCell];
            }
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
        {
            ScanResultRelatedCell *cell=[tableView scanResultRelatedCell];
            
            [cell loadWithRelated:nil];
            
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
    [table reloadData];
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
        self.relaties=[NSMutableDictionary new];
        
        [self.relaties setObject:[NSMutableArray array] forKey:@"relatedShops"];
        [self.relaties setObject:[NSMutableArray array] forKey:@"relatedPlacelist"];
        [self.relaties setObject:[NSMutableArray array] forKey:@"relatedPromotions"];
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

-(void) addRelatedShops:(NSArray*) shops
{
    [self.relaties[@"relatedShops"] addObjectsFromArray:shops];
}

-(void) addRelatedPromotions:(NSArray*) promotions
{
    
}

-(void) addRelatedPlacelists:(NSArray*) plcelists
{
    
}

@end