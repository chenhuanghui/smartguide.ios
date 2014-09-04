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
#import "Utility.h"

@implementation ScanResultInforyImageCell

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    _object=decode;
    
    [imgv defaultLoadImageWithURL:_object.image];
    
    [self setNeedsLayout];
}

-(float)calculatorHeight:(ScanCodeDecode *)object
{
    if(CGSizeIsZero(object.imageSize))
    {
        object.imageSize=CGSizeReduceToWidth(320, CGSizeMake(object.imageWidth.floatValue, object.imageHeight.floatValue));
        
        if(object.imageSize.width<UIApplicationSize().width)
            imgv.SW=object.imageSize.width;
        else
            imgv.SW=UIApplicationSize().width;
    }
    
    imgv.SH=object.imageSize.height;
    
    imgv.O=CGPointMake(self.SW/2-imgv.SW/2, 10);
    
    return imgv.yh+imgv.OY;
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyImageCell";
}

-(void)layoutSubviews
{
    if(_isPrototypeCell)
        return;
    
    [super layoutSubviews];
    
    [self calculatorHeight:_object];
}

@end

#import <objc/runtime.h>
static char ScanResultInforyImagePrototypeCell;
@implementation UITableView(ScanResultInforyImageCell)

-(void)registerScanResultInforyImageCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyImageCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyImageCell reuseIdentifier]];
}

-(ScanResultInforyImageCell *)scanResultInforyImageCell
{
    ScanResultInforyImageCell *obj=[self dequeueReusableCellWithIdentifier:[ScanResultInforyImageCell reuseIdentifier]];
    
    obj.isPrototypeCell=false;
    
    return obj;
}

-(ScanResultInforyImageCell *)scanResultInforyImagePrototypeCell
{
    ScanResultInforyImageCell *obj=objc_getAssociatedObject(self, &ScanResultInforyImagePrototypeCell);
    
    if(!obj)
    {
        obj=[self scanResultInforyImageCell];
        objc_setAssociatedObject(self, &ScanResultInforyImagePrototypeCell, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.isPrototypeCell=true;
    
    return obj;
}

@end