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
#import "Constant.h"

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
    [imgvLogo setSmartGuideImageWithURL:[NSURL URLWithString:data.logo] placeHolderImage:UIIMAGE_LOADING_SHOP_LOGO success:nil failure:nil];
    
    lblShopName.text=[data.name uppercaseString];
    lblContent.text=data.desc;
    
    if(data.distance.doubleValue==-1)
    {
        lblKM.textAlignment=UITextAlignmentCenter;
        lblKM.text=@"...km";
    }
    else
    {
        lblKM.textAlignment=UITextAlignmentRight;
        lblKM.text=[NSString stringWithFormat:@"%0.2fKM",data.distance.doubleValue];
    }
    
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
            rank=[NSString stringWithFormat:@"/%02d",data.promotionDetail.min_score.integerValue];
            [lblScore setText:[Utility ftCoreTextFormatScore:score rank:rank]];
            
            imgVND.hidden=false;
            
            FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"score"];
            style.font=[UIFont boldSystemFontOfSize:14];
            style.color=[UIColor whiteColor];
            style.textAlignment=FTCoreTextAlignementCenter;
            
            [lblScore addStyle:style];
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
            
            FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"score"];
            style.font=[UIFont boldSystemFontOfSize:13];
            style.color=[UIColor whiteColor];
            style.textAlignment=FTCoreTextAlignementCenter;
        }
    }
    else
    {
        lblScore.hidden=true;
        imgVND.hidden=true;
    }
    

    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"a"];
    style.name=@"a";
    style.font=[UIFont boldSystemFontOfSize:10];
    style.color=COLOR_BACKGROUND_APP;

    [lblScore addStyle:style];
}

+(float)height
{
    return 68;
}

@end
