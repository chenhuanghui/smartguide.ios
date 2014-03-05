//
//  LoadingMoreCell.m
//  SmartGuide
//
//  Created by MacMini on 21/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "LoadingMoreCellHori.h"
#import "PhuongConfig.h"
#import "ImageManager.h"
#import "Utility.h"

@implementation LoadingMoreCellHori

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
    return @"LoadingMoreCellHori";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    self.frame=rect;
    
    imgv.animationDuration=DURATION_LOADING;
    imgv.animationImages=[ImageManager sharedInstance].loadingImages;
    imgv.animationRepeatCount=0;
}

@end

@implementation UITableView(LoadingMore)

-(LoadingMoreCellHori *)loadingMoreCellHori
{
    LoadingMoreCellHori *cell=[self dequeueReusableCellWithIdentifier:[LoadingMoreCellHori reuseIdentifier]];
    
    [cell showLoading];
    
    return cell;
}

-(void)registerLoadingMoreCellHori
{
    [self registerNib:[UINib nibWithNibName:[LoadingMoreCellHori reuseIdentifier] bundle:nil] forCellReuseIdentifier:[LoadingMoreCellHori reuseIdentifier]];
}

@end