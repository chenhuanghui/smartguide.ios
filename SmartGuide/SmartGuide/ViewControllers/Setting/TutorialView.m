//
//  TutorialView.m
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "TutorialView.h"
#import "Constant.h"
#import "Utility.h"

@implementation TutorialView
@synthesize delegate,isHideClose;

-(id)init
{
    self=[[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"TutorialView") owner:nil options:nil] objectAtIndex:0];
    
    self.backgroundColor=COLOR_BACKGROUND_APP;
    
    _tutorials=[@[@"tutorial1.png",@"tutorial2.png",@"tutorial3.png",@"tutorial4.png",@"tutorial_end.png"] copy];
    pageControl.numberOfPages=_tutorials.count;
    pageControl.delegate=self;
    
    CGRect rect=[UIScreen mainScreen].bounds;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*6));
    table.frame=rect;
    table.dataSource=self;
    table.delegate=self;
    table.pagingEnabled=true;
    
    [table registerNib:[UINib nibWithNibName:[TutorialCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[TutorialCell reuseIdentifier]];
    
//    if(NSFoundationVersionNumber>=NSFoundationVersionNumber_iOS_6_1)
    {
        rect=self.frame;
        rect.origin.y=20;
        self.frame=rect;
    }
    
    return self;
}

-(void)pageControlPageDidChange:(PageControl *)_pageControl
{
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_pageControl.currentPage inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:true];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [pageControl setCurrentPage:scrollView.currentPageForHoriTable];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tutorials.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TutorialCell *cell=[table dequeueReusableCellWithIdentifier:[TutorialCell reuseIdentifier]];
    
    [cell setTutorialImage:[UIImage imageNamed:[_tutorials objectAtIndex:indexPath.row]]];
    
    return cell;
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    
    if(pageControl.currentPage==_tutorials.count-1)
        [Flurry trackUserViewTutorialEnd];
    
    [delegate tutorialViewBack:self];
}

-(void)setIsHideClose:(bool)_isHideClose
{
    isHideClose=_isHideClose;
    
    btnBack.hidden=isHideClose;
}

@end
