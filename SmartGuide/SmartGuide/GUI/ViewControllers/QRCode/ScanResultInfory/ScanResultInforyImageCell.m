//
//  ScanResultInforyImageCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyImageCell.h"
#import "ScanCodeDecode.h"
#import "ImageManager.h"

@implementation ScanResultInforyImageCell
@synthesize suggestHeight, isCalculatingSuggestHeight;

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    _decode=decode;
    isCalculatingSuggestHeight=false;
    [self setNeedsLayout];
}

-(void)calculatingSuggestHeight
{
    isCalculatingSuggestHeight=true;
    [self layoutSubviews];
    isCalculatingSuggestHeight=false;
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyImageCell";
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(CGSizeEqualToSize(_decode.imageSize, CGSizeZero))
    {
        _decode.imageSize=CGSizeReduceToWidth(320, CGSizeMake(_decode.imageWidth.floatValue, _decode.imageHeight.floatValue));
    }
    
    if(_decode.imageSize.width<320)
        [imgv l_v_setW:_decode.imageSize.width];
    else
        [imgv l_v_setW:320];
    
    
    [imgv l_v_setH:_decode.imageSize.height];
    
    [imgv l_v_setX:self.l_v_w/2-imgv.l_v_w/2];
    
    if(!isCalculatingSuggestHeight)
        [imgv loadScanImageWithURL:_decode.image];
    
    suggestHeight=imgv.l_v_y+imgv.l_v_h+10;
}

@end

@implementation UITableView(ScanResultInforyImageCell)

-(void)registerScanResultInforyImageCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyImageCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyImageCell reuseIdentifier]];
}

-(ScanResultInforyImageCell *)scanResultInforyImageCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyImageCell reuseIdentifier]];
}

@end