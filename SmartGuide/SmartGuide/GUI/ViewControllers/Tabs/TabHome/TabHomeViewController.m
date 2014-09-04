//
//  TabHomeViewController.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabHomeViewController.h"
#import "HomeDataManager.h"
#import "EventDataManager.h"
#import "Home.h"
#import "Event.h"
#import "HomeImages.h"
#import "HomeImage.h"
#import "TabHomeImagesCell.h"
#import "TabHomeShopCell.h"
#import "NavigationView.h"
#import "TableTemplates.h"
#import "MapViewController.h"
#import "HomeShop.h"
#import "ShopInfo.h"
#import "ShopViewController.h"
#import "ListShopViewController.h"
#import "DataAPI.h"

enum TABHOME_MODE
{
    TABHOME_MODE_HOME=0,
    TABHOME_MODE_EVENT=1,
};

@interface TabHomeViewController ()<TableAPIDataSource, UITableViewDelegate, TabHomeShopCellDelegate, TabHomeImagesCellDelegate, DataAPIDelegate>
{
}

@property (nonatomic, assign) enum TABHOME_MODE mode;
@property (nonatomic, strong) DataAPI *dataAPI;

@end

@implementation TabHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mode=TABHOME_MODE_HOME;
    
    btnTab.titleLabel.font=lblTitle.font;
    [btnTab setTitleColor:lblTitle.textColor forState:UIControlStateNormal];
    
    [self makeTitleWithMode:self.mode];
    
    table.canRefresh=false;
    
    [table registerTabHomeImagesCell];
    [table registerTabHomeShopCell];
    
    self.dataAPI=[HomeDataAPI manager];
    [self.dataAPI addObserver:self];
    
    [table showLoading];
    
    [self.dataAPI requestData];
}

-(void)tableLoadMore:(TableAPI *)table
{
    [self.dataAPI loadMore];
}

-(void)dataAPIFinished:(DataAPI *)dataAPI
{
    [table removeLoading];
    
    table.canLoadMore=dataAPI.canLoadMore;
    [table reloadData];
}

-(void)dataAPIFailed:(DataAPI *)dataAPI
{
    
}

-(void) makeTitleWithMode:(enum TABHOME_MODE) mode
{
    switch (mode) {
        case TABHOME_MODE_HOME:
            lblTitle.text=@"Khám phá";
            [btnTab setTitle:@"Sự kiện" forState:UIControlStateNormal];
            break;
            
        case TABHOME_MODE_EVENT:
            lblTitle.text=@"Sự kiện";
            [btnTab setTitle:@"Khám phá" forState:UIControlStateNormal];
            break;
    }
}

