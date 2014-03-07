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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *url=[NSURL URLWithString:@"http://infory.vn/mobile/guide"];
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
