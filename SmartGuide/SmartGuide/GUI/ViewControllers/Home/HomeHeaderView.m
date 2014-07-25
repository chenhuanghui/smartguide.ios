//
//  HomeHeaderView.m
//  Infory
//
//  Created by XXX on 7/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

+(float)height
{
    return 95;
}

-(void)setFrame1:(CGRect)frame
{
    
    if(_section==0)
    {
        NSLog(@"frame %@ origin %@ diffY %f",NSStringFromCGRect(frame), NSStringFromCGRect(_originalFrame),frame.origin.y-_originalFrame.origin.y);
    }
    
    float diffY=frame.origin.y-_originalFrame.origin.y;
    float dis=95.f-38;
    
    if(diffY>dis)
    {
        diffY=dis;
//        imgv.transform=CGAffineTransformMakeScale(0, 0);
    }
    else
    {
//        float scale=1.f-(diffY/dis);
//        imgv.layer.transform=CATransform3DMakeScale(scale, scale, -1);
//        
//        if(scale<1)
//            imgv.center=CGPointMake(imgv.center.x, 69.f/2);
//        else
//            imgv.center=CGPointMake(imgv.center.x, 69.f/2);
////        imgv.transform=CGAffineTransformMakeScale(scale, scale);
//        
//        NSLog(@"scale %f %f %f %f %f %f",scale,imgv.frame.origin.x,imgv.frame.origin.y,imgv.frame.size.height,imgv.center.x,imgv.center.y);
    }
    
    frame.origin.y-=diffY;
    
    [super setFrame:frame];
}

@end
