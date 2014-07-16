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

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    lbl.attributedText=decode.textAttribute;
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyTitleCell";
}

+(float)heightWithDecode:(ScanCodeDecode *)decode
{
    if(!decode.textAttribute)
    {
        decode.textAttribute=[[NSAttributedString alloc] initWithString:decode.text attributes:@{NSFontAttributeName:FONT_SIZE_REGULAR(13)
                                                                                                 , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentJustified]}];
    }
    
    if(decode.textHeight.floatValue==-1)
    {
        decode.textHeight=@([decode.textAttribute boundingRectWithSize:CGSizeMake(270, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil].size.height);
    }
    
    return decode.textHeight.floatValue+20;
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