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
#import "ShopListSortView.h"

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
    __weak IBOutlet UIButton *btnMap;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *botView;
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet ShopListSortView *sortView;
    
    CGRect topFrame;
    CGRect botFrame;
    CGPoint _scrollOffset;
    
    bool _isZoomedMap;
    
    __weak UITapGestureRecognizer *_tapTop;
    __weak UITapGestureRecognizer *_tapBot;
}

@property (nonatomic, assign) id<ShopListDelegate> delegate;
@property (nonatomic, strong) NSString *catalog;

@end

@interface ScrollShopList : UIScrollView<UIGestureRecognizerDelegate>

@end

@protocol ShopListScrollerDelegate <NSObject>

-(UIScrollView*) scrollView;

@end
