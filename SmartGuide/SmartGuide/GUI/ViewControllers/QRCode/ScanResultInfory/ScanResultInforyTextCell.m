//
//  ScanResultInforyTextCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyTextCell.h"
#import "ScanCodeDecode.h"

@implementation ScanResultInforyTextCell
@synthesize suggestHeight, isCalculatingSuggestHeight;

-(void)loadWithDecode:(ScanCodeDecode *)obj
{
    _decode=obj;
    isCalculatingSuggestHeight=false;
    [self setNeedsLayout];
}

-(void)calculatingSuggestHeight
{
    isCalculatingSuggestHeight=true;
    [self layoutSubviews];
    isCalculatingSuggestHeight=false;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!_decode.textAttribute)
    {
        _decode.textAttribute=[[NSAttributedString alloc] initWithString:_decode.text attributes:@{NSFontAttributeName:lbl.font
                                                                                                 , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentJustified]}];
    }
    
    lbl.frame=CGRectMake(30, 10, 260, 0);
    lbl.attributedText=_decode.textAttribute;
    [lbl sizeToFit];
    
    suggestHeight=lbl.l_v_y+lbl.l_v_h+10;
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyTextCell";
}

@end

@implementation UITableView(ScanResultInforyTextCell)

-(void)registerScanResultInforyTextCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyTextCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyTextCell reuseIdentifier]];
}

-(ScanResultInforyTextCell *)scanResultInforyTextCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyTextCell reuseIdentifier]];
}

@end