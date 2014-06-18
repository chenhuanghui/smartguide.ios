//
//  ShopDetailInfoDetailCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType2Cell.h"

@implementation ShopDetailInfoType2Cell

-(void)loadWithInfo2:(Info2 *)info2
{
    _info=info2;
    lblLeft.text=info2.title;
    
    bool isURL=[info2.content containsString:@"http"];
    btnURL.userInteractionEnabled=isURL;
    
    btnURL.titleLabel.numberOfLines=0;
    
    if(isURL)
    {
        NSAttributedString *attStr=[[NSAttributedString alloc] initWithString:info2.content attributes:@{
                                                                                                         NSFontAttributeName:FONT_SIZE_NORMAL(12)
                                                                                                         , NSUnderlineStyleAttributeName:@(true)
                                                                                                         , NSForegroundColorAttributeName:[UIColor blueColor]}];
        [btnURL setAttributedTitle:attStr forState:UIControlStateNormal];
    }
    else
    {
        [btnURL setTitle:info2.content forState:UIControlStateNormal];
        [btnURL setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
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
        [[UIApplication sharedApplication] openURL:url];
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoType2Cell";
}

+(float)heightWithContent:(NSString *)content
{
    float height=0;
    height+=[content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:12] constrainedToSize:CGSizeMake(140, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    return height;
}

@end