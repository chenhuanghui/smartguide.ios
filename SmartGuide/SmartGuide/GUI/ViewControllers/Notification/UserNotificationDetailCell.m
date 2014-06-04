//
//  UserNotificationDetailCell.m
//  Infory
//
//  Created by XXX on 4/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationDetailCell.h"
#import "ImageManager.h"

@interface UserNotificationDetailCell()<TokenViewDelegate>

@end

@implementation UserNotificationDetailCell

-(void)tokenViewTouchedToken:(TokenView *)token object:(id)obj
{
    [self.delegate userNotificationDetailCellTouchedAction:self action:obj];
}

-(void)loadWithUserNotificationDetail:(UserNotificationContent *)obj displayType:(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE)displayType
{
    _obj=obj;
    _displayType=displayType;
    
    lblTime.text=obj.time;
    lblTitle.attributedText=obj.titleAttribute;
    lblContent.attributedText=obj.contentAttribute;
    [tokens setTokens:obj.actionTitles objects:obj.actionsObjects];
    [imgvIcon loadShopLogoWithURL:obj.logo];
    
    [lblTitle l_v_setH:obj.titleHeight.floatValue];
    
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+5];
    [lblContent l_v_setH:obj.contentHeight.floatValue];
    
    [tokens l_v_setY:lblContent.l_v_y+lblContent.l_v_h+5];
    [tokens l_v_setH:obj.actionsHeight.floatValue];
    
    lblContent.hidden=displayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE;
    
    btnLogo.userInteractionEnabled=obj.idShopLogo!=nil;
}

-(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE)displayType
{
    return _displayType;
}

-(UserNotificationContent *)userNotificationDetail
{
    return _obj;
}

+(NSString *)reuseIdentifier
{
    return @"UserNotificationDetailCell";
}

+(float)heightWithUserNotificationDetail:(UserNotificationContent *)obj displayType:(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE)displayType
{
    float height=88;
    
    if(!obj.titleAttribute)
    {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:[UIFont fontWithName:@"Avenir-Heavy" size:14] forKey:NSFontAttributeName];
        [dict setObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
        
        NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
        paraStyle.alignment=NSTextAlignmentJustified;
        
        [dict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
        obj.titleAttribute=[[NSAttributedString alloc] initWithString:obj.title attributes:dict];
    }
    
    if(obj.titleHeight.floatValue==-1)
    {
            CGRect rect=[obj.titleAttribute boundingRectWithSize:CGSizeMake(274, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        obj.titleHeight=@(rect.size.height);
    }
    
    if(!obj.contentAttribute)
    {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:[UIFont fontWithName:@"Avenir-Roman" size:13] forKey:NSFontAttributeName];
        [dict setObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
        
        NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
        paraStyle.alignment=NSTextAlignmentJustified;
        [dict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
        
        obj.contentAttribute=[[NSAttributedString alloc] initWithString:obj.content attributes:dict];
    }
    
    if(obj.contentHeight.floatValue==-1)
    {
        obj.contentHeight=@([obj.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(274, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    }
    
    if(obj.actionsHeight.floatValue==-1)
    {
        obj.actionsHeight=@([TokenView heightWithTokens:obj.actionTitles forWidth:312]);
    }
    
    switch (displayType) {
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL:
            height+=obj.titleHeight.floatValue+obj.contentHeight.floatValue;
            height+=obj.actionsHeight.floatValue;
            
            break;
            
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE:
            height+=obj.titleHeight.floatValue;
            height-=10;
            break;
    }
    
    return height;
}

- (IBAction)btnLogoTouchUpInside:(id)sender {
    [self.delegate userNotificationDetailCellTouchedLogo:self];
}

@end
