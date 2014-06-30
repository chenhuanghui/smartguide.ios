//
//  ScanCodeController.h
//  Infory
//
//  Created by XXX on 6/30/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class SGNavigationController;

@interface ScanCodeController : SGViewController
{
    __weak IBOutlet UIView *contentView;
    
    __strong SGNavigationController *_navi;
}

@end
