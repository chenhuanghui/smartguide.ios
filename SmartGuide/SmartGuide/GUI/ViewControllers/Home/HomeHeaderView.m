//
//  HomeHeaderView.m
//  Infory
//
//  Created by XXX on 7/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HomeHeaderView.h"
#import "Utility.h"
#import "UserHomeSection.h"
#import "UserHome.h"
#import "ImageManager.h"

@implementation HomeHeaderView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

-(void)loadWithHomeSection:(UserHomeSection *)homeSection
{
    lblTitle.text=homeSection.home9.title;
}

+(float)height
{
    return 56;
}

-(void)setFrame:(CGRect)frame
{
    if(self.table)
    {
        CGRect rect=[self.table rectForSection:self.section];
        float offsetY=self.table.contentOffset.y+self.table.contentInset.top;
        float diff=offsetY-rect.origin.y;
        
        float centerY=imgvBlur.frame.size.height/2;
        
        if(diff>0)
        {
            if(diff<self.alignY)
                frame.origin.y=rect.origin.y;
            else
            {
                frame.origin.y-=self.alignY;
                
                centerY=imgvBlur.frame.size.height/2-(frame.origin.y-rect.origin.y);
                
                if(centerY<0)
                    centerY=0;
                
                diff=offsetY+self.alignY-rect.origin.y-rect.size.height;
                diff+=3;
                
                if(diff>0)
                    frame.origin.y+=diff;
                
                if(frame.origin.y>rect.origin.y+rect.size.height-[HomeHeaderView height])
                    frame.origin.y=rect.origin.y+rect.size.height-[HomeHeaderView height];
            }
        }
        
        imgvBlur.center=CGPointMake(imgvBlur.center.x, centerY);
    }
    
    [super setFrame:frame];
}

@end
