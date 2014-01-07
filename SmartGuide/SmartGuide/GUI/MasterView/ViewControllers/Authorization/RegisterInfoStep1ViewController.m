//
//  RegisterInfoStep1ViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RegisterInfoStep1ViewController.h"

@interface RegisterInfoStep1ViewController ()

@end

@implementation RegisterInfoStep1ViewController
@synthesize delegate,registerController;

- (id)init
{
    self = [super initWithNibName:@"RegisterInfoStep1ViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [txt addTarget:self action:@selector(textFieldDidChangedText:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) textFieldDidChangedText:(UITextField*) textField
{
    btnName.hidden=textField.text.length>0;
}

- (IBAction)btnAvatarTouchUpInside:(id)sender {
    [self.delegate registerInfoStep1ControllerTouchedAvatar:self];
}

- (IBAction)btnNameTouchUpInside:(id)sender {
    [txt becomeFirstResponder];
}

-(void)focusName
{
    [txt becomeFirstResponder];
}

-(NSString *)avatar
{
    return _avatar;
}

-(UIImage *)avatarImage
{
    return _avatarImage;
}

-(void)setAvatarImage:(UIImage *)avatar
{
    _avatarImage=avatar;
    _avatar=@"";
    [btnAvatar setImage:avatar forState:UIControlStateNormal];
    btnSelectAvatar.hidden=true;
}

-(void)setAvatar:(NSString *)avatar
{
    _avatar=avatar;
    _avatarImage=nil;
    btnSelectAvatar.hidden=true;;
    [btnAvatar.imageView loadAvatarWithURL:avatar completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(image)
            [btnAvatar setImage:image forState:UIControlStateNormal];
    }];
}

-(NSString *)name
{
    return txt.text;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:true];
}

@end
