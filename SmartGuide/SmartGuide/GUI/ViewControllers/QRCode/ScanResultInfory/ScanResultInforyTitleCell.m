//
//  ScanResultInforyTitleCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyTitleCell.h"
#import "ScanCodeDecode.h"
#import "Label.h"
#import "Utility.h"

@implementation ScanResultInforyTitleCell

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    _object=decode;
    [self setNeedsLayout];
}

-(float)calculatorHeight:(ScanCodeDecode *)object
{
    lbl.attributedText=attributedStringJustified(object.text, lbl.font);
    
    if(CGRectIsZero(object.textRect))
    {
        lbl.frame=CGRectMake(25, 10, self.SW-25*2, 0);
        [lbl defautSizeToFit];
        
        object.textRect=lbl.frame;
    }
    else
        lbl.frame=object.textRect;
    
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
    return @"ScanResultInforyTitleCell";
}

@end

#import <objc/runtime.h>
static char ScanResultInforyTitlePrototypeCell;
@implementation UITableView(ScanResultInforyTitleCell)

-(void)registerScanResultInforyTitleCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyTitleCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyTitleCell reuseIdentifier]];
}

-(ScanResultInforyTitleCell *)scanResultInforyTitleCell
{
    ScanResultInforyTitleCell *cell=[self dequeueReusableCellWithIdentifier:[ScanResultInforyTitleCell reuseIdentifier]];
    
    cell.isPrototypeCell=false;
    
    return cell;
}

-(ScanResultInforyTitleCell *)scanResultInforyTitlePrototypeCell
{
    ScanResultInforyTitleCell *obj=objc_getAssociatedObject(self, &ScanResultInforyTitlePrototypeCell);
    
    if(!obj)
    {
        obj=[self scanResultInforyTitleCell];
        objc_setAssociatedObject(self, &ScanResultInforyTitlePrototypeCell, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.isPrototypeCell=true;
    
    return obj;
}

@end