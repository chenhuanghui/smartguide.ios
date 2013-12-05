//
//  SUShopGalleryCell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUShopGalleryCell.h"
#import "ShopGalleryCell.h"
#import "Utility.h"

@implementation SUShopGalleryCell
@synthesize delegate;

+(NSString *)reuseIdentifier
{
    return @"SUShopGalleryCell";
}

+(float)height
{
    return 227;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==table)
    {
        [pageControl scrollViewDidScroll:scrollView isHorizontal:true];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    pageControl.numberOfPages=10;
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.l_v_w;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopGalleryCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopGalleryCell reuseIdentifier]];
    
    [cell setLbl:[NSString stringWithFormat:@"%02i",indexPath.row+1]];
    
    return cell;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    pageControl.dotColorCurrentPage=[UIColor whiteColor];
    pageControl.dotColorOtherPage=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    table.frame=rect;
    
    [table registerNib:[UINib nibWithNibName:[ShopGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopGalleryCell reuseIdentifier]];
}

-(IBAction) btnInfoTouchUpInside:(id)sender
{
    [self.delegate suShopGalleryTouchedMoreInfo:self];
}

@end
