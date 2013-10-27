//
//  SGMapController.h
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGMapViewController.h"
#import "ShopUserViewController.h"
#import "PanGestureView.h"

@interface SGMapController : UINavigationController<SGMapViewDelegate,ShopUserDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate,PanGestureDelegate>
{
    UIPanGestureRecognizer *panGes;
    PanGestureView *panHandle;
}

@property (nonatomic, strong, readonly) SGMapViewController *mapViewController;

@end
