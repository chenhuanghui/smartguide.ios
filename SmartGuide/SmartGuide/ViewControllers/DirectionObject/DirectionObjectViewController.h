//
//  DirectionShopViewController.h
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "MapView.h"
#import "Shop.h"
#import "ASIOperationShopInGroup.h"
#import "ShopAnnotationView.h"
#import "OperationRouterMap.h"

@protocol DirectionObjectDelegate <NSObject>

-(void) directionObjectDetail:(Shop*) shop;

@end

@interface DirectionObjectViewController : UIViewController<MKMapViewDelegate,ShopAnnotationDelegate,OperationURLDelegate>
{
    MapView *map;
    bool isCalculatingDirection;
    
    OperationRouterMap *operationRouter;;
}

-(DirectionObjectViewController*) initDirectionObject;
-(void) loadWithShops:(NSArray*) shops;
-(void) addShops:(NSArray*) shops;
-(void) removeShops:(NSArray*) shops;

-(void) setFrame:(CGRect) rect;

-(MapView*) mapView;

@property (nonatomic, assign) id<DirectionObjectDelegate> delegate;

@end

@interface DirectionView : UIView

@end