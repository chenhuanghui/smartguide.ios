//
//  ShopListPlaceCell.m
//  SmartGuide
//
//  Created by MacMini on 18/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopListPlaceCell.h"
#import "ImageManager.h"
#import "Placelist.h"
#import "UserHome3.h"

@implementation ShopListPlaceCell
@synthesize suggestHeight;

-(void)loadWithPlace:(Placelist *)place
{
    _obj=place;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    Placelist *place=_obj;
    
    lblTitle.text=place.title;
    lblContent.text=place.desc;
    [imgvAuthorAvatar loadCommentAvatarWithURL:place.authorAvatar size:CGSizeMake(40, 40)];
    lblNumOfView.text=[NSString stringWithFormat:@"%@ lượt xem", place.numOfView];
    
    NSMutableAttributedString *attStr=[NSMutableAttributedString new];
    
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"by " attributes:@{NSFontAttributeName:FONT_SIZE_ITALIC(12),NSForegroundColorAttributeName:[UIColor grayColor]}]];
    
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:place.authorName attributes:@{NSFontAttributeName:FONT_SIZE_BOLD(12),NSForegroundColorAttributeName:[UIColor redColor]}]];
    
    lblAuthorName.attributedText=attStr;
    
    lblContent.frame=CGRectMake(31, 29, 176, 0);
    [lblContent sizeToFit];
    [lblContent l_v_setW:176];
    
    lblAuthorName.frame=CGRectMake(215, 47, 105, 0);
    [lblAuthorName sizeToFit];
    [lblAuthorName l_v_setW:105];
    
    [lblNumOfView l_v_setY:lblAuthorName.l_v_y+lblAuthorName.l_v_h];
    
    suggestHeight=MAX(lblContent.l_v_y+lblContent.l_v_h,lblNumOfView.l_v_y+lblNumOfView.l_v_h);
    suggestHeight+=5;
    
    suggestHeight=MAX(90,suggestHeight);
}

+(NSString *)reuseIdentifier
{
    return @"ShopListPlaceCell";
}

+(float)titleHeight
{
    return 40;
}

@end

@implementation UITableView(ShopListPlaceCell)

-(void)registerShopListPlaceCell
{
    [self registerNib:[UINib nibWithNibName:[ShopListPlaceCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListPlaceCell reuseIdentifier]];
}

-(ShopListPlaceCell *)shopListPlaceCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopListPlaceCell reuseIdentifier]];
}

@end