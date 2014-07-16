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

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    [imgv loadScanImageWithURL:decode.image];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyImageCell";
}

+(float)heightWithDecode:(ScanCodeDecode *)decode
{
    if(CGSizeEqualToSize(decode.imageSize, CGSizeZero))
    {
        decode.imageSize=makeSizeProportional(320, CGSizeMake(decode.imageWidth.floatValue, decode.imageHeight.floatValue));
    }
    
    return decode.imageSize.height+20;
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