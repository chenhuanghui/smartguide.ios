//
//  SGLoadingScreenViewController.m
//  SmartGuide
//
//  Created by MacMini on 31/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LoadingScreenViewController.h"
#import "TokenManager.h"

@interface LoadingScreenViewController ()

@end

@implementation LoadingScreenViewController
@synthesize delegate;

- (id)init
{
    self=[super initWithNibName:@"LoadingScreenViewController" bundle:nil];
    
    return self;
}

-(void)loadView
{
    [super loadView];
    
    NSString *accessToken=[TokenManager shareInstance].accessToken;
    NSString *version=[NSString stringWithFormat:@"ios%@_%@",[UIDevice currentDevice].systemVersion,SMARTUIDE_VERSION];
    
    _notification=[[OperationNotifications alloc] initNotificationsWithAccessToken:accessToken version:version];
    _notification.delegate=self;
    
    [_notification start];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [imgv l_v_setY:-UIStatusBarHeight()];
    [imgv l_v_setS:UIScreenSize()];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
#if BUILD_SOSMART
    
    if([UIScreen mainScreen].bounds.size.height==568.f)
        imgv.image=[UIImage imageNamed:@"bg_5sosmart.png"];
    else
        imgv.image=[UIImage imageNamed:@"bg_sosmart.png"];
#else
    if([UIScreen mainScreen].bounds.size.height==568.f)
        imgv.image=[UIImage imageNamed:@"lauchR4.png"];
    else
        imgv.image=[UIImage imageNamed:@"lauch.png"];
#endif
    
    _viewDidLoad=true;
    
    [self finishRequestNotification];
}

-(void) finishRequestNotification
{
    if(_viewDidLoad && _finishedRequestNotification)
    {
        if(_notifiObject)
        {
            [self processNotification:_notifiObject];
        }
        else
        {
            [self.view showLoading];
            [self requestUserProfile];
        }
    }
}

-(void)operationURLFinished:(OperationURL *)operation
{
    _finishedRequestNotification=true;
    OperationNotifications *ope=(OperationNotifications*)operation;
    
    _notifiObject=ope.object;
    
    [self finishRequestNotification];
    
    _notification=nil;
}

-(void)operationURLFailed:(OperationURL *)operation
{
    _finishedRequestNotification=true;
    [self finishRequestNotification];
    
    _notification=nil;
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserProfile class]])
    {
        [self.view removeLoading];
        [self.delegate SGLoadingFinished:self];
        
        _operationUserProfile=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserProfile class]])
    {
        double delayInSeconds = 3.0;
        
        if(operation.error.code==REFRESH_TOKEN_ERROR_CODE)
        {
            [[TokenManager shareInstance] useDefaultToken];
            delayInSeconds=0;
        }
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self requestUserProfile];
        });
    }
}

-(void) requestUserProfile
{
    _operationUserProfile=[[ASIOperationUserProfile alloc] initOperation];
    _operationUserProfile.delegate=self;
    
    [_operationUserProfile addToQueue];
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
