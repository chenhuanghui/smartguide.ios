//
//  LoadingMoreCell.m
//  SmartGuide
//
//  Created by MacMini on 21/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "LoadingMoreCell.h"
#import "PhuongConfig.h"
#import "ImageManager.h"

@implementation LoadingMoreCell

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
        [imgv startAnimating];
    else
        [imgv stopAnimating];
}

-(void)showLoading
{
    [imgv startAnimating];
}

+(NSString *)reuseIdentifier
{
    return @"LoadingMoreCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    imgv.animationDuration=DURATION_LOADING;
    imgv.animationImages=[ImageManager sharedInstance].loadingImages;
    imgv.animationRepeatCount=0;
}

@end

@implementation UITableView(LoadingMore)

-(void)registerLoadingMoreCell
{
    [self registerNib:[UINib nibWithNibName:[LoadingMoreCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[LoadingMoreCell reuseIdentifier]];
}

-(LoadingMoreCell *)loadingMoreCell
{
    LoadingMoreCell *cell=[self dequeueReusableCellWithIdentifier:[LoadingMoreCell reuseIdentifier]];
    
    [cell showLoading];
    
    return cell;
}

@end