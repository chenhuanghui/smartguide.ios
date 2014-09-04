//
//  MapViewController.h
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Protocols.h"

@class DataAPI;

enum MAP_DATA_MODE
{
//    MAP_DATA_MODE_SEARCH=0,
    MAP_DATA_MODE_HOME=1,
    MAP_DATA_MODE_EVENT=2,
    MAP_DATA_MODE_SEARCH=3,
};

enum MAP_DISPLAY_MODE
{
    MAP_DISPLAY_MODE_MAP=0,
    MAP_DISPLAY_MODE_OBJECT=1,
};

@class MapViewController;

@protocol MapControllerDataSource <NSObject>

-(NSUInteger) numberOfObjectMapController:(MapViewController*) controller;
-(id<MapObject>) mapController:(MapViewController*) controller objectAtIndex:(NSUInteger) index;
-(void) mapController:(MapViewController*) controller switchToDataMode:(enum MAP_DATA_MODE) mode;
-(void) mapControllerRequestData:(MapViewController*) controller;

@optional
-(void) mapControllerLoadMore:(MapViewController*) controller;

@end

@class MapView, NavigationView, NavigationTitleLabel, ButtonUserCityLocation, HomeDataManager, EventDataManager;

@interface MapViewController : ViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

-(MapViewController*) initWithDisplayMode:(enum MAP_DISPLAY_MODE) displayMode;

-(void) markFinishedLoadMore:(bool) canLoadMore;
-(void) markFinishedLoadData:(bool) canLoadMore;

- (IBAction)btnLocationTouchUpInside:(id)sender;
- (IBAction)btnTabTouchUpInside:(id)sender;
- (IBAction)btnBackTouchUpInside:(id)sender;
- (IBAction)btnExpandTouchUpInside:(id)sender;
- (IBAction)btnUserCityTouchUpInside:(id)sender;

-(void) setDisplayMode:(enum MAP_DISPLAY_MODE) displayMode animate:(bool) animate;

@property (weak, nonatomic) IBOutlet MapView *map;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;
@property (weak, nonatomic) IBOutlet NavigationView *titleView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet NavigationTitleLabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnExpand;
@property (weak, nonatomic) IBOutlet UIView *cityView;
@property (weak, nonatomic) IBOutlet ButtonUserCityLocation *btnUserCity;
@property (weak, nonatomic) IBOutlet UICollectionView *collView;
@property (weak, nonatomic) IBOutlet UIButton *btnTab;
@property (nonatomic, assign) bool canLoadMore;
@property (nonatomic, weak) id<MapControllerDataSource> dataSource;
@property (nonatomic, assign) enum MAP_DISPLAY_MODE displayMode;
@property (nonatomic, assign) enum MAP_DATA_MODE dataMode;

@end

@interface MapViewController(DataAPI)

@property (nonatomic, strong, readwrite) DataAPI *dataAPI;

@end

@interface MapViewController(Home)

-(MapViewController*) initHomeMapWithDisplayMode:(enum MAP_DISPLAY_MODE)displayMode;

@end

@interface MapViewController(Event)

-(MapViewController*) initEventMapWithDisplayMode:(enum MAP_DISPLAY_MODE) displayMode;

@end