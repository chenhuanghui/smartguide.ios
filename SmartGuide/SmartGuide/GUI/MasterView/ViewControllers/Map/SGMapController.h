//
//  SGMapController.h
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGNavigationController.h"
#import "SGMapViewController.h"
#import "ShopUserViewController.h"

@interface SGMapController : SGNavigationController<SGMapViewDelegate,ShopUserDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>
{
}

@property (nonatomic, weak, readonly) SGMapViewController *mapViewController;

@end