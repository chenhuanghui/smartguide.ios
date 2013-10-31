//
//  SGMapViewController.m
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGMapViewController.h"

@interface SGMapViewController ()

@end

@implementation SGMapViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"SGMapViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ray.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ray_blue.png"]];
    borderMap.layer.cornerRadius=4;
    containMap.layer.cornerRadius=4;
    mapShops.layer.cornerRadius=4;

    [self removeMap];
}

-(void)addMap
{
    if(mapShops.superview)
        return;
    
    [containMap addSubview:mapShops];
    [mapShops setShowsUserLocation:true];
}

-(void)removeMap
{
    [mapShops setShowsUserLocation:false];
    [mapShops removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

- (IBAction)btn:(id)sender {
    [self.delegate SGMapViewSelectedShop];
}

@end
