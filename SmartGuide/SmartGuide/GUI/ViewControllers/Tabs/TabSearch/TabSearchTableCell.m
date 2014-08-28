//
//  TabSearchTableCell.m
//  Infory
//
//  Created by XXX on 8/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabSearchTableCell.h"
#import "OperationSearchAutocomplete.h"
#import "SearchPlacelist.h"
#import "FTCoreTextView.h"

@implementation TabSearchTableCell

-(id)object
{
    return _obj;
}

-(void)loadWithPlacelist:(SearchPlacelist *)obj
{
    _obj=obj;
    
    [lblText setText:[obj.title stringByAppendingTagName:@"text"]];
}

-(void)loadWithAutoCompleteShop:(AutocompleteShop *)obj
{
    _obj=obj;
    
    if(obj.highlight.length>0)
        [lblText setText:[obj.highlight stringByAppendingTagName:@"text"]];
    else
        [lblText setText:[obj.content stringByAppendingTagName:@"text"]];
}

-(void)loadWithAutoCompletePlacelist:(AutocompletePlacelist *)obj
{
    _obj=obj;
    
    if(obj.highlight.length>0)
        [lblText setText:[obj.highlight stringByAppendingTagName:@"text"]];
    else
        [lblText setText:[obj.content stringByAppendingTagName:@"text"]];
}

+(NSString *)reuseIdentifier
{
    return @"TabSearchTableCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIEdgeInsets paraInset=UIEdgeInsetsMake(14, 0, 0, 0);
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"text"];
    style.font=FONT_SIZE_NORMAL(13);
    style.color=[UIColor color255WithRed:135 green:135 blue:135 alpha:255];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.paragraphInset=paraInset;
    
    [lblText addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"em"];
    style.font=FONT_SIZE_NORMAL(13);
    style.color=[UIColor colorWithRed:0.357 green:0.357 blue:0.357 alpha:1];
    style.textAlignment=FTCoreTextAlignementLeft;
//    style.paragraphInset=paraInset;
    
    [lblText addStyle:style];
}

+(float)height
{
    return 45;
}

@end

@implementation UITableView(TabSearchTableCell)

-(void) registerTabSearchTableCell
{
    [self registerNib:[UINib nibWithNibName:[TabSearchTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[TabSearchTableCell reuseIdentifier]];
}

-(TabSearchTableCell*) tabSearchTableCell
{
    return [self dequeueReusableCellWithIdentifier:[TabSearchTableCell reuseIdentifier]];
}

@end