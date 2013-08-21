//
//  CatalogueListCell.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "CatalogueListCell.h"
#import "Shop.h"
#import "Utility.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "PromotionDetail.h"
#import "PromotionRequire.h"
#import "Group.h"

@interface CatalogueListCell()

@property (nonatomic, assign) Shop *shop;

@end

@implementation CatalogueListCell
@synthesize shop;

+(NSString *)reuseIdentifier
{
    return @"CatalogueListCell";
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self=[super awakeAfterUsingCoder:aDecoder];
    
    return self;
}

-(void)refreshData
{
    bg.highlighted=self.shop.selected;
}

-(void)setData:(Shop *)data
{
    groupType.image=[Group groupWithIDGroup:data.idGroup.integerValue].iconPin;
    
    self.shop=data;
    bg.highlighted=data.selected;
    
    imgvLogo.image=nil;
    [imgvLogo setImageWithURL:[NSURL URLWithString:data.logo]];
    
    lblShopName.text=[data.name uppercaseString];
    lblContent.text=data.desc;
    
    lblKM.text=[NSString stringWithFormat:@"%0.2fKM",data.distance.doubleValue];
    
    imgVND.highlighted=true;
    CGRect rect=CGRectZero;
    rect.origin=CGPointMake(32, 54);
    rect.size=CGSizeMake(21, 7);
    imgVND.frame=rect;
    
    if(data.promotionStatus.boolValue)
    {
        imgVND.hidden=false;
        lblScore.hidden=false;
        
        NSString *score=@"";
        NSString *rank=@"";
        if(data.promotionDetail.promotionType.integerValue==1)
        {
            score=[NSString stringWithFormat:@"%02d",data.score];
            rank=[NSString stringWithFormat:@"/%02d",data.minRank];
            [lblScore setText:[Utility ftCoreTextFormatScore:score rank:rank]];
            
            imgVND.hidden=false;
        }
        else
        {
            imgVND.highlighted=false;
            rect.origin=CGPointMake(25, 52);
            rect.size=CGSizeMake(32, 11);
            imgVND.frame=rect;
            
            score=[NSString stringWithFormat:@"%lldK",data.promotionDetail.money.longLongValue/1000];
            rank=@"";
            [lblScore setText:[Utility ftCoreTextFormatScore:score rank:rank]];
        }
    }
    else
    {
        lblScore.hidden=true;
        imgVND.hidden=true;
    }
    
    [lblScore addStyles:[Utility ftCoreTextFormatScoreListStyle]];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    imgvLogo.layer.cornerRadius=6;
    imgvLogo.layer.masksToBounds=true;
    
    [super willMoveToSuperview:newSuperview];
}

+(float)height
{
    return 68;
}

@end
