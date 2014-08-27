//
//  TabSearchViewController.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabSearchViewController.h"
#import "OperationPlacelist.h"
#import "SearchPlacelist.h"
#import "OperationSearchAutocomplete.h"
#import "TabSearchTableCell.h"
#import "TabSearchPlacelistTableCell.h"
#import "TableTemplates.h"

@interface AutoCompletedObject : NSObject

@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic, strong) NSMutableArray *placelist;

@end

@implementation AutoCompletedObject

@end

@interface TabSearchViewController ()<ASIOperationPostDelegate, TableAPIDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    OperationPlacelist *_opePlacelist;
    
    bool _canLoadMorePlacelist;
    bool _loadingMorePlacelist;
    NSUInteger _pagePlacelist;
    
}

@property (nonatomic, strong) NSMutableArray *placelists;
@property (nonatomic, strong) NSMutableDictionary *autoCompleted;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, weak) AutoCompletedObject *obj;

@end

@implementation TabSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.keyword=@"";
    
    UIButton *btnClose=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose setImage:[UIImage imageNamed:@"button_close.png"] forState:UIControlStateNormal];
    btnClose.frame=CGRectMake(0, 0, txt.SH, txt.SH);
    txt.rightView=btnClose;
    txt.rightViewMode=UITextFieldViewModeAlways;
    [txt addTarget:self action:@selector(txtTextChanged:) forControlEvents:UIControlEventEditingChanged];
    
    keywordView.backgroundColor=[UIColor color255WithRed:235 green:235 blue:235 alpha:255];
    
    self.placelists=[NSMutableArray new];
    self.autoCompleted=[NSMutableDictionary new];
    
    table.canLoadMore=false;
    table.canRefresh=false;
    
    [table registerTabSearchPlacelistTableCell];
    [table registerTabSearchTableCell];
    
    _pagePlacelist=0;
    
    [self requestPlacelist];
}

-(void) txtTextChanged:(id) sender
{
    NSString *text=txt.text;
    
    self.keyword=text;
    
    if(self.keyword.length==0)
    {
        [table reloadData];
        return;
    }
    
    if([_autoCompleted objectForKey:text])
        [table reloadData];
    else
        [self requestAutoCompleteWithKeyword:text];
}

-(void) requestAutoCompleteWithKeyword:(NSString*) keyword
{
    OperationSearchAutocomplete *ope=[[OperationSearchAutocomplete alloc] initWithKeyword:keyword idCity:currentUser().idCity.integerValue];
    ope.delegate=self;
    
    [ope addToQueue];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(NSFoundationVersionNumber<=NSFoundationVersionNumber_iOS_6_1)
        [self.view endEditing:true];
}

-(void) requestPlacelist
{
    _opePlacelist=[[OperationPlacelist alloc] initWithPage:_pagePlacelist userLat:userLat() userLng:userLng()];
    _opePlacelist.delegate=self;
    
    [_opePlacelist addToQueue];
}

-(void)tableLoadMore:(TableAPI *)tableAPI
{
    if(_loadingMorePlacelist)
        return;
    
    _loadingMorePlacelist=true;
    
    [self requestPlacelist];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.keyword.length>0)
    {
        self.obj=[self.autoCompleted objectForKey:self.keyword];
        
        if(self.obj)
            return 2;
        
        return 0;
    }
    else
        return MIN(_placelists.count,1);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.keyword.length>0)
    {
        if(section==0)
            return self.obj.shops.count;
        else
            return self.obj.placelist.count;
    }
    
    return _placelists.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.keyword.length>0)
    {
        return [TabSearchTableCell height];
    }
    else
    {
        if(indexPath.row<3)
            return [[table tabSearchPlacelistTablePrototypeCell] calculatorHeight:_placelists[indexPath.row]];
        else
            return [TabSearchTableCell height];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.keyword.length>0)
    {
        TabSearchTableCell *cell=[tableView tabSearchTableCell];
        
        if(indexPath.section==0)
        {
            AutocompleteShop *shop=self.obj.shops[indexPath.row];
            
            [cell loadWithAutoCompleteShop:shop];
        }
        else
        {
            AutocompletePlacelist *place=self.obj.placelist[indexPath.row];
            
            [cell loadWithAutoCompletePlacelist:place];
        }
        
        return cell;
    }
    else
    {
        if(indexPath.row<3)
        {
            TabSearchPlacelistTableCell *cell=[tableView tabSearchPlacelistTableCell];
            
            [cell loadWithPlacelist:_placelists[indexPath.row]];
            
            return cell;
        }
        else
        {
            TabSearchTableCell *cell=[tableView tabSearchTableCell];
            
            [cell loadWithPlacelist:_placelists[indexPath.row]];
            cell.backgroundColor=indexPath.row%2==0?[UIColor whiteColor]:[UIColor color255WithRed:235 green:235 blue:235 alpha:255];
            
            return cell;
        }
    }
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationPlacelist class]])
    {
        OperationPlacelist *ope=(id)operation;
        
        _loadingMorePlacelist=false;
        _pagePlacelist++;
        _canLoadMorePlacelist=ope.placelists.count>=10;
        
        [_placelists addObjectsFromArray:ope.placelists];
        
        table.canLoadMore=_canLoadMorePlacelist;
        [table reloadData];
        
        _opePlacelist=nil;
    }
    else if([operation isKindOfClass:[OperationSearchAutocomplete class]])
    {
        OperationSearchAutocomplete *ope=(id) operation;
        
        AutoCompletedObject *obj=[AutoCompletedObject new];
        
        obj.shops=ope.shops;
        obj.placelist=ope.placelists;
        
        [self.autoCompleted setObject:obj forKey:ope.keyword];
        
        if(self.keyword.length>0 && [self.keyword isEqualToString:ope.keyword])
            [table reloadData];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

@end
