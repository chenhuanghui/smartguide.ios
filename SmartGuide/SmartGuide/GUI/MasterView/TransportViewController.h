//
//  TransportViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"
#import "Constant.h"

@interface TransportViewController : SGViewController

-(TransportViewController*) initWithNavigation:(SGNavigationController*) navi;

@property (nonatomic, weak, readonly) SGNavigationController* navi;

@end
