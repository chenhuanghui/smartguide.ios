//
//  SGUserCollectionViewController.h
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@protocol SGUserCollectionDelegate <NSObject>

-(void) SGUserCollectionSelectedShop;

@end

@interface SGUserCollectionViewController : UIViewController

@property (nonatomic, assign) id<SGUserCollectionDelegate> delegate;

@end
