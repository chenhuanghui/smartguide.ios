//
//  WelcomeViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "WelcomeViewController.h"
#import "Flags.h"
#import "TokenManager.h"

@interface WelcomeViewController ()<WebViewDelegate>

@end

@implementation WelcomeViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"WelcomeViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if([UIScreen mainScreen].bounds.size.height==568.f)
        imgvBackground.image=[UIImage imageNamed:@"Default-568h.png"];
    else
        imgvBackground.image=[UIImage imageNamed:@"Default.png"];
    
    [SGData shareInstance].fScreen=[WelcomeViewController screenCode];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    [dict setObject:[UIFont fontWithName:@"Georgia-Italic" size:13] forKey:NSFontAttributeName];
    [dict setObject:[UIColor color255WithRed:53 green:158 blue:239 alpha:255] forKey:NSForegroundColorAttributeName];
    
    NSAttributedString *attStr=[[NSAttributedString alloc] initWithString:@"Điều khoản sử dụng" attributes:dict];
    [btnDk setAttributedTitle:attStr forState:UIControlStateNormal];
}

+(NSString *)screenCode
{
    return SCREEN_CODE_WELCOME;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [imgvBackground l_v_setY:-UIStatusBarHeight()];
    [imgvBackground l_v_setS:UIScreenSize()];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTryTouchUpInside:(id)sender {
    [self.delegate welcomeControllerTouchedTry:self];
}

- (IBAction)btnLoginTouchUpInside:(id)sender {
    
    [self.delegate welcomeControllerTouchedLogin:self];
}

- (IBAction)btnTermTouchUpInside:(id)sender
{
    [self showWebViewWithURL:URL(URL_TERM) onCompleted:nil];
}

@end
