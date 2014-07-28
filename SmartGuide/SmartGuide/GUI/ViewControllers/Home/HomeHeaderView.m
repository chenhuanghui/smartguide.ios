//
//  HomeHeaderView.m
//  Infory
//
//  Created by XXX on 7/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HomeHeaderView.h"
#import "Utility.h"
#import <QuartzCore/QuartzCore.h>

@implementation HomeHeaderView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    imgv.layer.cornerRadius=34.f;
    imgv.layer.masksToBounds=true;
    
    [imgvShadow effectCornerRadius:34.f shadow:1.f];
    imgvShadow.layer.shadowOpacity=0.5f;
    //    imgvShadow.layer.shadowOffset=CGSizeMake(0, 0.5f);
}

+(float)height
{
    return 95;
}

-(void)setFrame:(CGRect)frame
{
    float headerHeight=[HomeHeaderView height];
    float diffY=frame.origin.y-_originalFrame.origin.y;
    float dis=headerHeight-59.f;
    
    //align với vùng transparent top của bg_title_placelist.png
    dis+=7;
    
    if(diffY>dis)
    {
        imgvShadow.transform=CGAffineTransformMakeScale(0, 0);
        
        if(frame.origin.y==_sectionFrame.origin.y+_sectionFrame.size.height-headerHeight)
        {
            float offsetY=self.table.contentOffset.y-frame.origin.y;
            frame.origin.y+=MIN(dis, offsetY);
        }

        frame.origin.y-=dis;
    }
    else
    {
        float scale=1.f-(diffY/dis);
        imgvShadow.layer.transform=CATransform3DMakeScale(scale, scale, -1);
        
        if(scale<1)
            imgvShadow.center=CGPointMake(imgvShadow.center.x, 34.f+((1.f-scale)*34.f)/2);
        
        frame.origin.y-=diffY;
    }
    
    [super setFrame:frame];
}

@end
