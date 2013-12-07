//
//  SGUserViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGUserViewController.h"

@interface SGUserViewController ()

@end

@implementation SGUserViewController

- (id)init
{
    self = [super initWithNibName:@"SGUserViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addChildViewController:midNavigation];
    [midView addSubview:midNavigation.view];
    [midNavigation.view l_v_setS:midView.l_v_s];
    
    UserNewFeedViewController *vc=[UserNewFeedViewController new];
    
    [self midNavigationPushViewController:vc];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    
    [topView addGestureRecognizer:tap];
}

-(void) tapGes:(UITapGestureRecognizer*) tap
{
    NSMutableArray *titles=[@[@"New Feed",@"Infomation",@"History",@"Collection",@"Đóng"] mutableCopy];
    
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    [titles removeObject:midNavigation.visibleViewController.title];
    
    for(NSString *str in titles)
        [sheet addButtonWithTitle:str];
    
    [sheet setCancelButtonIndex:titles.count-1];
    
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==actionSheet.cancelButtonIndex)
        return;
    
    NSString *buttonTitle=[actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([buttonTitle isEqualToString:midNavigation.visibleViewController.title])
        return;
    
    if([buttonTitle isEqualToString:@"New Feed"])
    {
        UserNewFeedViewController *vc=[UserNewFeedViewController new];
        [self midNavigationPushViewController:vc];
    }
    else if([buttonTitle isEqualToString:@"Infomation"])
    {
        UserInfomationViewController *vc=[UserInfomationViewController new];
        [self midNavigationPushViewController:vc];
    }
    else if ([buttonTitle isEqualToString:@"History"])
    {
        UserHistoryViewController *vc=[UserHistoryViewController new];
        [self midNavigationPushViewController:vc];
    }
    else if([buttonTitle isEqualToString:@"Collection"])
    {
        UserCollectionViewController *vc=[UserCollectionViewController new];
        [self midNavigationPushViewController:vc];
    }
}

-(void) midNavigationPushViewController:(SGViewController*) vc
{
    [midNavigation setRootViewController:vc animate:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
