//
//  UserLoginViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserLoginViewController.h"

#define DURATION_RESET_SMS 30

#if DEBUG
#define SKIP_INPUT_PHONE 1
#endif

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController
@synthesize delegate;

-(id)init
{
    self=[super initWithNibName:@"UserLoginViewController" bundle:nil];
    
    return self;
}

-(NSArray *)registerNotifications
{
    return @[UIApplicationWillResignActiveNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationWillResignActiveNotification])
    {
        [Flurry trackUserHideAppWhenLogin];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationGetActionCode class]])
    {
        OperationGetActionCode *ope=(OperationGetActionCode*) operation;
        
        if(ope.isSuccess)
        {
            txtPhone.text=@"";
//            _phone=ope.
        }
        else
            [AlertView showAlertOKWithTitle:nil withMessage:ope.message onOK:nil];
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginTouchUpInside:(id)sender {
    
    NSString *phone=txtPhone.text;
    phone=[@"84" stringByAppendingString:phone];
    
    _operationGetActionCode=[[OperationGetActionCode alloc] initWithPhone:phone];
    _operationGetActionCode.delegate=self;
    
    [_operationGetActionCode start];
}

@end
