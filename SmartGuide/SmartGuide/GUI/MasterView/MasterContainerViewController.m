//
//  MasterContainerViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "MasterContainerViewController.h"
#import "Constant.h"

@interface MasterContainerViewController ()

@end

@implementation MasterContainerViewController
@synthesize toolbarFrame,contentFrame,adsFrame,qrFrame,content_adsFrame,mapFrame,topFrame,ads_mapView,ads_mapFrame;
@synthesize toolbarController,contentControlelr,adsController,mapController,qrCodeController;
@synthesize delegate;

-(MasterContainerViewController *)initWithDelegate:(id<MasterControllerDelegate>)_delegate
{
    self = [super initWithNibName:@"MasterContainerViewController" bundle:nil];
    
    self.delegate=_delegate;
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=COLOR_BACKGROUND_APP;
    
    ads_mapView.mapView=self.mapView;
    ads_mapView.adsView=self.adsView;
    
    toolbarFrame=self.toolbarView.frame;
    contentFrame=self.contentView.frame;
    adsFrame=self.adsView.frame;
    qrFrame=self.qrView.frame;
    content_adsFrame=self.content_ads_upper.frame;
    mapFrame=self.mapView.frame;
    topFrame=self.topView.frame;
    ads_mapFrame=self.ads_mapView.frame;
    
    CGRect rect=mapController.view.frame;
    rect.origin.y=self.mapView.frame.size.height-10;
    mapController.view.frame=rect;
    
    [self.toolbarView addSubview:toolbarController.view];
    [self.contentView addSubview:contentControlelr.view];
    [self.mapView addSubview:mapController.view];
    [self.adsView addSubview:adsController.view];
    [self.qrView addSubview:qrCodeController.view];
}

-(void)loadView
{
    [super loadView];
    
    [self loadToolbarController];
    [self loadContentController];
    [self loadMapController];
    [self loadAdsController];
    [self loadQRCodeControlelr];
    
    [self.delegate masterContainerLoadedView:self];
}

-(void) loadToolbarController
{
    ToolbarViewController *vc=[[ToolbarViewController alloc] init];
    toolbarController=vc;
    
    [self addChildViewController:vc];
}

-(void) loadContentController
{
    ContentViewController *vc=[[ContentViewController alloc] init];
    contentControlelr=vc;
    
    [vc showShopController];
    
    [self addChildViewController:vc];
}

-(void) loadAdsController
{
    SGAdsViewController *vc=[[SGAdsViewController alloc] init];
    adsController=vc;
    
    [self addChildViewController:vc];
}

-(void) loadMapController
{
    SGMapController *vc=[[SGMapController alloc] init];
    mapController=vc;
    
    [self addChildViewController:vc];
}

-(void) loadQRCodeControlelr
{
    SGQRCodeViewController *vc=[[SGQRCodeViewController alloc] init];
    qrCodeController=vc;
    
    [self addChildViewController:vc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(float)hideAdsWithAnimation:(bool)isAnimation
{
    float height = self.adsView.frame.size.height;
    
    CGRect rect=self.adsView.frame;
    rect.origin.y=rect.size.height;
    self.adsView.frame=rect;
    
    return height;
}

CALL_DEALLOC_LOG

@end

@implementation Ads_MapView
@synthesize mapView,adsView;

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(mapView.userInteractionEnabled && [mapView pointInside:[self convertPoint:point toView:mapView] withEvent:event])
        return true;
    else if([adsView pointInside:[self convertPoint:point toView:adsView] withEvent:event])
        return true;
    
    return false;
}

@end