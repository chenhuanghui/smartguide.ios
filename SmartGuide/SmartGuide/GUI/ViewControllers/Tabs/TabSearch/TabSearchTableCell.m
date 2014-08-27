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

@implementation TabSearchTableCell

-(id)object
{
    return _obj;
}

-(void)loadWithPlacelist:(SearchPlacelist *)obj
{
    _obj=obj;
    
    lbl.textColor=[UIColor darkTextColor];
    lbl.text=obj.title;
}

-(void)loadWithAutoCompleteShop:(AutocompleteShop *)obj
{
    _obj=obj;
    
    NSMutableAttributedString *attStr=[NSMutableAttributedString new];
    
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:obj.highlight
                                                                   attributes:@{NSFontAttributeName:lbl.font
                                                                                , NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:obj.content
                                                                   attributes:@{NSFontAttributeName:lbl.font
                                                                                , NSForegroundColorAttributeName:[UIColor darkTextColor]}]];
    
    lbl.attributedText=attStr;
}

-(void)loadWithAutoCompletePlacelist:(AutocompletePlacelist *)obj
{
    _obj=obj;
    
    NSMutableAttributedString *attStr=[NSMutableAttributedString new];
    
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:obj.highlight
                                                                   attributes:@{NSFontAttributeName:lbl.font
                                                                                , NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:obj.content
                                                                   attributes:@{NSFontAttributeName:lbl.font
                                                                                , NSForegroundColorAttributeName:[UIColor darkTextColor]}]];
    
    lbl.attributedText=attStr;
}

+(NSString *)reuseIdentifier
{
    return @"TabSearchTableCell";
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