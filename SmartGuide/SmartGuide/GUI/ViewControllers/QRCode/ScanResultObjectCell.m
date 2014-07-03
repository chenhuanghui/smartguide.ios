//
//  ScanResultObjectCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultObjectCell.h"
#import "ScanCodeRelated.h"
#import "ImageManager.h"

@implementation ScanResultObjectCell

-(ScanCodeRelated *)obj
{
    return _related;
}

-(void) loadWithRelated:(ScanCodeRelated *)obj
{
    _related=obj;
    
    switch (obj.enumType) {
        case SCANCODE_RELATED_TYPE_PLACELISTS:
            
            [imgvLogo loadScanRelatedImageWithURL:obj.authorAvatar];
            lblTitle.text=obj.placelistName;
            lblContent.text=obj.desc;
            [lblTitle l_v_setH:obj.placelistNameHeight.floatValue];
            
            break;
            
        case SCANCODE_RELATED_TYPE_PROMOTIONS:
            
            [imgvLogo loadScanRelatedImageWithURL:obj.logo];
            lblTitle.text=obj.promotionName;
            lblContent.text=obj.desc;
            [lblTitle l_v_setH:obj.promotioNameHeight.floatValue];
            
            break;
            
        case SCANCODE_RELATED_TYPE_SHOPS:
            
            [imgvLogo loadScanRelatedImageWithURL:obj.logo];
            lblTitle.text=obj.shopName;
            lblContent.text=obj.desc;
            [lblTitle l_v_setH:obj.shopNameHeight.floatValue];
            
            break;
            
        case SCANCODE_RELATED_TYPE_UNKNOW:
            break;
    }
    
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+5];
    [lblContent l_v_setH:obj.descHeight.floatValue];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultObjectCell";
}

+(float) heightWithRelated:(ScanCodeRelated*)obj
{
    float height=94;
    
    float titleHeight=0;
    float descHeight=0;
    switch (obj.enumType) {
        case SCANCODE_RELATED_TYPE_UNKNOW:
            return 0;
            
        case SCANCODE_RELATED_TYPE_SHOPS:
            
            if(obj.shopNameHeight.floatValue==-1)
            {
                obj.shopNameHeight=@([obj.shopName sizeWithFont:FONT_SIZE_MEDIUM(13) constrainedToSize:CGSizeMake(206, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);
            }
            
            titleHeight=obj.shopNameHeight.floatValue;
            
            break;
            
        case SCANCODE_RELATED_TYPE_PROMOTIONS:
            
            if(obj.promotioNameHeight.floatValue==-1)
            {
                obj.promotioNameHeight=@([obj.promotionName sizeWithFont:FONT_SIZE_MEDIUM(13) constrainedToSize:CGSizeMake(206, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);
            }
            
            titleHeight=obj.promotioNameHeight.floatValue;
            
            break;
            
        case SCANCODE_RELATED_TYPE_PLACELISTS:
            
            if(obj.placelistNameHeight.floatValue==-1)
            {
                obj.placelistNameHeight=@([obj.placelistName sizeWithFont:FONT_SIZE_MEDIUM(13) constrainedToSize:CGSizeMake(206, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);
            }
            
            titleHeight=obj.placelistNameHeight.floatValue;
            
            break;
    }
    
    if(obj.descHeight.floatValue==-1)
        obj.descHeight=@([obj.desc sizeWithFont:FONT_SIZE_REGULAR(13) constrainedToSize:CGSizeMake(206, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);
    
    descHeight=obj.descHeight.floatValue;
    
    if(titleHeight+descHeight>94-20)
    {
        height+=(titleHeight+descHeight)-(94-20);
    }
    
    return MAX(94, height);
}

@end

@implementation UITableView(ScanResultObjectCell)

-(void)registerScanResultObjectCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultObjectCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultObjectCell reuseIdentifier]];
}

-(ScanResultObjectCell *)scanResultObjectCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultObjectCell reuseIdentifier]];
}

@end