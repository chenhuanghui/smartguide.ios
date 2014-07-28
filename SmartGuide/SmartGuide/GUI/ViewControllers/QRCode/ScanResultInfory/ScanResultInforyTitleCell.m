//
//  ScanResultInforyTitleCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyTitleCell.h"
#import "ScanCodeDecode.h"

@implementation ScanResultInforyTitleCell
@synthesize suggestHeight;

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    _decode=decode;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!_decode.textAttribute)
    {
        _decode.textAttribute=[[NSAttributedString alloc] initWithString:_decode.text attributes:@{NSFontAttributeName:FONT_SIZE_REGULAR(13)
                                                                                                 , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentJustified]}];
    }
    
    lbl.frame=CGRectMake(25, 10, 270, 0);
    lbl.attributedText=_decode.textAttribute;
    [lbl sizeToFit];
    
    suggestHeight=lbl.l_v_y+lbl.l_v_h+10;
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyTitleCell";
}

@end

@implementation UITableView(ScanResultInforyTitleCell)

-(void)registerScanResultInforyTitleCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyTitleCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyTitleCell reuseIdentifier]];
}

-(ScanResultInforyTitleCell *)scanResultInforyTitleCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyTitleCell reuseIdentifier]];
}

@end