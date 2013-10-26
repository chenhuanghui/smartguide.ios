//
//  SGUserColllectionController.m
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGUserCollectionController.h"

@interface SGUserCollectionController ()

@end

@implementation SGUserCollectionController
@synthesize userCollection;

-(id)init
{
    SGUserCollectionViewController *vc=[[SGUserCollectionViewController alloc] init];
    self=[super initWithRootViewController:vc];
    
    vc=userCollection;
    
    return self;
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
    userCollection=nil;
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
