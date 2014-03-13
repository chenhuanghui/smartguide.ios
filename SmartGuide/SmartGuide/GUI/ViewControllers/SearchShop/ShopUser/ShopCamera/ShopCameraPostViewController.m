//
//  ShopCameraPostViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopCameraPostViewController.h"
#import "DataManager.h"
#import "FacebookManager.h"

@interface ShopCameraPostViewController ()

@end

@implementation ShopCameraPostViewController
@synthesize delegate;

- (ShopCameraPostViewController *)initWithShop:(Shop *)shop image:(UIImage *)image
{
    self = [super initWithNibName:@"ShopCameraPostViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _img=image;
        _shop=shop;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [imgvBG setImage:[_img blur]];
    [imgvPhoto setImage:_img];
    
    if(currentUser().allowShareCommentFB.boolValue)
        [btnShare setDefaultImage:[UIImage imageNamed:@"button_Facebook.png"] highlightImage:[UIImage imageNamed:@"button_facebook_hidden.png"]];
    else
        [btnShare setDefaultImage:[UIImage imageNamed:@"button_facebook_hidden.png"] highlightImage:[UIImage imageNamed:@"button_Facebook.png"]];
    
    txt.isScrollable=false;
    txt.contentInset=UIEdgeInsetsZero;
    txt.minNumberOfLines=1;
    txt.maxNumberOfLines=2;
    txt.returnKeyType=UIReturnKeyDone;
    txt.enablesReturnKeyAutomatically=true;
    txt.font=[UIFont fontWithName:@"Avenir-Roman" size:12];
    txt.delegate=self;
    txt.internalTextView.scrollIndicatorInsets=UIEdgeInsetsMake(0, 5, 0, 5);
    txt.backgroundColor=[UIColor clearColor];
    txt.placeholder=@"Mô tả hình ảnh...";
    txt.keyboardType=UIKeyboardTypeDefault;
    
    [txt becomeFirstResponder];
}

- (IBAction)btnSendTouchUpInside:(id)sender {
    
    if(txt.text.length==0)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Vui lòng nhập mô tả hình ảnh" onOK:^{
            [txt becomeFirstResponder];
        }];
        return;
    }
    
    [self.delegate shopCameraControllerTouchedDone:self];
}

- (IBAction)btnShareTouchUpInside:(id)sender {
    currentUser().allowShareCommentFB=@(!currentUser().allowShareCommentFB.boolValue);
    [[DataManager shareInstance] save];
    
    if(currentUser().allowShareCommentFB.boolValue)
        [btnShare setDefaultImage:[UIImage imageNamed:@"button_Facebook.png"] highlightImage:[UIImage imageNamed:@"button_Facebook_hidden.png"]];
    else
        [btnShare setDefaultImage:[UIImage imageNamed:@"button_Facebook_hidden.png"] highlightImage:[UIImage imageNamed:@"button_Facebook.png"]];
    
    if(currentUser().allowShareCommentFB.boolValue)
    {
        btnShare.userInteractionEnabled=false;
        
        if([[FacebookManager shareInstance] isLogined])
        {
            if([[FacebookManager shareInstance] permissionTypeForPostToWall]==FACEBOOK_PERMISSION_DENIED)
            {
                [[FacebookManager shareInstance] requestPermissionPostToWallOnCompleted:^(enum FACEBOOK_PERMISSION_TYPE permissionType) {
                    btnShare.userInteractionEnabled=true;
                }];
            }
            else
                btnShare.userInteractionEnabled=true;
        }
        else
        {
            [[FacebookManager shareInstance] loginOnCompleted:^(enum FACEBOOK_PERMISSION_TYPE permissionType) {
                if(permissionType==FACEBOOK_PERMISSION_GRANTED)
                {
                    [[FacebookManager shareInstance] requestPermissionPostToWallOnCompleted:^(enum FACEBOOK_PERMISSION_TYPE permissionType) {
                        btnShare.userInteractionEnabled=true;
                    }];
                }
                else
                    btnShare.userInteractionEnabled=true;
            }];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)desc
{
    return txt.text;
}

@end
