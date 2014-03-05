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
    
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    table.frame=rect;
    [table registerNib:[UINib nibWithNibName:[GalleryFullCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[GalleryFullCell reuseIdentifier]];
    
    if(_parentController)
    {
        self.view.alpha=0;
        [self.view makeAlphaViewAtIndex:0];
        self.view.alphaView.backgroundColor=[UIColor blackColor];
        self.view.alphaView.alpha=0;

        [self.view l_v_setS:_parentController.view.l_v_s];
        [self.view.alphaView l_v_setS:self.view.l_v_s];
        [_parentController.view addSubview:self.view];
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            self.view.alpha=1;
            self.view.alphaView.alpha=0.9f;
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for(GalleryFullCell *cell in table.visibleCells)
        [cell tableDidScroll];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryFullCell*cell=(GalleryFullCell*)[tableView dequeueReusableCellWithIdentifier:[GalleryFullCell reuseIdentifier]];
    
    cell.table=tableView;
    cell.indexPath=indexPath;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.l_v_w;
}

-(id)selectedObject
{
    NSIndexPath *indexPath=[table indexPathForRowAtPoint:CGPointMake(table.l_co_x+table.l_v_w/2,table.l_v_h/2)];
    
    if(indexPath)
    {
        return [self galleryItemAtIndex:indexPath.row];
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