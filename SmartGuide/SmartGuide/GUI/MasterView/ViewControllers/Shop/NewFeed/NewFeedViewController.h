//
//  ShopCategoriesViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class NewFeedViewController;

@protocol NewFeedControllerDelegate <SGViewControllerDelegate>

-(void) newFeedControllerTouchedTextField:(NewFeedViewController*) controller;

@end

@interface NewFeedViewController : SGViewController<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *txt;
}

@property (nonatomic, assign) id<NewFeedControllerDelegate> delegate;

@end
