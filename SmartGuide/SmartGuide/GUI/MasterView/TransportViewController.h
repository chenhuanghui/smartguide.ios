//
//  TransportViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface TransportViewController : UIViewController

-(TransportViewController*) initWithNavigation:(UINavigationController*) navi;

@property (nonatomic, readonly) UINavigationController* navi;

@end
