//
//  NavigationTitleView.h
//  SmartGuide
//
//  Created by XXX on 7/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationTitleView : UIView
{
    __weak IBOutlet UILabel *lbl;
    __weak IBOutlet UIButton *btn;
    
}

-(NavigationTitleView*) initWithTitle:(NSString*) title withTarget:(id) target withAction:(SEL) selector;
-(void) setTitle:(NSString*) title;

@end
