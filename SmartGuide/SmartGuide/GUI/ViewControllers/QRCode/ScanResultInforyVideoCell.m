//
//  ScanResultInforyVideoCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyVideoCell.h"
#import "ScanCodeDecode.h"
#import "ImageManager.h"

@implementation ScanResultInforyVideoCell

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    [imgv loadScanVideoThumbnailWithURL:decode.videoThumbnail];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyVideoCell";
}

+(float)heightWithDecode:(ScanCodeDecode *)decode
{
    if(CGSizeEqualToSize(decode.videoSize,CGSizeZero))
        decode.videoSize=makeSizeProportional(320, CGSizeMake(decode.videoWidth.floatValue, decode.videoHeight.floatValue));
    
    return decode.videoSize.height+6;
}

@end

@implementation UITableView(ScanResultInforyVideoCell)

-(void)registerScanResultInforyVideoCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyVideoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyVideoCell reuseIdentifier]];
}

-(ScanResultInforyVideoCell *)scanResultInforyVideoCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyVideoCell reuseIdentifier]];
}

@end