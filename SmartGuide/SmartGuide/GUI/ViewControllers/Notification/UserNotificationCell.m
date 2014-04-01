//
//  UserNotificationCell.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationCell.h"

@implementation UserNotificationCell

-(void)loadWithUserNotification:(UserNotification *)obj
{
    _obj=obj;
    
    lblContent.attributedText=obj.contentAttribute;
    lblContent.backgroundColor=[UIColor redColor];
    [lblContent l_v_setH:obj.contentHeight.floatValue];
//    lblTime.text=obj.time;
    
    displayContentView.backgroundColor=obj.enumStatus==USER_NOTIFICATION_STATUS_READ?[UIColor darkGrayColor]:[UIColor whiteColor];
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(leftView.l_v_w+rightView.l_v_w, 0);
}

+(NSString *)reuseIdentifier
{
    return @"UserNotificationCell";
}

+(float)heightWithUserNotification:(UserNotification *)obj
{
    float height=77;
    
    if(!obj.contentAttribute)
    {
        NSMutableDictionary *dict=[NSMutableDictionary new];
        [dict setObject:[UIFont fontWithName:@"Avenir-Roman" size:13] forKey:NSFontAttributeName];
        [dict setObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
        
        NSMutableAttributedString *contentAttribute=[NSMutableAttributedString new];
        NSMutableAttributedString *attStr=[[NSMutableAttributedString alloc] initWithString:obj.content attributes:dict];
        
        NSArray *highlightIndex=obj.highlightIndex;
        int count=highlightIndex.count;
        for(int i=0;i<count;i+=2)
        {
            [dict setObject:[UIFont fontWithName:@"Avenir-Heavy" size:13] forKey:NSFontAttributeName];
            
            NSRange range=NSMakeRange([highlightIndex[i] integerValue], [highlightIndex[i+1] integerValue]);
            [attStr setAttributes:dict range:range];
        }

        [contentAttribute appendAttributedString:attStr];
        
        [dict setObject:[UIFont fontWithName:@"Avenir-Roman" size:1] forKey:NSFontAttributeName];
        attStr=[[NSMutableAttributedString alloc] initWithString:@"\n\n" attributes:dict];
        [contentAttribute appendAttributedString:attStr];
        
        [dict removeAllObjects];
        [dict setObject:[UIFont fontWithName:@"Avenir-Roman" size:12] forKey:NSFontAttributeName];
        [dict setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
        attStr=[[NSMutableAttributedString alloc] initWithString:obj.time attributes:dict];
        [contentAttribute appendAttributedString:attStr];
        
        obj.contentAttribute=contentAttribute;
    }
    
    if(obj.contentHeight.floatValue==-1)
    {
        obj.contentHeight=@([obj.contentAttribute boundingRectWithSize:CGSizeMake(264, 9999) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine context:nil].size.height);
    }
    
    height+=MAX(0,obj.contentHeight.floatValue-22);

    return height;
}

- (IBAction)btnDetailTouchUpInside:(id)sender {
    [scroll setContentOffset:CGPointZero animated:true];
    [[self delegate] userNotificationCellTouchedDetail:self obj:_obj];
}

- (IBAction)btnRemoveTouchUpInside:(id)sender {
    [scroll setContentOffset:CGPointZero animated:true];
}

-(UserNotification *)userNotification
{
    return _obj;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
    [leftView addGestureRecognizer:tap];
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    [self.delegate userNotificationCellTouchedDetail:self obj:_obj];
}

@end
