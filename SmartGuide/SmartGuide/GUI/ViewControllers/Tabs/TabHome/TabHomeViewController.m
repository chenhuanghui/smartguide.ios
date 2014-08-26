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
#import "TabHomeImagesCell.h"
#import "TabHomeShopCell.h"
#import "NavigationView.h"
#import "TableTemplates.h"

enum TABHOME_MODE
{
    TABHOME_MODE_HOME=0,
    TABHOME_MODE_EVENT=1,
};

@interface TabHomeViewController ()<TableAPIDataSource, UITableViewDelegate, HomeDataDelegate, EventDataDelegate, TabHomeShopCellDelegate>
{
}

@property (nonatomic, assign) enum TABHOME_MODE mode;
@property (nonatomic, strong) HomeDataManager *homeManager;
@property (nonatomic, strong) EventDataManager *eventManager;

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
    
    self.homeManager=[HomeDataManager manager];
    [self.homeManager addObserver:self];
    
    self.eventManager=[EventDataManager manager];
    [self.eventManager addObserver:self];
    
    [table showLoading];
    
    [self.homeManager requestData];
}

-(void)tableLoadMore:(TableAPI *)table
{
    switch (_mode) {
        case TABHOME_MODE_HOME:
            [_homeManager loadMore];
            break;
            
        case TABHOME_MODE_EVENT:
            [_eventManager loadMore];
            break;
    }
}

-(void)homeDataFinished:(HomeDataManager *)dataManager
{
    [table removeLoading];
    
    table.canLoadMore=dataManager.canLoadMore;
    [table reloadData];
}

-(void)homeDataFailed:(HomeDataManager *)dataManager
{
}

-(void)eventDataFinished:(EventDataManager *)dataManager
{
    [table removeLoading];
    
    table.canLoadMore=dataManager.canLoadMore;
    [table reloadData];
}

-(void)eventDataFailed:(EventDataManager *)dataManager
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
                [self.homeManager refreshData];
                break;
                
            case TABHOME_MODE_EVENT:
                [self.eventManager refreshData];
                break;
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (_mode) {
        case TABHOME_MODE_HOME:
            return MIN(_homeManager.homes.count,1);
            
        case TABHOME_MODE_EVENT:
            return MIN(_eventManager.events.count,1);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_mode) {
        case TABHOME_MODE_HOME:
            return _homeManager.homes.count;
            
        case TABHOME_MODE_EVENT:
            return _eventManager.events.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_mode) {
        case TABHOME_MODE_HOME:
        {
            Home *obj=_homeManager.homes[indexPath.row];
            
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
            Event *obj=_eventManager.events[indexPath.row];
            
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
            Home *obj=_homeManager.homes[indexPath.row];
            
            switch (obj.enumType) {
                case HOME_TYPE_IMAGES:
                {
                    TabHomeImagesCell *cell=[tableView tabHomeImagesCell];
                    
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
            Event *obj=_eventManager.events[indexPath.row];
            TabHomeShopCell *cell=[tableView tabHomeShopCell];
            
            [cell loadWithEvent:obj];
            
            return cell;
        }
    }
    
    return tableView.emptyCell;
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
}

@end
