//
//  CatalogueBlockViewController.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertView : UIAlertView
{
    void(^_onOk)();
    void(^_onCancel)();
    
    UIAlertView *alert;
}

+(void) showWarningWithMessage:(NSString*) message onOK:(void(^)()) onOk;
+(void) showErrorWithMessage:(NSString*) message onOK:(void(^)()) onOK;
+(void) showWithTitle:(NSString*) title withMessage:(NSString*) message withLeftTitle:(NSString*) leftTitle withRightTitle:(NSString*) rightTitle onOK:(void(^)()) onOk onCancel:(void(^)()) onCancel;

+(void) showAlertOKCancelWithTitle:(NSString*) title withMessage:(NSString*) message onOK:(void(^)()) onOK onCancel:(void(^)()) onCancel;
+(void) showAlertOKWithTitle:(NSString*) title withMessage:(NSString*) message onOK:(void(^)()) onOK;

-(void) setOK:(void(^)()) onOK;
-(void) setCancel:(void(^)()) onCancel;

@end