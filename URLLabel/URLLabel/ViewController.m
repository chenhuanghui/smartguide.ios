//
//  ViewController.m
//  URLLabel
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "ViewController.h"
#import "FTCoreTextView.h"

@interface ViewController ()<FTCoreTextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    FTCoreTextView *txt=[[FTCoreTextView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    
    [txt setText:[@"google.com|even-toed ungulate" stringByAppendingTagName:FTCoreTextTagLink]];
    
    FTCoreTextStyle *style=[txt styleForName:FTCoreTextTagLink];
    
    style.color=[UIColor redColor];
    
    txt.delegate=self;
    
    [self.view addSubview:txt];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)coreTextViewfinishedRendering:(FTCoreTextView *)coreTextView
{
    
}

-(void)coreTextView:(FTCoreTextView *)coreTextView receivedTouchOnData:(NSDictionary *)data
{
    NSURL *url=[data objectForKey:FTCoreTextDataURL];
    
    [[UIApplication sharedApplication] openURL:url];
}

@end
