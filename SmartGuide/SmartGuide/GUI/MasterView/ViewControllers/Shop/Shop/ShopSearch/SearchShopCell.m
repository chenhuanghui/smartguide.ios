//
//  SearchShopCell.m
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SearchShopCell.h"
#import "ASIOperationSearchAutocomplete.h"

@implementation SearchShopCell

-(void)loadWithDataAutocomplete:(NSDictionary *)dict
{
    _place=nil;
    _dict=dict;
    
    [lbl highlightWithText:dict[AUTOCOMPLETE_KEY] pairs:dict[AUTOCOMPLETE_PAIRS] normalStyleName:@"text" styleBoldName:@"highlight"];
    [icon setImage:[UIImage imageNamed:@"ava.png"]];
}

-(void)loadWithPlace:(Placelist *)place
{
    _place=place;
    _dict=nil;
    
    [lbl setText:[place.title stringByAppendingTagName:@"text"]];
    [icon setImage:[UIImage imageNamed:@"ava.png"]];
}

-(NSDictionary *)data
{
    return _dict;
}

-(Placelist *)place
{
    return _place;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"text"];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:13];
    style.color=[UIColor grayColor];
    style.textAlignment=FTCoreTextAlignementLeft;
    
    [lbl addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"highlight"];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:13];
    style.color=[UIColor blackColor];
    style.textAlignment=FTCoreTextAlignementLeft;
    
    [lbl addStyle:style];
    
    icon.layer.cornerRadius=2;
    icon.layer.masksToBounds=true;
}

+(NSString *)reuseIdentifier
{
    return @"SearchShopCell";
}

+(float)height
{
    return 32;
}

@end
