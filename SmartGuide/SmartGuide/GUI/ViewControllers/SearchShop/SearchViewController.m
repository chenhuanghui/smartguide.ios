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

-(SearchViewController *)init
{
    self=[super initWithNibName:@"SearchViewController" bundle:nil];
    
    _keyword=@"";
    _viewMode=SEARCH_VIEW_MODE_SEARCH;
    
    return self;
}

-(SearchViewController *)initWithKeyword:(NSString *)keyword
{
    self=[super initWithNibName:@"SearchViewController" bundle:nil];
    
    _keyword=keyword;
    _viewMode=SEARCH_VIEW_MODE_SEARCH;
    
    return self;
}

-(SearchViewController *)initWithPlace:(Placelist *)place
{
    self=[super initWithNibName:@"SearchViewController" bundle:nil];
    
    _viewMode=SEARCH_VIEW_MODE_LIST;
    _place=place;
    
    return self;
}

-(SearchViewController *)initWithIDShops:(NSString *)idShops
{
    self=[super initWithNibName:@"SearchViewController" bundle:nil];
    
    _viewMode=SEARCH_VIEW_MODE_SHOP_LIST;
    _idShops=[NSString stringWithStringDefault:idShops];
    
    return self;
}

-(SearchViewController *)initWithUserHome3:(UserHome3 *)home3
{
    self=[super initWithNibName:@"SearchViewController" bundle:nil];
    
    _viewMode=SEARCH_VIEW_MODE_HOME_3;
    _home3=home3;
    
    return self;
}

-(SearchViewController *)initWithKeyword:(NSString *)keyword viewMode:(enum SEARCH_VIEW_MODE)viewMode
{
    self=[super initWithNibName:@"SearchViewController" bundle:nil];
    
    _keyword=[keyword copy];
    _viewMode=viewMode;
    
    return self;
}

- (void)dealloc
{
    [searchNavi.view removeFromSuperview];
    searchNavi=nil;
}

-(void)loadView
{
    [super loadView];
    
    UIViewController *root=nil;
    switch (_viewMode) {
            
        case SEARCH_VIEW_MODE_KEYWORK_SHOP_LIST:
        {
            ShopListViewController *vc=[[ShopListViewController alloc] initWithKeyword:_keyword];
            vc.searchController=self;
            vc.delegate=self;
            
            root=vc;
        }
            break;
            
        case SEARCH_VIEW_MODE_LIST:
        {
            ShopListViewController *vc=[[ShopListViewController alloc] initWithPlaceList:_place];
            vc.searchController=self;
            vc.delegate=self;
            
            root=vc;
        }
            break;
            
        case SEARCH_VIEW_MODE_SEARCH:
        {
            SearchShopViewController *vc=[[SearchShopViewController alloc] initWithKeyword:_keyword];
            vc.searchController=self;
            vc.delegate=self;
            
            root=vc;
        }
            break;
            
        case SEARCH_VIEW_MODE_SHOP_LIST:
        {
            ShopListViewController *vc=[[ShopListViewController alloc] initWithIDShops:_idShops];
            vc.searchController=self;
            vc.delegate=self;
            
            root=vc;
        }
            break;
            
        case SEARCH_VIEW_MODE_HOME_3:
        {
            ShopListViewController *vc=[[ShopListViewController alloc] initWithPlaceList:_home3.place];
            vc.searchController=self;
            vc.delegate=self;
            
            root=vc;
        }
            break;
            
        default:
            break;
    }
    
    searchNavi=[[SGNavigationController alloc] initWithRootViewController:root];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [contentView addSubview:searchNavi.view];
    [searchNavi l_v_setS:contentView.l_v_s];
}

-(void)searchShopControllerTouchedBack:(SearchShopViewController *)controller
{
    if(searchNavi.viewControllers.count==1)
    {
        [self.navigationController popViewControllerAnimated:true];
        return;
    }
    
    [searchNavi popViewControllerAnimated:true];
}

-(void)searchShopControllerTouchPlaceList:(SearchShopViewController *)controller placeList:(Placelist *)place
{
    [self showShopListWithPlacelist:place];
}

-(void)searchShopControllerTouchedIDPlacelist:(SearchShopViewController *)controller idPlacelist:(int)idPlacelist
{
    [self showShopListWithIDPlacelist:idPlacelist];
}

-(void)searchShopControllerSearch:(SearchShopViewController *)controller keyword:(NSString *)keyword
{
    [self showShopListWithKeyword:keyword];
}

-(void) showShopListWithKeyword:(NSString*) keyword
{
    ShopListViewController *vc=[[ShopListViewController alloc] initWithKeyword:keyword];
    vc.delegate=self;
    
    [self showShopListController:vc];
}

-(void) showShopListWithIDPlacelist:(int) idPlacelist
{
    ShopListViewController *vc=[[ShopListViewController alloc] initWithIDPlacelist:idPlacelist];
    vc.delegate=self;
    
    [self showShopListController:vc];
}

-(void) showShopListWithPlacelist:(Placelist*) placelist
{
    ShopListViewController *vc=[[ShopListViewController alloc] initWithPlaceList:placelist];
    vc.delegate=self;
    
    [self showShopListController:vc];
}

-(void) showShopListController:(ShopListViewController*) controller
{
    [searchNavi pushViewController:controller onCompleted:^{
        
        NSMutableArray *array=[NSMutableArray array];
        for(UIViewController *vc in searchNavi.viewControllers)
        {
            if([vc isKindOfClass:[ShopListViewController class]])
            {
                if(vc !=controller)
                    [searchNavi removeViewController:vc];
            }
            else if([vc isKindOfClass:[SearchShopViewController class]])
            {
                [array addObject:vc];
            }
        }
        
        if(array.count>=1)
        {
            [array removeLastObject];
        }
        
        for(UIViewController *vc in array)
        {
            [searchNavi removeViewController:vc];
        }
    }];
}

-(void)shopListControllerTouchedTextField:(ShopListViewController *)controller
{
    SearchShopViewController *vc=[[SearchShopViewController alloc] initWithKeyword:controller.keyword];
    vc.delegate=self;
    
    [searchNavi pushViewController:vc animated:true];
}

-(void)shopListControllerTouchedBack:(ShopListViewController *)controller
{
    if(searchNavi.viewControllers.count==1)
        [self.navigationController popViewControllerAnimated:true];
    else
    {
        int idx=[searchNavi.viewControllers indexOfObject:controller];
        
        if([searchNavi.viewControllers[idx-1] isKindOfClass:[SearchShopViewController class]])
        {
            SearchShopViewController *vc=searchNavi.viewControllers[idx-1];
            [vc setKeyword:controller.keyword];
        }
        
        [searchNavi popViewControllerAnimated:true];
    }
}

-(void)viewWillAppearOnce
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end