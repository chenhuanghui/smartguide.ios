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

-(void) loadWithRelated:(ScanCodeRelated *)obj
{
    [imgvLogo loadScanRelatedImageWithURL:obj.authorAvatar];
    
    lblTitle.text=obj.placelistName;
    lblContent.text=obj.desc;
    
    [lblTitle l_v_setH:obj.placelistNameHeight.floatValue];
    [lblContent l_v_setY:lblTitle.l_v_x+lblTitle.l_v_h+5];
    [lblContent l_v_setH:obj.descHeight.floatValue];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultObjectCell";
}

+(float) heightWithRelated:(ScanCodeRelated*)obj
{
    float height=94;
    
    if(obj.placelistNameHeight.floatValue==-1)
        obj.placelistNameHeight=@([obj.placelistName sizeWithFont:FONT_SIZE_MEDIUM(13) constrainedToSize:CGSizeMake(206, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);
    
    if(obj.descHeight.floatValue==-1)
        obj.descHeight=@([obj.desc sizeWithFont:FONT_SIZE_REGULAR(13) constrainedToSize:CGSizeMake(206, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);
    
    if(obj.placelistNameHeight.floatValue+obj.descHeight.floatValue>94-20)
    {
        height+=(obj.placelistNameHeight.floatValue+obj.descHeight.floatValue)-(94-20);
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