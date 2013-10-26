//
//  UserFacebookViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"

@protocol UserFacebookDelegate <NSObject>

-(void) userFacebookSuccessed;

@end

@interface UserFacebookViewController : ViewController

@property (nonatomic, assign) id<UserFacebookDelegate> delegate;

@end
