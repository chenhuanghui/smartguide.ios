//
//  MapViewController.m
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "MapViewController.h"
#import "MapCollectionCell.h"
#import "Utility.h"
#import "MapView.h"
#import "ImageManager.h"
#import "LoadMoreView.h"
#import "NavigationView.h"

#define MAP_ZOOM_LEVEL 18
#define MAP_ALIGN 0.0008f

@interface MapViewController ()<MKMapViewDelegate>
{
    bool _loadingMore;
    bool _loadedMap;
}

@end

@implementation MapViewController

-(MapViewController *)initWithDisplayMode:(enum MAP_DISPLAY_MODE)displayMode
{
    self=[super init];
    
    _displayMode=displayMode;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _btnTab.titleLabel.font=_lblTitle.font;
    
    [_map setCenterCoordinate:_map.centerCoordinate zoomLevel:MAP_ZOOM_LEVEL animated:false];
    
    [self setDisplayMode:_displayMode animate:false];
    
    [_collView registerMapCollectionCell];
    
    UIImage *img=[[UIImage imageNamed:@"bg_notify.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 10, 5)];
    
    [_btnLocation setBackgroundImage:img forState:UIControlStateNormal];
    
    if(self.dataSource)
        [self reloadData];
    
    [self makeTitleWithMode:self.dataMode];
}

-(void)setDataMode:(enum MAP_DATA_MODE)dataMode
{
    _dataMode=dataMode;
    
    [self makeTitleWithMode:dataMode];
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    if(_loadedMap)
        return;
    
    _loadedMap=true;
    switch (_displayMode) {
        case MAP_DISPLAY_MODE_OBJECT:
        {
            if(_map.annotations.count>0)
            {
                id<MapObject> obj=_map.annotations[0];
                CLLocationCoordinate2D coord=[self coordInMap:[obj coordinate]];
                
                [_map setCenterCoordinate:coord zoomLevel:MAP_ZOOM_LEVEL animated:false];
            }
        }
            break;
            
        case MAP_DISPLAY_MODE_MAP:
            [_map zoomToFitAnnotations:_map.annotations zoomLevel:MAP_ZOOM_LEVEL animate:false];
            break;
    }
}

-(CLLocationCoordinate2D) coordInMap:(CLLocationCoordinate2D) coord
{
    coord.latitude-=MAP_ALIGN;
    
    return coord;
}

-(void)setDataSource:(id<MapControllerDataSource>)dataSource
{
    _dataSource=dataSource;
    
    [self reloadData];
}

-(void)markFinishedLoadMore:(bool)canLoadMore
{
    [_collView reloadData];
    
    int count=[self.dataSource numberOfObjectMapController:self];
    int i=0;
    while (i<count) {
        id<MapObject> obj=[self.dataSource mapController:self objectAtIndex:i];
        
        if(![_map.annotations containsObject:obj])
            [_map addAnnotation:obj];
        
        i++;
    }
    
    _loadingMore=false;
    self.canLoadMore=canLoadMore;
    
    if(self.canLoadMore)
    {
        _collView.contentInset=UIEdgeInsetsMake(0, 0, 0, _collView.SW);
        
        [_collView showLoadMoreInRect:CGRectMake(count*_collView.SW, 0, _collView.SW, _collView.SH)];
    }
    else
    {
        _collView.contentInset=UIEdgeInsetsZero;
        
        [_collView removeLoadMore];
    }
}

-(void) reloadData
{
    [_collView removeLoading];
    [_collView reloadData];
    
    [_map removeAnnotations:_map.annotations];
    
    int count=[self.dataSource numberOfObjectMapController:self];
    int i=0;
    while (i<count) {
        id<MapObject> obj=[self.dataSource mapController:self objectAtIndex:i];
        
        [_map addAnnotation:obj];
        
        i++;
    }
    
    if(self.canLoadMore)
    {
        _collView.contentInset=UIEdgeInsetsMake(0, 0, 0, _collView.SW);
        
        [_collView showLoadMoreInRect:CGRectMake(count*_collView.SW, 0, _collView.SW, _collView.SH)];
    }
    else
    {
        _collView.contentInset=UIEdgeInsetsZero;
        
        [_collView removeLoadMore];
    }
}

#pragma mark MapView delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *pin=[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    
    if(!pin)
    {
        pin=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
        pin.image=[UIImage imageNamed:@"icon_pin.png"];
        
        UIImageView *imgv=[[UIImageView alloc] initWithFrame:CGRectMake(6, 4, 36, 36)];
        imgv.clipsToBounds=true;
        imgv.layer.cornerRadius=imgv.SW/2;
        imgv.layer.borderWidth=1;
        imgv.layer.borderColor=[UIColor whiteColor].CGColor;
        imgv.tag=123;
        [pin addSubview:imgv];
    }
    
    UIImageView *imgv=(id)[pin viewWithTag:123];
    id<MapObject> obj=(id)annotation;
    NSString *logoUrl=[obj mapLogo];
    
    if([obj respondsToSelector:@selector(mapPinLogo)])
        logoUrl=[obj mapPinLogo];
    
    [imgv defaultLoadImageWithURL:logoUrl];
    
    return pin;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"didSelectAnnotationView %@",view.annotation);
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"didDeselectAnnotationView %@",view.annotation);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_collView.numberOfSections==0
       || [_collView numberOfItemsInSection:0]==0)
        return;
    
    if(scrollView.COX+scrollView.SW>scrollView.CSW)
    {
        if(_canLoadMore)
        {
            if(!_loadingMore)
            {
                _loadingMore=true;
                
                [self.dataSource mapControllerLoadMore:self];
            }
        }
        
        return;
    }
    
    CGPoint pnt=scrollView.contentOffset;
    
    pnt.x-=1;
    
    if(pnt.x<0)
        pnt.x=0;
    
    NSIndexPath *idx=[_collView indexPathForItemAtPoint:pnt];
    NSIndexPath *idx2=[NSIndexPath indexPathForItem:idx.item+1 inSection:0];
    
    if(idx2.item>=[_collView numberOfItemsInSection:0])
        return;
    
    id<MapObject> obj1=[self.dataSource mapController:self objectAtIndex:idx.item];
    id<MapObject> obj2=[self.dataSource mapController:self objectAtIndex:idx2.item];
    
    CLLocationCoordinate2D coord1=[obj1 coordinate];
    CLLocationCoordinate2D coord2=[obj2 coordinate];
    
    coord1.latitude-=MAP_ALIGN;
    coord2.latitude-=MAP_ALIGN;
    
    float offsetX=scrollView.contentOffset.x;
    
    while (offsetX>320) {
        offsetX-=320;
    }
    
    float x=offsetX/320;
    
    float lat=x*(coord2.latitude-coord1.latitude);
    float lng=x*(coord2.longitude-coord1.longitude);
    
    CLLocationCoordinate2D coord=CLLocationCoordinate2DMake(coord1.latitude+lat, coord1.longitude+lng);
    
    [_map setCenterCoordinate:coord];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLocationTouchUpInside:(id)sender {
}

