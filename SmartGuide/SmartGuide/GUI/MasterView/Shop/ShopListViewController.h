//
//  ShopListViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Constant.h"
#import "SGTableTemplate.h"
#import "ASIOperationShopInGroup.h"
#import "ShopUserViewController.h"
#import <MapKit/MapKit.h>
#import "ACTimeScroller.h"

@class ScrollShopList;

@protocol ShopListDelegate <SGViewControllerDelegate>

-(void) shopListSelectedShop;

@end

@interface ShopListViewController : SGViewController<MKMapViewDelegate,ACTimeScrollerDelegate>
{
    __weak IBOutlet UITableView *tableList;
    __weak IBOutlet MKMapView *map;
    __weak IBOutlet ScrollShopList *scroll;
    CLLocationCoordinate2D _mapCenter;
    float deltaLatFor1px;
    __weak IBOutlet UITextField *txtSearch;
    __weak IBOutlet UIButton *btnMap;
    __weak IBOutlet UIImageView *imgvLine;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *botView;
    __weak IBOutlet UIView *contentView;
    
    CGRect topFrame;
    CGRect botFrame;
    CGPoint _scrollOffset;
    CGRect _searchFrame;
    
    bool _isZoomedMap;
    
    __weak UITapGestureRecognizer *_tapTop;
    
    ACTimeScroller *_timeScroller;
}

@property (nonatomic, assign) id<ShopListDelegate> delegate;
@property (nonatomic, strong) NSString *catalog;

@end

@interface ScrollShopList : UIScrollView

@end