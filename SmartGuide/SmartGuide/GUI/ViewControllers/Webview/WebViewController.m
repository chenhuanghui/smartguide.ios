//
//  TutorialViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "WebViewController.h"
#import "GUIManager.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

-(WebViewController *)initWithURL:(NSURL *)url
{
    self = [super initWithNibName:@"WebViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _url=[url copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSURLRequest *request=[NSURLRequest requestWithURL:_url];
    [self.webview loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    if([self.webview canGoBack])
        [self.webview goBack];
    else
    {
        if(self.presentingSGViewController)
            [self.presentingSGViewController dismissSGViewControllerAnimated:true completion:nil];
    }
}

@end

@implementation TutorialViewController

- (instancetype)init
{
    self = [super initWithURL:URL(URL_TUTORIAL)];
    if (self) {
        
    }
    return self;
}

@end

@implementation TermsViewController

- (instancetype)init
{
    self = [super initWithURL:URL(URL_TERM)];
    if (self) {
        
    }
    return self;
}

@end