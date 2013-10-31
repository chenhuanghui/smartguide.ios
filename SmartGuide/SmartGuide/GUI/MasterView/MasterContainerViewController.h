//
//  MasterContainerViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ads_MapView;

@interface MasterContainerViewController : UIViewController

-(float) hideAdsWithAnimation:(bool) isAnimation;

@property (weak, nonatomic) IBOutlet UIView *containtView;
@property (weak, nonatomic) IBOutlet UIView *toolbarView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *adsView;
@property (weak, nonatomic) IBOutlet UIView *qrView;
@property (weak, nonatomic) IBOutlet UIView *content_ads_upper;
@property (weak, nonatomic) IBOutlet UIView *content_ads_middle;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet Ads_MapView *ads_mapView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic, readonly) CGRect toolbarFrame;
@property (nonatomic, readonly) CGRect contentFrame;
@property (nonatomic, readonly) CGRect adsFrame;
@property (nonatomic, readonly) CGRect qrFrame;
@property (nonatomic, readonly) CGRect content_adsFrame;
@property (nonatomic, readonly) CGRect mapFrame;
@property (nonatomic, readonly) CGRect topFrame;
@property (nonatomic, readonly) CGRect ads_mapFrame;

@end

@interface Ads_MapView : UIView

@property (nonatomic, weak) UIView *mapView;
@property (nonatomic, weak) UIView *adsView;

@end