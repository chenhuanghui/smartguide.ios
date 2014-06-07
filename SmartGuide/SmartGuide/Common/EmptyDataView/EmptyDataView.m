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
        self.userInteractionEnabled=false;
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

-(void)showEmptyDataWithAttributeText:(NSAttributedString *)attributeText
{
    [self removeEmptyDataView];
    
    EmptyDataView *view=[EmptyDataView new];
    view.lblContent.attributedText=attributeText;
    [view l_v_setS:self.l_v_s];
    
    view.alpha=0;
    [self addSubview:view];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        view.alpha=1;
    }];
}

-(void)showEmptyDataWithText:(NSString *)text align:(enum EMPTY_DATA_ALIGN_TEXT)contentMode
{
    [self removeEmptyDataView];
    
    EmptyDataView *view=[EmptyDataView new];
    view.lblContent.text=text;
    [view l_v_setS:self.l_v_s];
    
    [self addSubview:view];
}

-(void)showEmptyDataViewWithText:(NSString *)text textColor:(UIColor *)textColor
{
    NSMutableParagraphStyle *para=[NSMutableParagraphStyle new];
    para.alignment=NSTextAlignmentCenter;
    
    NSAttributedString *attStr=[[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:FONT_SIZE_NORMAL(14),NSForegroundColorAttributeName:textColor,NSParagraphStyleAttributeName:para}];
    
    [self showEmptyDataWithAttributeText:attStr];
}

@end