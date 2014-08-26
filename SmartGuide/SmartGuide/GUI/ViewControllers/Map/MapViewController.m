//
//  MapViewController.m
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *img=[[UIImage imageNamed:@"bg_notify.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 0, 5)];
    
    [_btnLocation setBackgroundImage:img forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLocationTouchUpInside:(id)sender {
}

- (IBAction)btnTabTouchUpInside:(id)sender {
}

- (IBAction)btnBackTouchUpInside:(id)sender {
}

- (IBAction)btnExpandTouchUpInside:(id)sender {
}

- (IBAction)btnUserCityTouchUpInside:(id)sender {
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MIN([self.dataSource numberOfObjectMapController:self],1);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource numberOfObjectMapController:self];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeZero;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
