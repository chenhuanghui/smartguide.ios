//
//  SGUserCollectionViewController.h
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Constant.h"

@protocol SGUserCollectionDelegate <SGViewControllerDelegate>

-(void) SGUserCollectionSelectedShop;

@end

@interface SGUserCollectionViewController : SGViewController

@property (nonatomic, assign) id<SGUserCollectionDelegate> delegate;

@end
