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

enum SCAN_RESULT_SECTION_TYPE
{
    SCAN_RESULT_SECTION_TYPE_DECODE=0,
    SCAN_RESULT_SECTION_TYPE_RELATED=1,
};

@interface ScanResultViewController ()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate>
{
    OperationQRCodeDecode *_opeQRCodeDecode;
    OperationQRCodeDecode *_opeQRCodeGetRelated;
    
    ScanQRCodeObject *_qrCodeObject;
    
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
    
    [self.view showLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view removeLoading];
        [self displayResult];
    });
}

-(void) displayResult
{
    _qrCodeObject=[ScanQRCodeObject new];
    _qrCodeObject.type=@(SCAN_RESULT_CODE_TYPE_ERROR);
    
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
                    return [ScanResultInforyCell height];
                    
                case SCAN_RESULT_CODE_TYPE_NON_INFORY:
                    return [ScanResultNonInforyCell height];
            }
            break;
            
        case SCAN_RESULT_SECTION_TYPE_RELATED:
            return tableView.l_v_h-[ScanResultRelatedHeadView height];
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
            return [tableView scanResultRelatedCell];
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
            return [ScanResultRelatedHeadView new];
    }
    
    return [UIView new];
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
    switch ((enum SCAN_RESULT_TYPE)self.type) {
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
    switch ((enum SCAN_RESULT_CODE_TYPE)self.type) {
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