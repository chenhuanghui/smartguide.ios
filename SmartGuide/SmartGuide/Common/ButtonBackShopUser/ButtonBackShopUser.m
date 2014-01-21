//
//  ButtonBackShopUser.m
//  SmartGuide
//
//  Created by MacMini on 21/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ButtonBackShopUser.h"
#import "Utility.h"

@implementation ButtonBackShopUser

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imageView.animationDuration=0.4f;
    self.imageView.animationRepeatCount=1;
    
    [self setDefaultImage:[UIImage imageNamed:@"button_back_10.png"] highlightImage:[UIImage imageNamed:@"button_back_10.png"]];
}

-(void)startShowAnimateOnCompleted:(void (^)(UIButton *))completed
{
    [self.imageView stopAnimating];
    
    [self setDefaultImage:[UIImage imageNamed:@"button_back_00.png"] highlightImage:[UIImage imageNamed:@"button_back_00.png"]];
    
    NSMutableArray *array=[NSMutableArray array];
    
    for(int i=10;i>=0;i--)
    {
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"button_back_%02i.png",i]]];
    }
    
    [self.imageView setAnimationImages:array];
    
    [self.imageView startAnimating];
    
    if(completed)
    {
        double delayInSeconds = self.imageView.animationDuration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            completed(self);
            
        });
    }
}

-(void)startHideAnimateOnCompleted:(void (^)(UIButton *))completed
{
    [self.imageView stopAnimating];
    
    [self setDefaultImage:[UIImage imageNamed:@"button_back_10.png"] highlightImage:[UIImage imageNamed:@"button_back_10.png"]];
    
    NSMutableArray *array=[NSMutableArray array];
    
    for(int i=0;i<=10;i++)
    {
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"button_back_%02i.png",i]]];
    }
    
    [self.imageView setAnimationImages:array];
    
    [self.imageView startAnimating];
    
    if(completed)
    {
        double delayInSeconds = self.imageView.animationDuration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            completed(self);
            
        });
    }
}

@end
