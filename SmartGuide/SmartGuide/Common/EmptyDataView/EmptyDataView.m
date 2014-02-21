//
//  EmptyDataView.m
//  SmartGuide
//
//  Created by MacMini on 21/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "EmptyDataView.h"
#import "Utility.h"

@implementation EmptyDataView

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"EmptyDataView" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

@end

@implementation UIView(EmptyDataView)

-(EmptyDataView *)emptyDataView
{
    for(UIView *view in self.subviews)
    {
        if([view isKindOfClass:[EmptyDataView class]])
            return (EmptyDataView*)view;
    }

    return nil;
}

-(UILabel *)emptyDataLabel
{
    return [self emptyDataView].lblContent;
}

-(void)removeEmptyDataView
{
    UIView *view=[self emptyDataView];
    while (view) {
        [view removeFromSuperview];
        view=[self emptyDataView];
    }
}

-(void)showEmptyDataWithText:(NSString *)text align:(enum EMPTY_DATA_ALIGN_TEXT)contentMode
{
    [self removeEmptyDataView];
    
    EmptyDataView *view=[EmptyDataView new];
    view.lblContent.text=text;
    [view l_v_setS:self.l_v_s];
    
//    switch (contentMode) {
//        case EMPTY_DATA_ALIGN_TEXT_MIDDLE:
//            [view l_v_setS:self.l_v_s];
//            break;
//            
//        case EMPTY_DATA_ALIGN_TEXT_TOP:
//            [view l_v_setH:[text sizeWithFont:view.lblContent.font constrainedToSize:CGSizeMake(self.l_v_w, 9999) lineBreakMode:view.lblContent.lineBreakMode].height+5];
//            [view l_v_setW:self.l_v_w];
//            break;
//    }
    
    [self addSubview:view];
}

@end