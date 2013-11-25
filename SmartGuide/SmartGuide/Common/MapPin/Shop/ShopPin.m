//
//  ShopPin.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopPin.h"
#import "Utility.h"
#import "FTCoreTextStyle.h"
#import "PromotionDetail.h"

@implementation ShopPin
@synthesize delegate;

-(ShopPin *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ShopPin" owner:nil options:nil] objectAtIndex:0];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"score"];
    style.font=[UIFont systemFontOfSize:16];
    style.color=[UIColor whiteColor];
    style.textAlignment=FTCoreTextAlignementCenter;
    
    [lblScore addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"a"];
    style.font=[UIFont systemFontOfSize:12];
    style.color=[UIColor color255WithRed:150 green:150 blue:150 alpha:255];
    
    [lblScore addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"money"];
    
    style.font=[UIFont systemFontOfSize:12];
    style.color=[UIColor whiteColor];
    style.textAlignment=FTCoreTextAlignementCenter;
    
    [lblScore addStyle:style];
    
    [self setShop:shop];
    
    return self;
}

- (IBAction)btnDetailTouchUpInside:(id)sender {
    
    if([self isRespondSEL:@selector(shopPin:detailClicked:)])
    {
        [delegate shopPin:self detailClicked:sender];
        return;
    }
}

-(void)setShop:(Shop *)shop
{
    _shop=shop;
    
    if(shop.promotionStatus.boolValue)
    {
        if(shop.promotionDetail.promotionType.integerValue==1)
        {
            NSString *score=@"";
            NSString *rank=@"";
            
            score=[NSString stringWithFormat:@"%02d",shop.score];
            rank=[NSString stringWithFormat:@"/%02d",shop.promotionDetail.min_score.integerValue];
            
            [lblScore setText:[NSString stringWithFormat:@"<score>%@</score><a>%@</a>",score,rank]];
            
            lblPoint.text=@"SGP";
        }
        else
        {
            [lblScore setText:[NSString stringWithFormat:@"<money>%@</money>",[NSString stringWithFormat:@"%lldK",shop.promotionDetail.money.longLongValue/1000]]];
            
            lblPoint.text=@"VNĐ";
        }
        lblScore.hidden=false;
    }
    else
    {
        lblPoint.text=@"";
        lblScore.hidden=true;
    }
    
    if(_shop.distance.doubleValue!=-1)
        lblKM.text=[NSString stringWithFormat:@"%0.0fKM",_shop.distance.floatValue];
    else
        lblKM.text=@"...KM";
    
    lblContent.text=_shop.name;
}

-(Shop *)shop
{
    return _shop;
}

-(UIButton *)buttonDetail
{
    return btnDetail;
}

-(bool) isRespondSEL:(SEL) selector
{
    return delegate && [delegate respondsToSelector:selector];
}

@end
