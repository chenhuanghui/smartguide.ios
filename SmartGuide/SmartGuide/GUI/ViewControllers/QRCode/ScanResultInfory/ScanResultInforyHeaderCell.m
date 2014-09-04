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
#import "Label.h"

@implementation ScanResultInforyHeaderCell

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    _object=decode;
    
    [self setNeedsLayout];
}

-(float)calculatorHeight:(ScanCodeDecode *)object
{
    lbl.attributedText=[[NSAttributedString alloc] initWithString:object.text
                                                       attributes:@{NSFontAttributeName:lbl.font
                                                                    , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentCenter]}];
    
    if(CGRectIsZero(object.textRect))
    {
        lbl.frame=CGRectMake(55, 10, self.SW-110, 0);
        [lbl defautSizeToFit];
        
        if(lbl.SW<self.SW-110)
            lbl.SW=self.SW-110;
        
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
    return @"ScanResultInforyHeaderCell";
}

@end

#import <objc/runtime.h>
static char ScanResultInforyHeaderPrototypeCellKey;
@implementation UITableView(ScanResultInforyHeaderCell)

-(void)registerScanResultInforyHeaderCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyHeaderCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyHeaderCell reuseIdentifier]];
}

-(ScanResultInforyHeaderCell *)scanResultInforyHeaderCell
{
    ScanResultInforyHeaderCell *cell=[self dequeueReusableCellWithIdentifier:[ScanResultInforyHeaderCell reuseIdentifier]];
    
    cell.isPrototypeCell=false;
    
    return cell;
}

-(ScanResultInforyHeaderCell*) scanResultInforyHeaderPrototypeCell
{
    ScanResultInforyHeaderCell *obj=objc_getAssociatedObject(self, &ScanResultInforyHeaderPrototypeCellKey);
    
    if(!obj)
    {
        obj=[self scanResultInforyHeaderCell];
        objc_setAssociatedObject(self, &ScanResultInforyHeaderPrototypeCellKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.isPrototypeCell=true;
    
    return obj;
}

@end