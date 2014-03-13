//
//  CatalogueBlockViewController.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "AlertView.h"
#import "Utility.h"
#import "LocalizationManager.h"

@implementation AlertView

+(void)showWithTitle:(NSString *)title withMessage:(NSString *)message withLeftTitle:(NSString *)leftTitle withRightTitle:(NSString *)rightTitle onOK:(void (^)())onOk onCancel:(void (^)())onCancel
{
    if(title.length==0)
        title=@"Thông báo";
    
    AlertView *alert=nil;
    
    if(rightTitle)
        alert = [[AlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:leftTitle otherButtonTitles:rightTitle, nil];
    else
        alert = [[AlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:leftTitle otherButtonTitles:nil];
    
    [alert setOK:onOk];
    [alert setCancel:onCancel];
    
    [alert show];
}

-(void)show
{
    self.delegate=self;
    
    [super show];
}

+(void)showWarningWithMessage:(NSString *)message onOK:(void (^)())onOk
{
    [AlertView showAlertOKWithTitle:nil withMessage:message onOK:onOk];
}

+(void)showErrorWithMessage:(NSString *)message onOK:(void (^)())onOK
{
    [AlertView showAlertOKWithTitle:nil withMessage:message onOK:onOK];
}

+(void)showAlertOKCancelWithTitle:(NSString *)title withMessage:(NSString *)message onOK:(void (^)())onOK onCancel:(void (^)())onCancel
{
    [AlertView showWithTitle:title withMessage:message withLeftTitle:localizeOK() withRightTitle:localizeCancel() onOK:onOK onCancel:onCancel];
}

+(void)showAlertOKWithTitle:(NSString *)title withMessage:(NSString *)message onOK:(void (^)())onOK
{
    [AlertView showWithTitle:title withMessage:message withLeftTitle:localizeOK() withRightTitle:nil onOK:onOK onCancel:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            if(_onOk)
                _onOk();
            
            _onOk=nil;
            break;
            
        default:
            if(_onCancel)
                _onCancel();
            
            _onCancel=nil;
            break;
    }
}

-(void)setOK:(void (^)())onOK
{
    if(onOK)
        _onOk = [onOK copy];
    else
        _onOk=nil;
}

-(void)setCancel:(void (^)())onCancel
{
    if(onCancel)
        _onCancel=[onCancel copy];
    else
        _onCancel=nil;
}

@end
