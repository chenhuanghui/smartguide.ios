//
//  SGMapController.h
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGMapViewController.h"

@interface SGMapController : UINavigationController<SGMapViewDelegate>
{
    
}

@property (nonatomic, strong, readonly) SGMapViewController *mapViewController;

@end