-(void) switchToMode:(enum TABHOME_MODE) mode
{
    self.view.userInteractionEnabled=false;
    [self animationTitleView];
    [table showLoading];
    [self makeTitleWithMode:mode];
    
    [table setContentOffset:CGPointZero animated:true completion:^{
        self.view.userInteractionEnabled=true;
        
        self.mode=mode;
        
        switch (_mode) {
            case TABHOME_MODE_HOME:
                
                [self.dataAPI cancelAllRequest];
                self.dataAPI=nil;
                
                self.dataAPI=[HomeDataAPI manager];
                [self.dataAPI addObserver:self];
                [self.dataAPI requestData];
                
                break;
                
            case TABHOME_MODE_EVENT:
                
                [self.dataAPI cancelAllRequest];
                self.dataAPI=nil;
                
                self.dataAPI=[EventDataAPI manager];
                [self.dataAPI addObserver:self];
                [self.dataAPI requestData];
                
                break;
        }
        
        table.canLoadMore=false;
        [table reloadData];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MIN(_dataAPI.objects.count, 1);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataAPI.objects.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_mode) {
        case TABHOME_MODE_HOME:
        {
            Home *obj=_dataAPI.objects[indexPath.row];
            
            switch (obj.enumType) {
                    
                case HOME_TYPE_IMAGES:
                    return [TabHomeImagesCell heightWithHomeImages:obj.homeImage width:tableView.SW];
                    
                case HOME_TYPE_SHOP:
                    return [tableView.tabHomeShopPrototypeCell calculateHeight:obj.homeShop];
                    
                case HOME_TYPE_UNKNOW:
                    return 0;
            }
        }
            
        case TABHOME_MODE_EVENT:
        {
            Event *obj=_dataAPI.objects[indexPath.row];
            
            return [tableView.tabHomeShopPrototypeCell calculateHeight:obj];
        }
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_mode) {
        case TABHOME_MODE_HOME:
        {
            Home *obj=_dataAPI.objects[indexPath.row];
            
            switch (obj.enumType) {
                case HOME_TYPE_IMAGES:
                {
                    TabHomeImagesCell *cell=[tableView tabHomeImagesCell];
                    
                    cell.delegate=self;
                    [cell loadWithHomeImages:obj.homeImage];
                    
                    return cell;
                }
                    
                case HOME_TYPE_SHOP:
                {
                    TabHomeShopCell *cell=[tableView tabHomeShopCell];
                    cell.delegate=self;
                    
                    [cell loadWithHomeShop:obj.homeShop];
                    
                    
                    return cell;
                }
                    
                case HOME_TYPE_UNKNOW:
                    return tableView.emptyCell;
            }
        }
            
        case TABHOME_MODE_EVENT:
        {
            Event *obj=_dataAPI.objects[indexPath.row];
            TabHomeShopCell *cell=[tableView tabHomeShopCell];
            
            [cell loadWithEvent:obj];
            
            return cell;
        }
    }
    
    return tableView.emptyCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    
    if([selectedCell isKindOfClass:[TabHomeShopCell class]])
    {
        TabHomeShopCell *cell=(id)selectedCell;
        if([cell.object isKindOfClass:[HomeShop class]])
        {
            HomeShop *obj=cell.object;
            ShopViewController *vc=[[ShopViewController alloc] initWithIDShop:obj.shop.idShop.integerValue];
            
            [self.navigationController pushViewController:vc animated:true];
        }
        else if([cell.object isKindOfClass:[Event class]])
        {
            Event *obj=cell.object;
            
            if(obj.idShops.length>0)
            {
                ListShopViewController *vc=[[ListShopViewController alloc] initWithIDShops:obj.idShops];
                [self.navigationController pushViewController:vc animated:true];
            }
        }
    }
}

-(void)tabHomeImagesCell:(TabHomeImagesCell *)cell selectedImage:(HomeImage *)obj
{
    if(_mode==TABHOME_MODE_HOME)
    {
        ListShopViewController *vc=nil;
        
        if(obj.images.idShops.length>0)
            vc=[[ListShopViewController alloc] initWithIDShops:obj.images.idShops];
        else if(obj.images.idPlacelist)
            vc=[[ListShopViewController alloc] initWithIDPlacelist:obj.images.idPlacelist.integerValue];
        
        if(vc)
            [self.navigationController pushViewController:vc animated:true];
    }
}

-(void)tabHomeShopCellTouchedCover:(TabHomeShopCell *)cell
{
    
}

- (IBAction)btnUserCityTouchUpInside:(id)sender {
}

- (IBAction)btnTabTouchUpInside:(id)sender {
    [self switchToMode:(_mode==TABHOME_MODE_HOME ? TABHOME_MODE_EVENT : TABHOME_MODE_HOME)];
}

- (IBAction)btnExpandTouchUpInside:(id)sender {
    [self animationTitleView];
}

-(void) animationTitleView
{
    if(titleView.SH==55)
    {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
            titleView.SH=99;
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
            titleView.SH=55;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (IBAction)btnMapTouchUpInside:(id)sender {
    
    MapViewController *vc=nil;
    
    switch (_mode) {
        case TABHOME_MODE_HOME:
            vc=[[MapViewController alloc] initHomeMapWithDisplayMode:MAP_DISPLAY_MODE_OBJECT];
            break;
            
        case TABHOME_MODE_EVENT:
            vc=[[MapViewController alloc] initEventMapWithDisplayMode:MAP_DISPLAY_MODE_OBJECT];
            break;
    }
    
    [self.navigationController pushViewController:vc animated:true];
}

@end