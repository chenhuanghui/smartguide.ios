//
//  UserLoginViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"

@protocol UserLoginDelegate <NSObject>

-(void) userLoginSuccessed;

@end

@interface UserLoginViewController : ViewController

@property (nonatomic, assign) id<UserLoginDelegate> delegate;

@end
