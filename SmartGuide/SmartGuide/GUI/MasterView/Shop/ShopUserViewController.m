//
//  ShopUserViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserViewController.h"
#import "GUIManager.h"

@interface ShopUserViewController ()

@end

@implementation ShopUserViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"ShopUserViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //retain shopNavi
    [detailView addSubview:shopNavi.view];
    detailView.receiveView=scrollShopUser;
    
    CGRect rect=CGRectZero;
    rect.origin=CGPointMake(27, 0);
    rect.size=CGSizeMake(266, 393);
    shopNavi.view.frame=rect;
    
    shopNavi.view.layer.masksToBounds=true;
    shopNavi.view.layer.cornerRadius=8;
    
    scrollShopUser.contentSize=contentScroll.frame.size;
}

-(void)setShop:(Shop *)shop
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

@implementation ScrollShopUser



@end