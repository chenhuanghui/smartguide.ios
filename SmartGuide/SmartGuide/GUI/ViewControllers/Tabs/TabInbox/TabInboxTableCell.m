//
//  TabInboxTableCell.m
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabInboxTableCell.h"
#import "Label.h"
#import "MessageSender.h"
#import "Utility.h"

@implementation TabInboxTableCell

-(void)loadWithMessageSender:(MessageSender *)obj
{
    self.object=obj;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    if(self.isPrototypeCell)
        return;
    
    [super layoutSubviews];
    
    [self calculatorHeight:_object];
    
    if(_object.highlightUnread.boolValue)
    {
        circleView.hidden=false;
        self.backgroundColor=[UIColor whiteColor];
    }
    else
    {
        circleView.hidden=true;
        self.backgroundColor=[UIColor grayColor];
    }
}

-(float)calculatorHeight:(MessageSender *)obj
{
    lblTitle.text=obj.sender;
    
    if(CGRectIsEmpty(obj.titleRect))
    {
        float x=circleView.xw+circleView.OX;
        lblTitle.frame=CGRectMake(x, circleView.OY, self.SW-x-10, 0);
        [lblTitle defautSizeToFit];
        
        obj.titleRect=lblTitle.frame;
    }
    else
        lblTitle.frame=obj.titleRect;
    
    lblContent.attributedText=[[NSAttributedString alloc] initWithString:obj.content
                                                    attributes:@{NSFontAttributeName:lblContent.font
                                                                 , NSParagraphStyleAttributeName:paragraphStyleJustified()}];
    
    if(CGRectIsEmpty(obj.contentRect))
    {
        float x=circleView.xw+circleView.OX;
        float y=lblTitle.yh;
        
        if(lblTitle.SH>0)
            y+=5;
        
        lblContent.frame=CGRectMake(x, y, self.SW-x-10, 0);
        [lblContent defautSizeToFit];
        obj.contentRect=lblContent.frame;
    }
    else
        lblContent.frame=obj.contentRect;
    
    line.frame=CGRectMake(0, lblContent.yh+15, self.SW, 2);
    
    return line.yh;
}

+(NSString *)reuseIdentifier
{
    return @"TabInboxTableCell";
}

@end

#import <objc/runtime.h>

static char TabInboxTablePrototypeCellKey;
@implementation UITableView(TabInboxTableCell)

-(void) registerTabInboxTableCell
{
    [self registerNib:[UINib nibWithNibName:[TabInboxTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[TabInboxTableCell reuseIdentifier]];
}

-(TabInboxTableCell*) tabInboxTableCell
{
    TabInboxTableCell *cell=[self dequeueReusableCellWithIdentifier:[TabInboxTableCell reuseIdentifier]];
    
    cell.isPrototypeCell=false;
    
    return cell;
}

-(TabInboxTableCell *)tabInboxTablePrototypeCell
{
    TabInboxTableCell *cell=objc_getAssociatedObject(self, &TabInboxTablePrototypeCellKey);
    
    if(!cell)
    {
        cell=[self tabInboxTableCell];
        objc_setAssociatedObject(self, &TabInboxTablePrototypeCellKey, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    cell.isPrototypeCell=true;
    
    return cell;
}

@end