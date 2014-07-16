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

-(void)loadWithDecode:(ScanCodeDecode *)obj
{
    lbl.attributedText=obj.textAttribute;
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyTextCell";
}

+(float)heightWithDecode:(ScanCodeDecode *)decode
{
    if(!decode.textAttribute)
    {
        decode.textAttribute=[[NSAttributedString alloc] initWithString:decode.text attributes:@{NSFontAttributeName:FONT_SIZE_REGULAR(12)
                                                                                                 , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentJustified]}];
    }
    
    if(decode.textHeight.floatValue==-1)
    {
        decode.textHeight=@([decode.textAttribute boundingRectWithSize:CGSizeMake(260, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil].size.height);
    }
    
    return decode.textHeight.floatValue+20;
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