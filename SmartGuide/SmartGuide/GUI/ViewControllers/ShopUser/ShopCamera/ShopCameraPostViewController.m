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

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        _img=[_img scaleProportionalToSize:CGSizeMake(102, 102)];
        [imgvPhoto setImage:_img];
        [imgvBG setImage:[_img blur]];
    });

    [imgvPhoto setImage:_img];
    
    txt.isScrollable=false;
    txt.contentInset=UIEdgeInsetsZero;
    txt.minNumberOfLines=1;
    txt.maxNumberOfLines=2;
    txt.returnKeyType=UIReturnKeyDefault;
    txt.enablesReturnKeyAutomatically=true;
    txt.font=[UIFont fontWithName:@"Avenir-Roman" size:12];
    txt.delegate=self;
    txt.internalTextView.scrollIndicatorInsets=UIEdgeInsetsMake(0, 5, 0, 5);
    txt.backgroundColor=[UIColor clearColor];
    txt.placeholder=@"Mô tả hình ảnh...";
    txt.keyboardType=UIKeyboardTypeDefault;
    txt.internalTextView.autocorrectionType=UITextAutocapitalizationTypeNone;
    
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
