//
//  ScanResultRelatedViewController.m
//  Infory
//
//  Created by XXX on 7/14/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultRelatedViewController.h"
#import "ScanResultObjectCell.h"
#import "LoadingMoreCell.h"
#import "OperationQRCodeGetRelated.h"
#import "ScanCodeRelatedContain.h"
#import "ScanCodeRelated.h"
#import "ScanCodeResult.h"

@interface ScanResultRelatedViewController ()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate, ScanResultObjectCellDelegate>
{
    OperationQRCodeGetRelated *_opeGetRelated;
    NSString *_code;
}

@end

@implementation ScanResultRelatedViewController

-(ScanResultRelatedViewController *)initWithRelatedContain:(ScanCodeRelatedContain *)object
{
    self=[super initWithNibName:@"ScanResultRelatedViewController" bundle:nil];
    
    _relatedContain=object;
    _code=[_relatedContain.result.code copy];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    lblTitle.text=_relatedContain.title;
    
    [table registerLoadingMoreCell];
    [table registerScanResultObjectCell];
}

-(void) showLoading
{
    [table showLoading];
}

-(void) removeLoading
{
    [table removeLoading];
}

-(void) requestGetRelated
{
    _opeGetRelated=[[OperationQRCodeGetRelated alloc] initWithCode:_code type:_relatedContain.enumType page:_relatedContain.page.integerValue+1 userLat:userLat() userLng:userLng()];
    _opeGetRelated.delegate=self;
    
    [_opeGetRelated addToQueue];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _relatedContain.relatiesObjects.count+_relatedContain.canLoadMore.boolValue;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_relatedContain.canLoadMore.boolValue && indexPath.row==_relatedContain.relatiesObjects.count)
        return [LoadingMoreCell height];
    
    return [ScanResultObjectCell heightWithRelated:_relatedContain.relatiesObjects[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_relatedContain.canLoadMore.boolValue && indexPath.row==_relatedContain.relatiesObjects.count)
    {
        if(!_relatedContain.isLoadingMore.boolValue)
        {
            _relatedContain.isLoadingMore=@(true);
            [self requestGetRelated];
        }
        
        return [tableView loadingMoreCell];
    }
    
    ScanResultObjectCell *cell=[tableView scanResultObjectCell];
 
    cell.delegate=self;
    [cell loadWithRelated:_relatedContain.relatiesObjects[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if([cell isKindOfClass:[ScanResultObjectCell class]])
    {
    }
}

-(void)scanResultObjectCellTouched:(ScanResultObjectCell *)cell
{
    [self.delegate scanResultRelatedController:self touchedRelatedObject:cell.obj];
}

-(IBAction) btnBackTouchUpInside:(id)sender
{
    [self.delegate scanResultRelatedControllerTouchedBack:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_relatedContain.managedObjectContext==nil)
    {
        [self.delegate scanResultRelatedControllerTouchedBack:self];
    }
    else
    {
        [table reloadData];
    }
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationQRCodeGetRelated class]])
    {
        [self removeLoading];
        
        OperationQRCodeGetRelated *ope=(OperationQRCodeGetRelated*) operation;
        
        _relatedContain.isLoadingMore=@(false);
        _relatedContain.canLoadMore=@(ope.relaties.count>=5);
        _relatedContain.page=@(_relatedContain.page.integerValue+1);
        [_relatedContain addRelaties:[NSSet setWithArray:ope.relaties]];
        [[DataManager shareInstance] save];
        
        [table reloadData];
        
        _opeGetRelated=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationQRCodeGetRelated class]])
    {
        [self removeLoading];
        _opeGetRelated=nil;
    }
}

-(void)dealloc
{
    if(_opeGetRelated)
    {
        [_opeGetRelated clearDelegatesAndCancel];
        _opeGetRelated=nil;
    }
}

@end
