//
//  FrontViewController.h
//  SmartGuide
//
//  Created by XXX on 7/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "CatalogueBlockViewController.h"
#import "NavigationBarView.h"
#import "CatalogueListViewController.h"
#import "NavigationViewController.h"

@class Group;

@interface FrontViewController : NavigationViewController<CatalogueBlockViewDelegate,UIGestureRecognizerDelegate,NavigationBarDelegate,CatalogueListViewDelegate>
{
    bool _isShowedCatalogueBlock;
    bool _isDraggingCatalogueBlock;
    bool _isHideCatalogueBlockForUserCollection;
}

-(void) setFrame:(CGRect) frame;

-(void) showCatalogueBlock:(bool) animated;
-(void) hideCatalogueBlock:(bool) animated;
-(void) showCatalogueBlockForUserCollection;
-(void) hideCatalogueBlockForUserCollection;
-(bool) isHidedCatalogBlockForUserCollection;
-(bool) isShowedCatalogueBlock;
-(bool) isDraggingCatalogueBlock;
-(ViewController *)currentVisibleViewController;
-(bool) handlePanGestureShouldBegin:(UIPanGestureRecognizer*) panGesture;
-(bool) handlePanGesture:(UIPanGestureRecognizer*) panGesture;

@property (nonatomic, strong) CatalogueBlockViewController *catalogueBlock;
@property (nonatomic, strong) CatalogueListViewController *catalogueList;
@property (nonatomic, assign) bool isPushingViewController;

-(void) gesturePanCatalogue:(UIPanGestureRecognizer*) pan;

@end