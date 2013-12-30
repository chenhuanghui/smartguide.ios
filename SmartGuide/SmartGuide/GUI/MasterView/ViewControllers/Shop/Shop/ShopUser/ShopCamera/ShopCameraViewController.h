//
//  ShopCameraViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"
#import "ShopCameraTakeViewController.h"
#import "ShopCameraPostViewController.h"

@interface ShopCameraViewController : SGViewController<ShopCameraTakeDelegate>
{
    __weak SGNavigationController *cameraNavi;
}

@end
