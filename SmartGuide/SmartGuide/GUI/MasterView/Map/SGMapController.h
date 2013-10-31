//
//  SGMapController.h
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGNavigationViewController.h"
#import "SGMapViewController.h"
#import "ShopUserViewController.h"
#import "PanDragViewHandle.h"

@interface SGMapController : SGNavigationViewController<SGMapViewDelegate,ShopUserDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate,PanDragViewDelegate>
{
    UIPanGestureRecognizer *panGes;
    PanDragViewHandle *panHandle;
}

@property (nonatomic, strong, readonly) SGMapViewController *mapViewController;

@end
