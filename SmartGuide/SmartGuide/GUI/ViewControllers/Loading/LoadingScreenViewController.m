//
//  SGLoadingScreenViewController.m
//  SmartGuide
//
//  Created by MacMini on 31/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LoadingScreenViewController.h"
#import "TokenManager.h"
#import "OperationNotifications.h"
#import "ASIOperationUserProfile.h"

@interface LoadingScreenViewController ()<ASIOperationPostDelegate>
{
    OperationNotifications *_notification;
    ASIOperationUserProfile *_operationUserProfile;
    
    NotificationObject *_notifiObject;
    bool _viewDidLoad;
    bool _finishedEmergencyNotification;
    bool _finishedUserProfile;
}

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
    
    _viewDidLoad=false;
    _finishedEmergencyNotification=false;
    _finishedUserProfile=false;

    [self requestEmergencyNotification];
    [self requestUserProfile];
}

-(void) requestEmergencyNotification
{
    NSString *version=[NSString stringWithFormat:@"ios%@_%@",[UIDevice currentDevice].systemVersion,SMARTUIDE_VERSION];
    
    _notification=[[OperationNotifications alloc] initVersion:version];
    _notification.delegate=self;
    
    [_notification addToQueue];
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
    
    if([UIScreen mainScreen].bounds.size.height==568.f)
        imgv.image=[UIImage imageNamed:@"Default-568h.png"];
    else
        imgv.image=[UIImage imageNamed:@"Default.png"];
    
    _viewDidLoad=true;
    
    [self finishLoadingScreen];
}

-(void)viewWillAppearOnce
{
    [self.view showLoading];
}

-(void) finishLoadingScreen
{
    if(_viewDidLoad && _finishedEmergencyNotification && _finishedUserProfile)
    {
        [self.delegate SGLoadingFinished:self];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserProfile class]])
    {
        _finishedUserProfile=true;
        _operationUserProfile=nil;
        
        [self finishLoadingScreen];
    }
    else if([operation isKindOfClass:[OperationNotifications class]])
    {
        OperationNotifications *ope=(OperationNotifications*)operation;
        
        _notifiObject=ope.object;
        
        [self processNotification:_notifiObject];
        _notification=nil;
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
        
        _operationUserProfile=nil;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self requestUserProfile];
        });
    }
    else if([operation isKindOfClass:[OperationNotifications class]])
    {
        _finishedEmergencyNotification=true;
        _notification=nil;
        
        [self finishLoadingScreen];
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

        if([msg stringByRemoveString:@" ",@"\n",nil].length>0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:msg onOK:^{
                _finishedEmergencyNotification=true;
                [self finishLoadingScreen];
            }];
        }
        else
        {
            _finishedEmergencyNotification=true;
            [self finishLoadingScreen];
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
        _finishedEmergencyNotification=true;
        [self finishLoadingScreen];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
