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
@synthesize delegate;

-(ShopCameraViewController *)initWithShop:(Shop *)shop
{
    self = [super initWithNibName:@"ShopCameraViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _shop=shop;
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
    if(_currentUpload)
    {
        [[UserUploadGalleryManager shareInstance] cancelUpload:_currentUpload];
        _currentUpload=nil;
    }
    
    _currentUpload=[[UserUploadGalleryManager shareInstance] addUploadWithIDShop:_shop.idShop.integerValue image:image];
    
    ShopCameraPostViewController *vc=[[ShopCameraPostViewController alloc] initWithShop:_shop image:image];
    vc.delegate=self;
    
    [cameraNavi pushViewController:vc animated:true];
}

-(void)shopCameraControllerTouchedDone:(ShopCameraPostViewController *)controller
{
    [[UserUploadGalleryManager shareInstance] updateDesc:_currentUpload desc:controller.desc];
    _currentUpload=nil;
    
    [self.delegate shopCameraControllerDidUploadPhoto:self];
}

-(void)dealloc
{
    _currentUpload=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(bool)navigationWillBack
{
    if(_currentUpload && _currentUpload.desc.length==0)
    {
        [[UserUploadGalleryManager shareInstance] cancelUpload:_currentUpload];
    }
    
    _currentUpload=nil;
    
    if([cameraNavi.visibleViewController isKindOfClass:[ShopCameraPostViewController class]])
    {
        [cameraNavi popViewControllerAnimated:true];
        return false;
    }
    
    return true;
}

@end
