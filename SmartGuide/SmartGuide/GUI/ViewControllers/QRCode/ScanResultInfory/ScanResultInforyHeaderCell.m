//
//  ScanResultInforyHeaderCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyHeaderCell.h"
#import "ScanCodeDecode.h"
#import "Constant.h"
#import "Utility.h"

@implementation ScanResultInforyHeaderCell
@synthesize suggestHeight;

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    _decode=decode;
    [self layoutIfNeeded];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!_decode.textAttribute)
    {
        _decode.textAttribute=[[NSAttributedString alloc] initWithString:_decode.text attributes:@{NSFontAttributeName:lbl.font
                                                                                                 , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentCenter]}];
    }
    
    lbl.frame=CGRectMake(54, 10, 220, 0);
    lbl.attributedText=_decode.textAttribute;
    
    [lbl sizeToFit];
    
    suggestHeight=lbl.l_v_y+lbl.l_v_h+10;
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyHeaderCell";
}

@end

@implementation UITableView(ScanResultInforyHeaderCell)

-(void)registerScanResultInforyHeaderCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyHeaderCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyHeaderCell reuseIdentifier]];
}

-(ScanResultInforyHeaderCell *)scanResultInforyHeaderCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyHeaderCell reuseIdentifier]];
}

@end