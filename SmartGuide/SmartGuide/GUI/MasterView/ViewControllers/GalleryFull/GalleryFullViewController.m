//
//  GalleryFullViewController.m
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryFullViewController.h"
#import "SGGridViewLayoutStrategies.h"

@interface GalleryFullViewController ()

@end

@implementation GalleryFullViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"GalleryFullViewController" bundle:nil];
    if (self) {
    }
    return self;
}

-(GalleryFullViewController *)initWithParentController:(SGViewController *)parentControlelr
{
    self=[[[GalleryFullViewController class] alloc] init];
    
    [parentControlelr addChildViewController:self];
    _parentController=parentControlelr;
    
    return self;
}

-(void)setParentController:(SGViewController *)parentController
{
    [self removeFromParentViewController];
    _parentController=parentController;
    [_parentController addChildViewController:self];
    
    [self view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    grid.minEdgeInsets=UIEdgeInsetsZero;
    grid.itemSpacing=0;
    grid.centerGrid=false;
    grid.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:SGGridViewLayoutHorizontalPagedLTRImage];
    
    [self gridViewStrategy].numberOfNext=1;

    if(_parentController)
    {
        self.view.alpha=0;
        [self.view makeAlphaViewAtIndex:0];
        self.view.alphaView.backgroundColor=[UIColor blackColor];
        self.view.alphaView.alpha=0;

        grid.dataSource=self;
        
        [_parentController.view addSubview:self.view];
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            self.view.alpha=1;
            self.view.alphaView.alpha=0.9f;
        }];
    }
    else
        grid.dataSource=self;
}

-(SGGridViewLayoutHorizontalPagedLTRStrategyImage*) gridViewStrategy
{
    return grid.layoutStrategy;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return 0;
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GalleryFullGridCell *gCell=(GalleryFullGridCell*) [gridView dequeueReusableCell];
    
    if(!gCell)
    {
        gCell=[GalleryFullGridCell new];
        
        [gCell.imageView l_v_setS:gridView.l_v_s];
    }
    
    return gCell;
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return gridView.l_v_s;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position atTouchLocation:(CGPoint)touchLocation
{
    
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    
}

-(id)selectedObject
{
    int index=[[self gridViewStrategy] itemPositionFromLocation:CGPointMake(grid.l_co_x+grid.l_v_w/2, grid.l_v_h/2)];
    
    if(index>=0 && index<[self numberOfItemsInGMGridView:grid])
    {
        return [self galleryItemAtIndex:index];
    }
    
    return nil;
}

-(id)galleryItemAtIndex:(int)index
{
    return nil;
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    
    if(_parentController)
    {
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            self.view.alphaView.alpha=0;
            self.view.alpha=0;
        } completion:^(BOOL finished) {
            [self.delegate galleryFullTouchedBack:self];
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];
    }
    else
        [self.delegate galleryFullTouchedBack:self];
}

@end

@implementation GalleryFullGridCell

- (id)init
{
    self = [super init];
    if (self) {
        [self loadingView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    [self loadImageView];
    
    return self;
}

-(void)loadImageView
{
    if(!imageView)
    {
        UIImageView *imgv=[UIImageView new];
        imgv.contentMode=UIViewContentModeScaleAspectFit;
        
        self.contentView=imgv;
        
        imageView=imgv;
    }
}

-(UIImageView *)imageView
{
    return (UIImageView*) self.contentView;
}

@end