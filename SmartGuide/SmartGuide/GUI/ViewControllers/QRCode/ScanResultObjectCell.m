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
@synthesize suggestHeight,isCalculatingSuggestHeight;

-(void)calculatingSuggestHeight
{
    isCalculatingSuggestHeight=true;
    [self layoutSubviews];
    isCalculatingSuggestHeight=false;
}

-(ScanCodeRelated *)obj
{
    return _related;
}

-(void) loadWithRelated:(ScanCodeRelated *)obj
{
    _related=obj;
    isCalculatingSuggestHeight=false;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (_related.enumType) {
        case SCANCODE_RELATED_TYPE_PLACELISTS:
            
            if(!isCalculatingSuggestHeight)
                [imgvLogo loadScanRelatedImageWithURL:_related.authorAvatar];
            
            lblTitle.text=_related.placelistName;
            lblContent.text=_related.desc;
            
            break;
            
        case SCANCODE_RELATED_TYPE_PROMOTIONS:
            
            if(!isCalculatingSuggestHeight)
                [imgvLogo loadScanRelatedImageWithURL:_related.logo];
            
            lblTitle.text=_related.promotionName;
            lblContent.text=_related.desc;
            
            break;
            
        case SCANCODE_RELATED_TYPE_SHOPS:
            
            if(!isCalculatingSuggestHeight)
                [imgvLogo loadScanRelatedImageWithURL:_related.logo];
            
            lblTitle.text=_related.shopName;
            lblContent.text=_related.desc;
            
            break;
            
        case SCANCODE_RELATED_TYPE_UNKNOW:
            suggestHeight=0;
            lblTitle.text=@"";
            lblContent.text=@"";
            imgvLogo.image=nil;
            return;
    }
    
    lblTitle.frame=CGRectMake(94, 18, 206, 0);
    [lblTitle sizeToFit];
    
    lblContent.frame=CGRectMake(94, lblTitle.l_v_y+lblTitle.l_v_h+5, 206, 0);
    [lblContent sizeToFit];
    
    suggestHeight=MAX(94,lblContent.l_v_y+lblContent.l_v_h+5);
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultObjectCell";
}

-(IBAction)btnTouchUpInside:(id)sender
{
    [self.delegate scanResultObjectCellTouched:self];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [imgvLogo.layer setBorderWidth:1];
    [imgvLogo.layer setBorderColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5f].CGColor];
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