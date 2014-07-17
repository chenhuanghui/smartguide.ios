//
//  ShopDetailInfoDetailCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType2Cell.h"
#import "GUIManager.h"

@implementation ShopDetailInfoType2Cell

-(void)loadWithInfo2:(Info2 *)info2
{
    _info=info2;
    lblLeft.text=info2.title;

    switch (info2.contentType) {
        case INFO2_CONTENT_TYPE_TEXT:
            [btnURL setTitle:info2.content forState:UIControlStateNormal];
            [btnURL setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btnURL setImage:nil forState:UIControlStateNormal];
            btnURL.userInteractionEnabled=false;
            btnURL.titleLabel.numberOfLines=0;
            break;
            
        case INFO2_CONTENT_TYPE_URL:
        case INFO2_CONTENT_TYPE_URL_FACEBOOK:
            btnURL.titleLabel.numberOfLines=1;
            btnURL.userInteractionEnabled=true;
            
            UIImage *img=[UIImage imageNamed:@"golink.png"];
            
            if(info2.contentType==INFO2_CONTENT_TYPE_URL_FACEBOOK)
                img=[UIImage imageNamed:@"gofacebook.png"];
            
            [btnURL setTitle:@"" forState:UIControlStateNormal];
            [btnURL setImage:img forState:UIControlStateNormal];
            
            break;
    }
}

-(void)setCellPos:(enum CELL_POSITION)cellPos
{
    switch (cellPos) {
        case CELL_POSITION_BOTTOM:
            line.hidden=true;
            break;
            
        case CELL_POSITION_MIDDLE:
        case CELL_POSITION_TOP:
            line.hidden=false;
            break;
    }
}

- (IBAction)btnURLTouchUpInside:(id)sender {
    NSURL *url=URL(_info.content);
    
    if(url)
    {
        [self.delegate shopDetailInfoType2TouchedURL:self url:url];
    }
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoType2Cell";
}

+(float)heightWithInfo2:(Info2 *)info2
{
    return 59-22;
    float height=0;
    
    switch (info2.contentType) {
        case INFO2_CONTENT_TYPE_TEXT:
            if(info2.contentHeight.floatValue==-1)
                info2.contentHeight=@([info2.content sizeWithFont:FONT_SIZE_NORMAL(12) constrainedToSize:CGSizeMake(137, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);
            break;
            
        case INFO2_CONTENT_TYPE_URL:
        case INFO2_CONTENT_TYPE_URL_FACEBOOK:
            if(info2.contentHeight.floatValue==-1)
                info2.contentHeight=@(30);
            break;
    }

    height+=info2.contentHeight.floatValue;
    
    return MAX(37, height);
}

@end