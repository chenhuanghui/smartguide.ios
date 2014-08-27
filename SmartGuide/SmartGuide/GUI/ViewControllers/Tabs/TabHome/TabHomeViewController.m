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
#import "MapViewController.h"
#import "HomeShop.h"
#import "ShopInfo.h"

enum TABHOME_MODE
{
    TABHOME_MODE_HOME=0,
    TABHOME_MODE_EVENT=1,
};

@interface HomeShop(MapObject)<MapObject>

@end

@interface Event(MapObject)<MapObject>

@end

@interface TabHomeViewController ()<TableAPIDataSource, UITableViewDelegate, HomeDataDelegate, EventDataDelegate, TabHomeShopCellDelegate, MapControllerDataSource>
{
}

@property (nonatomic, assign) enum TABHOME_MODE mode;
@property (nonatomic, strong) HomeDataManager *homeManager;
@property (nonatomic, strong) EventDataManager *eventManager;
@property (nonatomic, weak) MapViewController *mapControlelr;

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
    
    if(self.mapControlelr)
        [self.mapControlelr markFinishedLoadMore:dataManager.canLoadMore];
}

-(void)homeDataFailed:(HomeDataManager *)dataManager
{
}

-(void)eventDataFinished:(EventDataManager *)dataManager
{
    [table removeLoading];
    
    table.canLoadMore=dataManager.canLoadMore;
    [table reloadData];
    
    if(self.mapControlelr)
        [self.mapControlelr markFinishedLoadMore:dataManager.canLoadMore];
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
                
                [self.eventManager close];
                self.eventManager=[EventDataManager new];
                [self.eventManager addObserver:self];
                
                break;
                
            case TABHOME_MODE_EVENT:
                
                [self.eventManager refreshData];
                
                [self.homeManager close];
                self.homeManager=[HomeDataManager new];
                [self.homeManager addObserver:self];
                
                break;
        }
        
        table.canLoadMore=false;
        [table reloadData];
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
    MapViewController *vc=[[MapViewController alloc] initWithDisplayMode:MAP_DISPLAY_MODE_OBJECT];
    vc.dataSource=self;
    vc.canLoadMore=true;
    vc.dataMode=_mode==TABHOME_MODE_EVENT?MAP_DATA_MODE_EVENT:MAP_DATA_MODE_HOME;
    
    self.mapControlelr=vc;
    
    [self.navigationController pushViewController:vc animated:true];
}

-(NSUInteger)numberOfObjectMapController:(MapViewController *)controller
{
    switch (controller.dataMode) {
        case MAP_DATA_MODE_HOME:
            return _homeManager.homesMap.count;
            
        case MAP_DATA_MODE_EVENT:
            return _eventManager.eventsMap.count;
            
        default:
            return 0;
    }
}

-(id<MapObject>)mapController:(MapViewController *)controller objectAtIndex:(NSUInteger)index
{
    switch (controller.dataMode) {
        case MAP_DATA_MODE_HOME:
        {
            Home *home=_homeManager.homesMap[index];
            
            return home.homeShop;
        }
            
        case MAP_DATA_MODE_EVENT:
        {
            Event *obj=_eventManager.eventsMap[index];
            
            return obj;
        }
            
        default:
            return nil;
    }
}

-(void)mapControllerLoadMore:(MapViewController *)controller
{
    switch (controller.dataMode) {
        case MAP_DATA_MODE_HOME:
            [_homeManager loadMore];
            break;
            
        case MAP_DATA_MODE_EVENT:
            [_eventManager loadMore];
            break;
            
        default:
            break;
    }
}

-(void)mapController:(MapViewController *)controller switchToDataMode:(enum MAP_DATA_MODE)mode
{
    controller.canLoadMore=false;
}

@end

@implementation HomeShop(MapObject)

-(NSString *)mapContent
{
    return [NSString makeString:self.content];
}

-(NSString *)mapDesc
{
    return [NSString makeString:self.date];
}

-(NSString *)mapLogo
{
    return [NSString makeString:self.shop.logo];
}

-(NSString *)mapName
{
    return [NSString makeString:self.shop.name];
}

-(NSString *)mapTitle
{
    return [NSString makeString:self.title];
}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.shop.shopLat.doubleValue, self.shop.shopLng.doubleValue);
}

-(NSString *)title
{
    return [NSString makeString:self.shop.name];
}

@end

@implementation Event(MapObject)

-(NSString *)mapContent
{
    return [NSString makeString:self.desc];
}

-(NSString *)mapDesc
{
    return [NSString makeString:self.date];
}

-(NSString *)mapLogo
{
    return [NSString makeString:self.logo];
}

-(NSString *)mapName
{
    return [NSString makeString:self.brandName];
}

-(NSString *)mapTitle
{
    return [NSString makeString:self.title];
}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.shopLat.doubleValue, self.shopLng.doubleValue);
}

@end