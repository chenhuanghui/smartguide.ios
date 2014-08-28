//
//  TabInboxListTableCell.m
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabInboxListTableCell.h"
#import "Label.h"
#import "MessageList.h"
#import "MessageAction.h"

@implementation TabInboxListTableCell

-(void)loadWithMessageList:(MessageList *)obj displayType:(enum TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE)displayType
{
    _obj=obj;
    _displayType=displayType;
    
    [self setNeedsLayout];
}

-(void) alignTop:(MessageList*) obj
{
    imgvLogo.frame=CGRectMake(10, 10, 44, 44);
    lblTime.text=obj.time;
    
    if(CGRectIsEmpty(obj.timeRect))
    {
        float x=imgvLogo.xw+imgvLogo.OX;
        lblTime.frame=CGRectMake(x, imgvLogo.OY, (displayView.SW-x)/2, 0);
        [lblTime defautSizeToFit];
        
        if(lblTime.SH<imgvLogo.SH)
        {
            lblTime.OY+=(imgvLogo.SH-lblTime.SH)/2;
        }
        
        obj.timeRect=lblTime.frame;
    }
    else
        lblTime.frame=obj.timeRect;
    
    circleView.O=CGPointMake(displayView.SW-circleView.SW-20, 20);
}

-(float)calculatorHeight:(MessageList *)obj displayType:(enum TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE)displayType
{
    [self alignTop:obj];
    
    switch (displayType) {
        case TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE_SMALL:
        {
            displayView.frame=CGRectMake(5, 15, 310, 0);
            
            line.frame=CGRectMake(0, imgvLogo.yh+5, displayView.SW, 1);
            
            lblTitle.numberOfLines=2;
            lblTitle.text=obj.title;
            
            if(CGRectIsEmpty(obj.titleRectSmall))
            {
                lblTitle.frame=CGRectMake(20, line.yh+5, displayView.SW-40, 0);
                [lblTitle defautSizeToFit];
                
                obj.titleRectSmall=lblTitle.frame;
            }
            else
                lblTitle.frame=obj.titleRectSmall;
            
            displayView.SH=lblTitle.yh+5;
            imgvBG.frame=CGRectMake(4, displayView.OY, 312, displayView.SH);
            
            return imgvBG.yh+imgvBG.OY;
        }
            
        case TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE_FULL:
        {
            displayView.frame=CGRectMake(5, 15, 310, 0);
            
            if(obj.video.length>0)
            {
                imgvImage.O=CGPointMake(0, imgvLogo.yh+10);
                imgvImage.S=CGSizeResizeToWidth(displayView.SW, CGSizeMake(obj.videoWidth.floatValue, obj.videoHeight.floatValue));
            }
            else if(obj.image.length>0)
            {
                imgvImage.O=CGPointMake(0, imgvLogo.yh+10);
                imgvImage.S=CGSizeResizeToWidth(displayView.SW, CGSizeMake(obj.imageWidth.floatValue, obj.videoHeight.floatValue));
            }
            else
            {
                imgvImage.O=CGPointMake(0, imgvLogo.yh);
                imgvImage.S=CGSizeZero;
            }
            
            float y=imgvImage.yh;
            
            if(imgvImage.SH>0)
                y+=15;// padding image
            else
                y+=10;// padding logo;
            
            lblTitle.numberOfLines=0;
            lblTitle.attributedText=[[NSAttributedString alloc] initWithString:obj.title attributes:@{NSFontAttributeName:lblTitle.font
                                                                                                      , NSParagraphStyleAttributeName:paragraphStyleJustified()}];
            
            if(CGRectIsEmpty(obj.titleRectFull))
            {
                lblTitle.frame=CGRectMake(20, y, displayView.SW-40, 0);
                [lblTitle defautSizeToFit];
                
                obj.titleRectFull=lblTitle.frame;
            }
            else
                lblTitle.frame=obj.titleRectFull;
            
            y=lblTitle.yh;
            
            if(lblTitle.SH>0)
                y+=5;
            
            lblContent.attributedText=[[NSAttributedString alloc] initWithString:obj.content attributes:@{NSFontAttributeName:lblContent.font
                                                                                                          , NSParagraphStyleAttributeName:paragraphStyleJustified()}];
            
            if(CGRectIsEmpty(obj.contentRect))
            {
                lblContent.frame=CGRectMake(20, y, displayView.SW-40, 0);
                [lblContent defautSizeToFit];
                
                obj.contentRect=lblContent.frame;
            }
            else
                lblContent.frame=obj.contentRect;
            
            if(obj.actionsObjects.count>0)
            {
                buttonsView.O=CGPointMake(0, lblContent.yh+15);
                
                float buttonHeight=90+5;
                buttonsView.S=CGSizeMake(displayView.SW, buttonHeight*obj.actionsObjects.count+15);
            }
            else
            {
                buttonsView.O=CGPointMake(0, lblContent.yh);
                buttonsView.S=CGSizeZero;
            }

            if(buttonsView.SH>0)
                displayView.SH=buttonsView.yh;
            else
                displayView.SH=buttonsView.yh+5;

            imgvBG.frame=CGRectMake(4, displayView.OY, 312, displayView.SH);
            
            return imgvBG.yh+imgvBG.OY;
        }
    }
}

-(void)layoutSubviews
{
    if(_isPrototypeCell)
        return;
    
    [super layoutSubviews];
    [self calculatorHeight:_obj displayType:_displayType];
    
    [buttonsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float y=0;
    Label *sampleLabel=[Label new];
    sampleLabel.font=FONT_SIZE_NORMAL(14);
    sampleLabel.numberOfLines=1;
    
    for(MessageAction *obj in _obj.actionsObjects)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj.actionTitle forState:UIControlStateNormal];
    
        sampleLabel.text=obj.actionTitle;
        [sampleLabel defautSizeToFit];
        
//        btn.O=CGPointMake((buttonsView.SW-sampleLabel.SW)/2, <#CGFloat y#>)
        
        [buttonsView addSubview:btn];
    }
}

+(NSString *)reuseIdentifier
{
    return @"TabInboxListTableCell";
}

@end

#import <objc/runtime.h>

static char TabInboxListTablePrototypeCellKey;
@implementation UITableView(TabInboxListTableCell)

-(void) registerTabInboxListTableCell
{
    [self registerNib:[UINib nibWithNibName:[TabInboxListTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[TabInboxListTableCell reuseIdentifier]];
}

-(TabInboxListTableCell*) tabInboxListTableCell
{
    TabInboxListTableCell *cell=[self dequeueReusableCellWithIdentifier:[TabInboxListTableCell reuseIdentifier]];
    
    cell.isPrototypeCell=false;
    
    return cell;
}

-(TabInboxListTableCell *)tabInboxListTablePrototypeCell
{
    TabInboxListTableCell *cell=objc_getAssociatedObject(self, &TabInboxListTablePrototypeCellKey);
    
    if(!cell)
    {
        cell=[self tabInboxListTableCell];
        objc_setAssociatedObject(self, &TabInboxListTablePrototypeCellKey, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    cell.isPrototypeCell=true;
    
    return cell;
}

@end