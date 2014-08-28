//
//  TabInboxSectionView.m
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabInboxSectionView.h"
#import "Utility.h"

@implementation TabInboxSectionView

-(id)initWithFrame:(CGRect)frame
{
    frame.size.height=[TabInboxSectionView height];
    self=[super initWithFrame:frame];
    
    self.backgroundColor=[UIColor lightGrayColor];
    
    float height=7;
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(2, (frame.size.height-height)/2, height, height)];
    view.backgroundColor=[UIColor darkGrayColor];
    view.clipsToBounds=true;
    view.layer.cornerRadius=height/2;
    view.userInteractionEnabled=false;
    
    [self addSubview:view];
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(view.xw+5, 0, frame.size.width-view.xw-5-10, frame.size.height)];
    lbl.font=FONT_SIZE_NORMAL(13);
    lbl.textColor=[UIColor darkGrayColor];
    
    [self addSubview:lbl];
    _lbl=lbl;
    
    return self;
}

+(float)height
{
    return 30;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
