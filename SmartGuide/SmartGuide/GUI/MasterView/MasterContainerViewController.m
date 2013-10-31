//
//  MasterContainerViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "MasterContainerViewController.h"

@interface MasterContainerViewController ()

@end

@implementation MasterContainerViewController
@synthesize toolbarFrame,contentFrame,adsFrame,qrFrame,content_adsFrame,mapFrame,topFrame,ads_mapView,ads_mapFrame;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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