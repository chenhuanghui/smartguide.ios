//
//  ShopCategoriesViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedViewController.h"
#import "GUIManager.h"

@interface NewFeedViewController ()

@end

@implementation NewFeedViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"NewFeedViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    txt.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txt.l_v_h)];
    txt.leftView.backgroundColor=[UIColor clearColor];
    txt.leftViewMode=UITextFieldViewModeAlways;
    
    _page=-1;
    _homes=[NSMutableArray array];
    _isLoadingMore=false;
    _canLoadMore=true;
    
    [self requestNewFeed];
    displayLoadingView.userInteractionEnabled=true;
    [displayLoadingView showLoading];
}

-(void) requestNewFeed
{
    if(_operationUserHome)
    {
        [_operationUserHome cancel];
        _operationUserHome=nil;
    }
    
    _operationUserHome=[[ASIOperationUserHome alloc] initWithPage:_page+1 userLat:userLat() userLng:userLng()];
    _operationUserHome.delegatePost=self;
    
    [_operationUserHome startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserHome class]])
    {
        if(displayLoadingView)
        {
            [displayLoadingView removeLoading];
            [displayLoadingView removeFromSuperview];
        }
        
        ASIOperationUserHome *ope=(ASIOperationUserHome*) operation;
        
        [_homes addObjectsFromArray:ope.homes];
        _canLoadMore=ope.homes.count==5;
        _isLoadingMore=false;
        _page++;
        
        [table reloadData];
        
        _operationUserHome=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserHome class]])
    {
        if(displayLoadingView)
        {
            [displayLoadingView removeLoading];
            [displayLoadingView removeFromSuperview];
        }
        
        _operationUserHome=nil;
    }
}

-(NSArray *)registerNotifications
{
    return @[UIApplicationDidBecomeActiveNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationDidBecomeActiveNotification])
    {
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.delegate newFeedControllerTouchedTextField:self];
    
    return false;
}

-(IBAction) btnNavigationTouchedUpInside:(id)sender
{
    [self.delegate newFeedControllerTouchedNavigation:self];
}

@end
