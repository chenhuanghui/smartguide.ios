//
//  ScanResultInforyTextCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyTextCell.h"
#import "ScanCodeDecode.h"
#import "Label.h"
#import "Utility.h"

@implementation ScanResultInforyTextCell

-(void)loadWithDecode:(ScanCodeDecode *)obj
{
    _object=obj;
    
    [self setNeedsLayout];
}

-(float)calculatorHeight:(ScanCodeDecode *)obj
{
    lbl.attributedText=attributedStringJustified(obj.text, lbl.font);
    
    if(CGRectIsZero(obj.textRect))
    {
        lbl.frame=CGRectMake(30, 10, self.SW-30*2, 0);
        [lbl defautSizeToFit];
        
        obj.textRect=lbl.frame;
    }
    else
        lbl.frame=obj.textRect;
    
    return lbl.yh+lbl.OY;
}

-(void)layoutSubviews
{
    if(_isPrototypeCell)
        return;
    
    [super layoutSubviews];
    
    [self calculatorHeight:_object];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyTextCell";
}

@end

#import <objc/runtime.h>
static char ScanResultInforyTextPrototypeCell;
@implementation UITableView(ScanResultInforyTextCell)

-(void)registerScanResultInforyTextCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyTextCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyTextCell reuseIdentifier]];
}

-(ScanResultInforyTextCell *)scanResultInforyTextCell
{
    ScanResultInforyTextCell *obj=[self dequeueReusableCellWithIdentifier:[ScanResultInforyTextCell reuseIdentifier]];
    
    obj.isPrototypeCell=false;
    
    return obj;
}

-(ScanResultInforyTextCell *)scanResultInforyTextPrototypeCell
{
    ScanResultInforyTextCell *obj=objc_getAssociatedObject(self, &ScanResultInforyTextPrototypeCell);
    
    if(!obj)
    {
        obj=[self scanResultInforyTextCell];
        objc_setAssociatedObject(self, &ScanResultInforyTextPrototypeCell, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.isPrototypeCell=true;
    
    return obj;
}

@end