//
//  TutorialView.m
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "TutorialView.h"

@implementation TutorialView
@synthesize delegate;

-(id)init
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"TutorialView" owner:nil options:nil] objectAtIndex:0];
    _tutorials=[@[@"tutorial_1.png",@"tutorial_2.png",@"tutorial_3.png",@"tutorial_4.png",@"tutorial_5.png",@"tutorial_6.png",@"tutorial_7.png",@"tutorial_8.png",@"tutorial_9.png",@"tutorial_10.png",@"tutorial_11.png",@"tutorial_12.png",@"tutorial_13.png",@"tutorial_14.png",@"tutorial_15.png",@"tutorial_end.png"] copy];
    
    btnNext.hidden=true;
    btnNext.alpha=0;
    [self goPage:0];
    
    return self;
}

-(void) goPage:(int) page
{
    if(page>=_tutorials.count)
        return;
    
    CGRect rect=CGRectMake(0, -13, 320, 480);
    
    if(page==1)
        rect.origin=CGPointMake(-18, -13);
    else if(page==2)
        rect.origin=CGPointMake(-16, -13);
    else if(page==3)
        rect.origin=CGPointMake(-16, -13);
    else if(page==4)
        rect.origin=CGPointMake(-14, -13);
    else if(page==5)
        rect.origin=CGPointMake(-19, -13);
    else if(page==6)
        rect.origin=CGPointMake(0, 5);
    else if(page==7)
        rect.origin=CGPointMake(0, 5);
    else if(page==8)
        rect.origin=CGPointMake(0, 5);
    else if(page==9)
        rect.origin=CGPointMake(0, -13);
    else if(page==10)
        rect.origin=CGPointMake(0, 6);
    else if(page==11)
        rect.origin=CGPointMake(-2, 12);
    else if(page==12)
        rect.origin=CGPointMake(1, 6);
    else if(page==13)
        rect.origin=CGPointMake(1, 6);
    else if(page==14)
        rect.origin=CGPointMake(4, -12);
    
    _page=page;
    
    [UIView animateWithDuration:0.15f animations:^{
        imgv.alpha=0;
    } completion:^(BOOL finished) {
        imgv.frame=rect;
        imgv.image=[UIImage imageNamed:[_tutorials objectAtIndex:page]];
        
        [UIView animateWithDuration:0.15f animations:^{
            imgv.alpha=1;
        } completion:^(BOOL finished) {
            [self configPage:page];
        }];
    }];
    
    btnNext.hidden=false;
    
    [UIView animateWithDuration:0.3f animations:^{
        btnNext.alpha=[[self pageAllowNext] containsObject:@(page)]?1:0;
        
        if(_page==_tutorials.count-1)
        {
            btnFind.alpha=0;
            btnReward.alpha=0;
            btnBack.alpha=0;
        }
    } completion:^(BOOL finished) {
        if(btnNext.alpha==0)
            btnNext.hidden=true;
        
        if(_page==_tutorials.count-1)
        {
            btnFind.hidden=true;
            btnReward.hidden=true;
            btnBack.hidden=true;
        }
    }];
}

-(void) configPage:(int) page
{
    if(btn)
    {
        [btn removeFromSuperview];
        btn=nil;
    }
    
    if(page==0)
    {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"" forState:UIControlStateNormal];
        btn.frame=CGRectMake(204, 100, 63, 64);
        
        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
    else if(page==7)
    {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"" forState:UIControlStateNormal];
        btn.frame=CGRectMake(60, 352, 217, 68);
        
        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
    else if(page==12)
    {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"" forState:UIControlStateNormal];
        btn.frame=CGRectMake(78, 191, 66, 15);
        
        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}

-(void) btnTouchUpInside:(UIButton*) button
{
    if(_page==0)
    {
        [self goPage:1];
    }
    else if(_page==7)
    {
        [self goPage:8];
    }
    else if(_page==12)
    {
        [self goPage:13];
    }
}

-(NSArray*) pageAllowNext
{
    return @[@(1),@(2),@(3),@(4),@(5),@(6),@(8),@(9),@(10),@(11),@(13),@(14)];
}

- (IBAction)btnNextTouchUpInside:(id)sender {
    [self goPage:_page+1];
}

- (IBAction)btnFindTouchUpInside:(id)sender {
    [self goPage:0];
}
- (IBAction)btnGetTouchUpInside:(id)sender {
    [self goPage:6];
}
- (IBAction)btnBackTouchUpInside:(id)sender {
    [delegate tutorialViewBack:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_page==_tutorials.count-1)
        [delegate tutorialViewBack:self];
}

@end
