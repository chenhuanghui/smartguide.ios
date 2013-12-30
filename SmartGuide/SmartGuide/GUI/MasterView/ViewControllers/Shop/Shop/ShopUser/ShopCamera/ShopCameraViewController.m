//
//  ShopCameraViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopCameraViewController.h"

@interface ShopCameraViewController ()

@end

@implementation ShopCameraViewController

- (id)init
{
    self = [super initWithNibName:@"ShopCameraViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ShopCameraTakeViewController *take=[ShopCameraTakeViewController new];
    take.delegate=self;
    
    SGNavigationController *navi=[[SGNavigationController alloc] initWithRootViewController:take];
    
    cameraNavi=navi;
    
    [self addChildViewController:navi];
    [self.view addSubview:navi.view];
    [navi.view l_v_setS:self.view.l_v_s];
}

-(void)shopCameraTakeDidCapture:(ShopCameraTakeViewController *)controller image:(UIImage *)image
{
    ShopCameraPostViewController *vc=[[ShopCameraPostViewController alloc] initWithImage:image];
    vc.delegate=self;
    
    [cameraNavi pushViewController:vc animated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
