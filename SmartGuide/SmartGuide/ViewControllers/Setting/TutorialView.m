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
    
    [self goPage:0];
    
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
    return table.frame.size.width;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TutorialCell *cell=[table dequeueReusableCellWithIdentifier:[TutorialCell reuseIdentifier]];
    
    [cell setTutorialImage:[UIImage imageNamed:[_tutorials objectAtIndex:indexPath.row]]];
    
    return cell;
}

-(void) goPage:(int) page
{
//    if(page>=_tutorials.count)
//        return;
//    
//    CGRect rect=CGRectMake(0, -13, 320, 480);
//    
//    if(page==1)
//        rect.origin=CGPointMake(-18, -13);
//    else if(page==2)
//        rect.origin=CGPointMake(-16, -13);
//    else if(page==3)
//        rect.origin=CGPointMake(-16, -13);
//    else if(page==4)
//        rect.origin=CGPointMake(-14, -13);
//    else if(page==5)
//        rect.origin=CGPointMake(-19, -13);
//    else if(page==6)
//        rect.origin=CGPointMake(0, 5);
//    else if(page==7)
//        rect.origin=CGPointMake(0, 5);
//    else if(page==8)
//        rect.origin=CGPointMake(0, 5);
//    else if(page==9)
//        rect.origin=CGPointMake(0, -13);
//    else if(page==10)
//        rect.origin=CGPointMake(0, 6);
//    else if(page==11)
//        rect.origin=CGPointMake(-2, 12);
//    else if(page==12)
//        rect.origin=CGPointMake(1, 6);
//    else if(page==13)
//        rect.origin=CGPointMake(1, 6);
//    else if(page==14)
//        rect.origin=CGPointMake(4, -12);
//    
//    _page=page;
//    
//    [UIView animateWithDuration:0.15f animations:^{
//        imgv.alpha=0;
//    } completion:^(BOOL finished) {
//        imgv.frame=rect;
//        imgv.image=[UIImage imageNamed:[_tutorials objectAtIndex:page]];
//        
//        [UIView animateWithDuration:0.15f animations:^{
//            imgv.alpha=1;
//        } completion:^(BOOL finished) {
//            [self configPage:page];
//        }];
//    }];
//    
//    btnNext.hidden=false;
//    
//    [UIView animateWithDuration:0.3f animations:^{
//        btnNext.alpha=[[self pageAllowNext] containsObject:@(page)]?1:0;
//        
//        if(_page==_tutorials.count-1)
//        {
//            btnFind.alpha=0;
//            btnReward.alpha=0;
//            btnBack.alpha=0;
//        }
//    } completion:^(BOOL finished) {
//        if(btnNext.alpha==0)
//            btnNext.hidden=true;
//        
//        if(_page==_tutorials.count-1)
//        {
//            btnFind.hidden=true;
//            btnReward.hidden=true;
//            btnBack.hidden=true;
//        }
//    }];
}

-(void) configPage:(int) page
{
//    if(btn)
//    {
//        [btn removeFromSuperview];
//        btn=nil;
//    }
//    
//    if(page==0)
//    {
//        btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"" forState:UIControlStateNormal];
//        btn.frame=CGRectMake(204, 100, 63, 64);
//        
//        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self addSubview:btn];
//    }
//    else if(page==3)
//    {
//        btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"" forState:UIControlStateNormal];
//        btn.frame=CGRectMake(54, 162, 215, 50);
//        
//        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self addSubview:btn];
//    }
//    else if(page==7)
//    {
//        btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"" forState:UIControlStateNormal];
//        btn.frame=CGRectMake(60, 352, 217, 68);
//        
//        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self addSubview:btn];
//    }
//    else if(page==9)
//    {
//        btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"" forState:UIControlStateNormal];
//        btn.frame=CGRectMake(56, 297, 203, 44);
//        
//        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self addSubview:btn];
//    }
//    else if(page==12)
//    {
//        btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"" forState:UIControlStateNormal];
//        btn.frame=CGRectMake(78, 191, 66, 44);
//        
//        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self addSubview:btn];
//    }
}

-(void) btnTouchUpInside:(UIButton*) button
{
//    if(_page==0)
//        [self goPage:1];
//    else if(_page==3)
//        [self goPage:4];
//    else if(_page==7)
//        [self goPage:8];
//    else if(_page==9)
//        [self goPage:10];
//    else if(_page==12)
//        [self goPage:13];
}

-(NSArray*) pageAllowNext
{
    return @[@(1),@(2),@(4),@(5),@(6),@(8),@(10),@(11),@(13),@(14)];
}

- (IBAction)btnNextTouchUpInside:(id)sender {
//    [self goPage:_page+1];
}

- (IBAction)btnFindTouchUpInside:(id)sender {
//    [self goPage:0];
}
- (IBAction)btnGetTouchUpInside:(id)sender {
//    [self goPage:6];
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