- (IBAction)btnTabTouchUpInside:(id)sender {
    
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)btnExpandTouchUpInside:(id)sender {
    [self animationTitleView];
}

- (IBAction)btnUserCityTouchUpInside:(id)sender {
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if(!self.dataSource)
        return 0;

    return MIN([self.dataSource numberOfObjectMapController:self],1);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource numberOfObjectMapController:self];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.S;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MapCollectionCell *cell=[collectionView mapCollectionCell:indexPath];
    id<MapObject> obj=[self.dataSource mapController:self objectAtIndex:indexPath.item];
    
    [cell loadWithMapObject:obj];
    
    return cell;
}

-(void)setDisplayMode:(enum MAP_DISPLAY_MODE)displayMode animate:(bool)animate
{
    _displayMode=displayMode;
    
    if(animate)
    {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        } completion:^(BOOL finished) {
            [self setDisplayMode:displayMode animate:false];
        }];
    }
    else
    {
        switch (displayMode) {
            case MAP_DISPLAY_MODE_MAP:
                _btnLocation.O=CGPointMake(15, _cityView.yh+15);
                _collView.OY=self.view.SH;
                
                _map.userInteractionEnabled=true;
                
                break;
                
            case MAP_DISPLAY_MODE_OBJECT:
                _btnLocation.O=CGPointMake(15, _cityView.OY);
                _collView.OY=self.view.SH-_collView.SH;
                
#if DEBUG
                _map.userInteractionEnabled=true;
#else
                _map.userInteractionEnabled=false;
#endif
                break;
        }
    }
}

-(void)setDisplayMode:(enum MAP_DISPLAY_MODE)displayMode
{
    [self setDisplayMode:displayMode animate:false];
}

-(void) animationTitleView
{
    if(_titleView.SH==55)
    {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
            _titleView.SH=99;
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
            _titleView.SH=55;
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void) makeTitleWithMode:(enum MAP_DATA_MODE) mode
{
    switch (mode) {
        case MAP_DATA_MODE_HOME:
            _lblTitle.text=@"Khám phá";
            [_btnTab setTitle:@"Sự kiện" forState:UIControlStateNormal];
            break;
            
        case MAP_DATA_MODE_EVENT:
            _lblTitle.text=@"Sự kiện";
            [_btnTab setTitle:@"Khám phá" forState:UIControlStateNormal];
            break;
            
        case MAP_DATA_MODE_SEARCH:
            _lblTitle.text=@"Địa điểm xung quanh";
            [_btnTab setTitle:@"" forState:UIControlStateNormal];
            break;
    }
}

-(void) swithToDataMode:(enum MAP_DATA_MODE) mode
{
    _btnTab.hidden=mode==MAP_DATA_MODE_SEARCH;
    _btnExpand.hidden=mode==MAP_DATA_MODE_SEARCH;
    
    [self makeTitleWithMode:mode];
    
    if(mode!=MAP_DATA_MODE_SEARCH)
    {
        [_collView showLoading];
        
        [_collView setContentOffset:CGPointZero animated:true completion:^{
            
            _dataMode=mode;
            [self.dataSource mapController:self switchToDataMode:mode];
            [self reloadData];
        }];
    }
}

@end