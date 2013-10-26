//
//  SGMapViewController.h
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@protocol SGMapViewDelegate <NSObject>

-(void) SGMapViewSelectedShop;

@end

@interface SGMapViewController : UIViewController

@property (nonatomic, assign) id<SGMapViewDelegate> delegate;

@end
