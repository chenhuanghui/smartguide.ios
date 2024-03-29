//
//  IntroView.m
//  SmartGuide
//
//  Created by XXX on 8/28/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "IntroView.h"
#import "Utility.h"
#import "IntroCell.h"

@implementation IntroView
@synthesize delegate;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"IntroView") owner:nil options:nil] objectAtIndex:0];
    
    table.pagingEnabled=true;
    table.bounces=false;
    
    CGRect rect=CGRectZero;
    
    //if(NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1)
    {
        rect=self.frame;
        rect.origin.y=20;
        self.frame=rect;
        
        page.center=CGPointMake(page.center.x, page.center.y-20);
    }
    
    rect=table.frame;
    
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*6));
    table.frame=rect;
    
    table.dataSource=self;
    table.delegate=self;
    
    [table registerNib:[UINib nibWithNibName:[IntroCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[IntroCell reuseIdentifier]];
    
    page.numberOfPages=[self source].count;
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self source].count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntroCell *cell = [tableView dequeueReusableCellWithIdentifier:[IntroCell reuseIdentifier]];

    
    [cell setImageIntro:[UIImage imageNamed:[[self source] objectAtIndex:indexPath.row]]];
    
    return cell;
}

-(NSArray*) source
{
    return @[@"intro_1.jpg",@"intro_2.jpg",@"intro_3.jpg",@"intro_4.jpg",@"intro_5.jpg",@"intro_6.jpg"];
}

- (IBAction)btnTouchUpInside:(id)sender {
    self.userInteractionEnabled=false;
    [delegate introViewClose:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    page.currentPage=[scrollView currentPageForHoriTable];
}

@end
