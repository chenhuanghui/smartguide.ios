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

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    lbl.attributedText=decode.textAttribute;
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyHeaderCell";
}

+(float)heightWithDecode:(ScanCodeDecode *)decode
{
    if(!decode.textAttribute)
    {
        decode.textAttribute=[[NSAttributedString alloc] initWithString:decode.text attributes:@{NSFontAttributeName:FONT_SIZE_MEDIUM(22)
                                                                                                 , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentJustified]}];
    }
    
    if(decode.textHeight.floatValue==-1)
    {
        decode.textHeight=@([decode.textAttribute boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil].size.height);
    }
    
    return decode.textHeight.floatValue+20;
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