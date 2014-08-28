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
#import "TabSearchHeaderSectionView.h"
#import "CityManager.h"

enum SEARCH_DISPLAY_MODE
{
    SEARCH_DISPLAY_MODE_SEARCH=0,
    SEARCH_DISPLAY_MODE_CITY=1,
};

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
@property (nonatomic, copy) NSString *keywordSearch;
@property (nonatomic, copy) NSString *keywordCity;
@property (nonatomic, weak) AutoCompletedObject *obj;
@property (nonatomic, assign) enum SEARCH_DISPLAY_MODE displayMode;
@property (nonatomic, strong) NSArray *filteredCity;

@end

@implementation TabSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.displayMode=SEARCH_DISPLAY_MODE_SEARCH;
    self.keywordSearch=@"";
    self.keywordCity=@"";
    
    [[CityManager shareInstance] loadCompletion:^{
        [self callLoadCityCompleted];
    }];
    
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
    [tableCity registerTabSearchTableCell];
    
    _pagePlacelist=0;
    
    [self requestPlacelist];
}

-(void) callLoadCityCompleted
{
    [self filterCity];
    
    tableCity.dataSource=self;
    [tableCity reloadData];
}

-(void) filterCity
{
    self.filteredCity=[[CityManager shareInstance] filterCityWithCityName:self.keywordCity];;
}

-(void) txtTextChanged:(id) sender
{
    if(_displayMode==SEARCH_DISPLAY_MODE_CITY)
    {
        self.keywordCity=txt.text;
        if([CityManager shareInstance].isLoaded)
        {
            [self filterCity];
            [tableCity reloadData];
        }
        
        return;
    }
    
    NSString *text=txt.text;
    
    if([self.keywordSearch isEqualToString:text])
        return;
    
    self.keywordSearch=text;
    
    if(self.keywordSearch.length==0)
    {
        table.canLoadMore=_canLoadMorePlacelist;
        [table reloadData];
        return;
    }
    
    table.canLoadMore=false;
    
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
    if(tableView==table)
    {
        if(self.keywordSearch.length>0)
        {
            self.obj=[self.autoCompleted objectForKey:self.keywordSearch];
            
            if(self.obj)
                return 2;
            
            return 0;
        }
        else
            return MIN(_placelists.count,1);
    }
    else
        return MIN(_filteredCity.count, 1);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==table)
    {
        if(self.keywordSearch.length>0)
        {
            if(section==0)
                return self.obj.shops.count;
            else
                return self.obj.placelist.count;
        }
        
        return _placelists.count;
    }
    else
        return _filteredCity.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView==table)
    {
        if(self.keywordSearch.length>0)
        {
            if(section==1 && self.obj.placelist.count>0)
            {
                return [TabSearchHeaderSectionView height];
            }
        }
        
        return 0;
    }
    else
        return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView==table)
    {
        if(self.keywordSearch.length>0)
        {
            if(section==1 && self.obj.placelist.count>0)
            {
                TabSearchHeaderSectionView *view=[[TabSearchHeaderSectionView alloc] initWithFrame:CGRectMake(0, 0, tableView.SW, [TabSearchHeaderSectionView height])];
                
                view.lbl.text=@"Địa điểm";
                
                return view;
            }
        }
        
        return [UIView new];
    }
    else
        return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==table)
    {
        if(self.keywordSearch.length>0)
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
    else
        return [TabSearchTableCell height];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==table)
    {
    if(self.keywordSearch.length>0)
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
    else
    {
        TabSearchTableCell *cell=[tableView tabSearchTableCell];
        
        [cell loadWithCityObject:_filteredCity[indexPath.row]];
        cell.backgroundColor=indexPath.row%2==0?[UIColor whiteColor]:[UIColor color255WithRed:235 green:235 blue:235 alpha:255];
        
        return cell;
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
        
        if(self.keywordSearch.length>0 && [self.keywordSearch isEqualToString:ope.keyword])
            [table reloadData];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

-(IBAction) btnCityTouchUpInside:(id)sender
{
    if(_displayMode==SEARCH_DISPLAY_MODE_CITY)
        return;
    
    table.userInteractionEnabled=false;
    cityView.userInteractionEnabled=false;
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        table.OX=-table.SW;
        cityView.OX=0;
        
    } completion:^(BOOL finished) {
        
        table.userInteractionEnabled=true;
        cityView.userInteractionEnabled=true;
        
        _displayMode=SEARCH_DISPLAY_MODE_CITY;
        txt.text=@"";
        [txt sendActionsForControlEvents:UIControlEventEditingChanged];
    }];

}

-(IBAction) btnKeywordTouchUpInside:(id)sender
{
    if(_displayMode==SEARCH_DISPLAY_MODE_SEARCH)
        return;
 
    table.userInteractionEnabled=false;
    cityView.userInteractionEnabled=false;
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        table.OX=0;
        cityView.OX=tableCity.SW;
        
    } completion:^(BOOL finished) {
        
        table.userInteractionEnabled=true;
        cityView.userInteractionEnabled=true;
        
        _displayMode=SEARCH_DISPLAY_MODE_SEARCH;
        txt.text=self.keywordSearch;
        [txt sendActionsForControlEvents:UIControlEventEditingChanged];
    }];
}

@end
