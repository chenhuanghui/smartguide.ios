//
//  SearchShopCell.m
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SearchShopCell.h"

@implementation SearchShopCell

-(void)loadWithDataAutocompleteShop:(AutocompleteShop *)shop
{
    _place=nil;
    _placeauto=nil;
    _shop=shop;
    
    if(shop.highlight.length>0)
        [lbl setText:[shop.highlight stringByAppendingTagName:@"text"]];
    else
        [lbl setText:[shop.content stringByAppendingTagName:@"text"]];
    
    [icon setImage:[UIImage imageNamed:@"ava.png"]];
}

-(void)loadWithPlace:(Placelist *)place
{
    _place=place;
    _shop=nil;
    _placeauto=nil;
    
    [lbl setText:[place.title stringByAppendingTagName:@"text"]];
    [icon setImage:[UIImage imageNamed:@"ava.png"]];
}

-(void)loadWithDataAutocompletePlace:(AutocompletePlacelist *)place
{
    _place=nil;
    _shop=nil;
    _placeauto=place;
    
    if(_placeauto.highlight.length>0)
        [lbl setText:[_placeauto.highlight stringByAppendingTagName:@"text"]];
    else
        [lbl setText:[_placeauto.content stringByAppendingTagName:@"text"]];
    
    [icon setImage:[UIImage imageNamed:@"ava.png"]];
}

-(void)setCellType:(enum SEARCH_SHOP_CELL_TYPE)cellType
{
    switch (cellType) {
        case SEARCH_SHOP_CELL_FIRST:
            lineTop.hidden=true;
            lineBottom.hidden=false;
            break;
            
        case SEARCH_SHOP_CELL_MID:
            lineTop.hidden=false;
            lineBottom.hidden=false;
            break;
            
        case SEARCH_SHOP_CELL_LAST:
            lineTop.hidden=false;
            lineBottom.hidden=true;
            break;

    }
}

-(id)value
{
    if(_shop)
        return _shop;
    
    if(_placeauto)
        return _placeauto;
    
    if(_place)
        return _place;
    
    return nil;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"text"];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:13];
    style.color=[UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1];
    style.textAlignment=FTCoreTextAlignementLeft;
    
    [lbl addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"em"];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:13];
    style.color=[UIColor colorWithRed:0.357 green:0.357 blue:0.357 alpha:1];
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
    return 36;
}

@end
