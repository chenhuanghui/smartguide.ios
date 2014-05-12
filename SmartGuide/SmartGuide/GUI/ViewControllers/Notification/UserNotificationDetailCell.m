//
//  UserNotificationDetailCell.m
//  Infory
//
//  Created by XXX on 4/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationDetailCell.h"
#import "ImageManager.h"

@implementation UserNotificationDetailCell

-(void)loadWithUserNotificationDetail:(UserNotificationContent *)obj
{
    _obj=obj;
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:[UIFont fontWithName:@"Avenir-Heavy" size:13] forKey:NSFontAttributeName];
    [dict setObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
    
    NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
    paraStyle.alignment=NSTextAlignmentJustified;
    paraStyle.firstLineHeadIndent=0;
    
    [dict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
    
    NSAttributedString *att=[[NSAttributedString alloc] initWithString:obj.title attributes:dict];
    
    lblTitle.attributedText=att;
    
    [dict setObject:[UIColor darkGrayColor] forKey:NSForegroundColorAttributeName];
    [dict setObject:[UIFont fontWithName:@"Avenir-Roman" size:13] forKey:NSFontAttributeName];
    
//    att=[[NSAttributedString alloc] initWithString:obj.desc attributes:dict];
//    lblContent.attributedText=att;
//
//    lblTime.text=obj.time;
//    [lblContent l_v_setY:39+obj.titleHeight.floatValue];
//    lblGoTo.text=obj.goTo;
//    [imgvIcon loadShopLogoWithURL:obj.logo];
//    
//    [lblTitle l_v_setH:obj.titleHeight.floatValue];
//    [lblContent l_v_setH:obj.descHeight.floatValue];
//    
//    btnGo.hidden=obj.goTo.length==0;
//    lblGoTo.hidden=obj.goTo.length==0;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    lblTitle.textAlignment=NSTextAlignmentJustified;
    lblContent.textAlignment=NSTextAlignmentJustified;
}

-(UserNotificationContent *)userNotificationDetail
{
    return _obj;
}

+(NSString *)reuseIdentifier
{
    return @"UserNotificationDetailCell";
}

+(float)heightWithUserNotificationDetail:(UserNotificationContent *)obj
{
    float height=129;
    
    if(obj.titleHeight.floatValue==-1)
    {
        CGSize size=[obj.title sizeWithFont:[UIFont fontWithName:@"Avenir-Heavy" size:13] constrainedToSize:CGSizeMake(274, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
        obj.titleHeight=@(size.height);
    }
    
    height+=obj.titleHeight.floatValue;
    
    if(obj.descHeight.floatValue==-1)
    {
//        CGSize size=[obj.desc sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(274, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
//        obj.descHeight=@(size.height);
    }
    
    height+=obj.descHeight.floatValue;
    
//    height-=obj.goTo.length==0?44:0;
    
    return height;
}

- (IBAction)btnGoTouchUpInside:(id)sender {
    [self.delegate userNotificationDetailCellTouchedGo:self userNotificationDetail:_obj];
}

- (IBAction)btnGoToTouchUpInside:(id)sender {
    [self.delegate userNotificationDetailCellTouchedGo:self userNotificationDetail:_obj];
}

@end
