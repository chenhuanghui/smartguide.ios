//
//  ShopListScrollerView.h
//  SmartGuide
//
//  Created by MacMini on 26/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopListScrollerView : UIView
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UILabel *lbl;
}

-(void) setText:(NSString*) text;

@end
