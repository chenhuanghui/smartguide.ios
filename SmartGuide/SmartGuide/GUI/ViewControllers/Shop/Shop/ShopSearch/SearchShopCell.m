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
    
    if(shop.hasPromotion)
        [icon setImage:[UIImage imageNamed:@"icon_promotion_search.png"]];
    else
        [icon setImage:[UIImage imageNamed:@"icon_keyword_search.png"]];
}

-(void)loadWithPlace:(Placelist *)place
{
    _place=place;
    _shop=nil;
    _placeauto=nil;
    
    [lbl setText:[place.title stringByAppendingTagName:@"text"]];
    [icon setImage:[UIImage imageNamed:@"icon_playlist_search.png"]];
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
    
    [icon setImage:[UIImage imageNamed:@"icon_playlist_search.png"]];
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
    style.color=[UIColor color255WithRed:135 green:135 blue:135 alpha:255];
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

+(float)heightWithContent:(NSString *)content
{
    float height=36;
    
    height+=MAX(0,[content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(255, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-25);
    
    return height;
}

+(float)heightWithDataAutocompletePlace:(AutocompletePlacelist *)place
{
    return [SearchShopCell heightWithContent:place.content];
}

+(float)heightWithDataAutocompleteShop:(AutocompleteShop *)shop
{
    return [SearchShopCell heightWithContent:shop.content];
}

+(float)heightWithPlace:(Placelist *)place
{
    return [SearchShopCell heightWithContent:place.title];
}

@end
