//
//  TutorialViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TutorialViewController.h"
#import "GUIManager.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

-(id)init
{
    self = [super initWithNibName:@"TutorialViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(TutorialViewController *)initWithURL:(NSString *)url
{
    self = [super initWithNibName:@"TutorialViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _url=[NSString stringWithStringDefault:url];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(_url.length==0)
        _url=@"http://infory.vn/mobile/guide";
    
    NSURL *url=[NSURL URLWithString:_url];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.delegate tutorialTouchedBack:self];
}

@end
