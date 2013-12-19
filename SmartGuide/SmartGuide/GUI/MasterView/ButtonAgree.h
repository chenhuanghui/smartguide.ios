//
//  ButtonAgree.h
//  MakeButtonAgree
//
//  Created by MacMini on 05/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface ButtonAgree : UIButton
{
    NSString *_buttonTitle;
}

-(void) setTitle:(NSString*) text agreeStatus:(enum AGREE_STATUS) status;

@property (nonatomic, readonly) enum AGREE_STATUS agreeStatus;

@end