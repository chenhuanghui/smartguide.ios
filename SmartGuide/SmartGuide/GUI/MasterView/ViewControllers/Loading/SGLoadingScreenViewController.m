//
//  SGLoadingScreenViewController.m
//  SmartGuide
//
//  Created by MacMini on 31/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGLoadingScreenViewController.h"
#import "TokenManager.h"

@interface SGLoadingScreenViewController ()

@end

@implementation SGLoadingScreenViewController
@synthesize delegate;

- (id)init
{
    self=[super initWithNibName:@"SGLoadingScreenViewController" bundle:nil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *accessToken=[TokenManager shareInstance].accessToken;
    NSString *version=[NSString stringWithFormat:@"ios%@_%@",[UIDevice currentDevice].systemVersion,SMARTUIDE_VERSION];
    
    _notification=[[OperationNotifications alloc] initNotificationsWithAccessToken:accessToken version:version];
    _notification.delegate=self;
    
    [_notification start];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    OperationNotifications *ope=(OperationNotifications*)operation;
    
    NotificationObject *notiObj=ope.object;
    
    [self processNotification:notiObj];
    
    _notification=nil;
}

-(void)operationURLFailed:(OperationURL *)operation
{
    [self.view showLoading];
    [self requestUserProfile];
    
    _notification=nil;
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserProfile class]])
    {
        [self.view removeLoading];
        [self.delegate SGLoadingFinished:self];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserProfile class]])
    {
        [self.view removeLoading];
        [self.delegate SGLoadingFinished:self];
    }
}

-(void) requestUserProfile
{
    _operationUserProfile=[[ASIOperationUserProfile alloc] initOperation];
    _operationUserProfile.delegatePost=self;
    
    [_operationUserProfile startAsynchronous];
}

-(void) processNotification:(NotificationObject*) notiObj
{
    if(notiObj.notificationType==1)
    {
        [AlertView showWithTitle:nil withMessage:notiObj.content withLeftTitle:localizeCancel() withRightTitle:localizeOK() onOK:^{
            exit(0);
        } onCancel:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:notiObj.link]];
            
            double delayInSeconds = 0.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                exit(0);
            });
        }];
    }
    else if(notiObj.notificationType==2)
    {
        NSString *msg=@"";
        
        for(NotificationItem *item in notiObj.notificationList)
        {
            if(msg.length==0)
                msg=item.content;
            else
                msg=[NSString stringWithFormat:@"%@\n%@",msg,item.content];
        }
        
        [self requestUserProfile];
        
        if([msg stringByRemoveString:@" ",@"\n",nil].length>0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:msg onOK:nil];
        }
    }
    else if(notiObj.notificationType==3)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:notiObj.content onOK:^{
            exit(0);
        }];
    }
    else
    {
        [self.view showLoading];
        [self requestUserProfile];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
