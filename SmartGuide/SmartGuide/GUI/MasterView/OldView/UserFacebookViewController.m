//
//  UserFacebookViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserFacebookViewController.h"

@interface UserFacebookViewController ()

@end

@implementation UserFacebookViewController
@synthesize delegate;

-(id)init
{
    self=[super initWithNibName:@"UserFacebookViewController" bundle:nil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)title
{
    return CLASS_NAME;
}

- (IBAction)btn:(id)sender {
    [self.delegate userFacebookSuccessed];
}

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
