//
//  ScanResultObjectHeaderView.m
//  Infory
//
//  Created by XXX on 7/14/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultObjectHeaderView.h"
#import "ScanCodeRelatedContain.h"

@implementation ScanResultObjectHeaderView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"ScanResultObjectHeaderView" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

-(void)loadWithObject:(ScanCodeRelatedContain *)obj
{
    _obj=obj;
    
    lblTitle.text=_obj.title;
}

-(ScanCodeRelatedContain *)object
{
    return _obj;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return [super hitTest:point withEvent:event];
}

+(float)height
{
    return 33;
}

@end
