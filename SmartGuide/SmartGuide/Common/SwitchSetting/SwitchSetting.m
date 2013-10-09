//
//  SwitchSetting.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SwitchSetting.h"

@implementation SwitchSetting
@synthesize ON,delegate;

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self=[super awakeAfterUsingCoder:aDecoder];
    
    if(self.subviews.count==0)
    {
        CGRect rect=self.frame;
        self=[[[NSBundle mainBundle] loadNibNamed:@"SwitchSetting" owner:nil options:nil] objectAtIndex:0];
        self.frame=rect;
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    frame.origin=CGPointZero;
    frame.size.width=frame.size.width*2/3;
    btn.frame=frame;
}

-(void)setON:(bool)_ON
{
    if(_ON==ON)
        return;
    
    ON=_ON;
    
    CGRect rect=btn.frame;
    if(ON)
        rect.origin.x=0;
    else
        rect.origin.x=self.frame.size.width/3;
    
    [UIView animateWithDuration:0.2f animations:^{
        btn.frame=rect;
        if(ON)
           [btn setTitle:@"ON" forState:UIControlStateNormal];
        else
            [btn setTitle:@"OFF" forState:UIControlStateNormal];
    }];
    
    if(delegate)
        [delegate switchChanged:self];
}

- (IBAction)btnTouchUpInside:(id)sender {
    [self setON:!self.ON];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self btnTouchUpInside:btn];
}

@end
