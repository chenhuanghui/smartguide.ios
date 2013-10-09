//
//  PointBar.m
//  SmartGuide
//
//  Created by XXX on 7/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PointBar.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"

@implementation PointBar

-(PointBar *)initWithPoint:(PromotionRequire *)point
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"PointBar" owner:nil options:nil] objectAtIndex:0];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"num"];
    style.font=[UIFont boldSystemFontOfSize:12];
    style.color=[UIColor whiteColor];
    style.textAlignment=FTCoreTextAlignementCenter;
    
    [lblPoint addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"pnt"];
    style.font=[UIFont boldSystemFontOfSize:10];
    style.color=[UIColor color255WithRed:0 green:144 blue:56 alpha:255];
    style.textAlignment=FTCoreTextAlignementCenter;
    
    [lblPoint addStyle:style];
    
    bgPoint.layer.cornerRadius=8;
    bgPoint.layer.masksToBounds=true;
    self.layer.cornerRadius=8;
    
    [self setPoint:point];
    
    return self;
}

-(void)setPoint:(PromotionRequire *)point
{
    _shopPoint=point;
    NSString *pointText=[NSString stringWithFormat:@"<num>%02d</num><pnt> POINT</pnt>",(int)point.sgpRequired.doubleValue];
    
    [lblPoint setText:pointText];
    
    lblReward.text=point.content;
}

-(void)setHighlight:(bool)isHighlighed
{
    if(isHighlighed)
    {
        self.backgroundColor=[UIColor color255WithRed:207 green:72 blue:71 alpha:255];
        bgPoint.backgroundColor=[UIColor color255WithRed:187 green:37 blue:62 alpha:255];
    }
    else
    {
        self.backgroundColor=[UIColor color255WithRed:0 green:185 blue:107 alpha:255];
        bgPoint.backgroundColor=[UIColor color255WithRed:0 green:185 blue:63 alpha:255];
    }
}

+(CGSize)size
{
    return CGSizeMake(240, 30);
}

@end