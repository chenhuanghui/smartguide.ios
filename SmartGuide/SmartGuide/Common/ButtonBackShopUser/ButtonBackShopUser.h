//
//  ButtonBackShopUser.h
//  SmartGuide
//
//  Created by MacMini on 21/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonBackShopUser : UIButton
{
}

-(void) startShowAnimateOnCompleted:(void(^)(UIButton* btn)) completed;
-(void) startHideAnimateOnCompleted:(void(^)(UIButton* btn)) completed;

@end
