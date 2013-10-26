//
//  SGMapController.m
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGMapController.h"

@interface SGMapController ()

@end

@implementation SGMapController
@synthesize mapViewController;

- (id)init
{
    SGMapViewController *map=[[SGMapViewController alloc] init];
    
    self = [super initWithRootViewController:map];
    
    mapViewController=map;
    mapViewController.delegate=self;
    
    if (self) {
        
    }
    return self;
}

-(void)SGMapViewSelectedShop
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    mapViewController=nil;
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
