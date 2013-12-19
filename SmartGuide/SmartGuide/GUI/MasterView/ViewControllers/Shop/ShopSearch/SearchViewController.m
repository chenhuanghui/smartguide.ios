//
//  SearchViewController.m
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SearchViewController.h"
#import "ShopListViewController.h"
#import "SearchShopViewController.h"

@interface SearchViewController ()<SearchShopControllerDelegate,ShopListControllerDelegate>

@end

@implementation SearchViewController
@synthesize shopListController,searchShopController;

-(SearchViewController *)initWithSearch
{
    self=[super initWithNibName:@"SearchViewController" bundle:nil];
    
    _viewMode=SEARCH_VIEW_MODE_SEARCH;
    
    return self;
}

-(SearchViewController *)initWithKeyword:(NSString *)keyword
{
    self=[super initWithNibName:@"SearchViewController" bundle:nil];
    
    _viewMode=SEARCH_VIEW_MODE_SEARCH;
    
    return self;
}

-(SearchViewController *)initWithPlaceList:(Placelist *)place
{
    self=[super initWithNibName:@"SearchViewController" bundle:nil];
    
    _viewMode=SEARCH_VIEW_MODE_LIST;
    _place=place;
    
    return self;
}

-(void) storeRect
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    switch (_viewMode) {
        case SEARCH_VIEW_MODE_LIST:
        {
            ShopListViewController *vc=[[ShopListViewController alloc] initWithPlaceList:_place];
            vc.searchController=self;
            vc.delegate=self;
            
            shopListController=vc;
            
            SGNavigationController *navi=[[SGNavigationController alloc] initWithRootViewController:vc];
            
            searchNavi=navi;
            
            [self addChildViewController:searchNavi];
        }
            break;
            
        case SEARCH_VIEW_MODE_SEARCH:
        {
            SearchShopViewController *vc=[[SearchShopViewController alloc] initWithKeyword:@""];
            vc.searchController=self;
            vc.delegate=self;
            
            searchShopController=vc;
            
            SGNavigationController *navi=[[SGNavigationController alloc] initWithRootViewController:vc];
            
            searchNavi=navi;
            
            [self addChildViewController:searchNavi];
        }
            break;
    }
    
    [contentView addSubview:searchNavi.view];
    [searchNavi l_v_setS:contentView.l_v_s];
    
    [self storeRect];
}

-(void)searchShopControllerTouchedBack:(SearchShopViewController *)controller
{
    if(shopListController)
        [searchNavi popToRootViewControllerAnimated:true];
    else
        [self.navigationController popViewControllerAnimated:true];
}

-(void)searchShopControllerTouchPlaceList:(SearchShopViewController *)controller placeList:(Placelist *)place
{
    [searchNavi removeViewController:shopListController];
    
    ShopListViewController *vc=[[ShopListViewController alloc] initWithPlaceList:place];
    vc.delegate=self;
    
    [searchNavi setRootViewController:vc animate:true];
}

-(void)searchShopControllerSearch:(SearchShopViewController *)controller keyword:(NSString *)keyword
{
    ShopListViewController *vc=[[ShopListViewController alloc] initWithKeyword:keyword];
    vc.delegate=self;
    
    shopListController=vc;
    
    [searchNavi setRootViewController:vc animate:true];
}

-(void)shopListControllerTouchedTextField:(ShopListViewController *)controller
{
    [searchNavi removeViewController:searchShopController];
    
    SearchShopViewController *vc=[[SearchShopViewController alloc] initWithKeyword:controller.keyword];
    vc.delegate=self;
    
    [searchNavi pushViewController:vc animated:true];
}

-(void)shopListControllerTouchedBack:(ShopListViewController *)controller
{
    if(searchNavi.viewControllers.count==1)
        [self.navigationController popViewControllerAnimated:true];
    else
        [searchNavi popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
