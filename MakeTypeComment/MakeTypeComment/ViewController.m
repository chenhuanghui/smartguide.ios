//
//  ViewController.m
//  MakeTypeComment
//
//  Created by MacMini on 06/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect rect=cmt.frame;
    CommentTyping *com =[CommentTyping new];
    com.frame=rect;
    
    [cmt removeFromSuperview];
    [self.view addSubview:com];
    cmt=com;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([cmt isExpanded])
        [cmt collapse];
    else
        [cmt expand];
}

@end
