//
//  SearchShopPlacelistCell.m
//  SmartGuide
//
//  Created by MacMini on 10/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SearchShopPlacelistCell.h"
#import "ImageManager.h"
#import "Utility.h"

@implementation SearchShopPlacelistCell

-(Placelist *)place
{
    return _place;
}

-(void)loadWithPlace:(Placelist *)place
{
    _place=place;
    
    if(place.image.length==0)
        icon.image=[UIImage imageNamed:@"icon_placelist_search.png"];
    else
        [icon loadPlaceAuthorAvatarWithURL:place.image];
    
    lblTitle.text=place.title;
    
    [lblContent l_v_setY:30+place.titleHeight];
    lblContent.text=place.desc;
}

-(void)setIsLastCell:(bool)isLastCell
{
    line.hidden=isLastCell;
}

+(float)heightWithPlace:(Placelist *)place
{
    float height=83;
    
    place.titleHeight=[place.title sizeWithFont:[UIFont fontWithName:@"Avenir-Medium" size:13] constrainedToSize:CGSizeMake(230, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-18;
    place.titleHeight=MAX(0,place.titleHeight);
    height+=place.titleHeight;
    
    place.contentHeight=[place.desc sizeWithFont:[UIFont fontWithName:@"Avenir-Light" size:11] constrainedToSize:CGSizeMake(230, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-55;
    place.contentHeight=MAX(0,place.contentHeight);
    height+=place.contentHeight;
    
    return height;
}

+(NSString *)reuseIdentifier
{
    return @"SearchShopPlacelistCell";
}

@end
