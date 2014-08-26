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

enum MAP_DATA_MODE
{
//    MAP_DATA_MODE_SEARCH=0,
    MAP_DATA_MODE_HOME=1,
    MAP_DATA_MODE_EVENT=2,
};

@class MapViewController;

@protocol MapObject<NSObject, MKAnnotation>

-(NSString*) mapTitle;
-(NSString*) mapContent;
-(NSString*) mapLogo;
-(NSString*) mapName;
-(NSString*) mapDesc;

@end

@protocol MapControllerDataSource <NSObject>

-(NSUInteger) numberOfObjectMapController:(MapViewController*) controller;
-(id<MapObject>) mapController:(MapViewController*) controller objectAtIndex:(NSUInteger) index;

@end

@class MapView, NavigationView, NavigationTitleLabel, ButtonUserCityLocation, HomeDataManager, EventDataManager;

@interface MapViewController : ViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (IBAction)btnLocationTouchUpInside:(id)sender;
- (IBAction)btnTabTouchUpInside:(id)sender;
- (IBAction)btnBackTouchUpInside:(id)sender;
- (IBAction)btnExpandTouchUpInside:(id)sender;
- (IBAction)btnUserCityTouchUpInside:(id)sender;

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

@end