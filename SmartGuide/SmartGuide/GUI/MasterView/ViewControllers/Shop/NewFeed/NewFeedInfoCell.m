//
//  NewFeedInfoCell.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedInfoCell.h"
#import "ImageManager.h"

@implementation NewFeedInfoCell
@synthesize delegate;

-(void)loadWithHome6:(UserHome6 *)home
{
    _home6=home;
    _home7=nil;
    
    [imgvLogo loadImageHomeWithURL:home.logo];
    lblName.text=home.shopName;
    lblDate.text=home.date;
    [imgvCover loadImageHomeWithURL:home.cover];
    lblTitle.text=home.title;
    lblContent.text=home.content;
    
    [btnGoTo setTitle:@"GO" forState:UIControlStateNormal];
    
    if(home.gotoshop.length>0)
        [btnGoTo setTitle:home.gotoshop forState:UIControlStateNormal];
}

-(void)loadWithHome7:(UserHome7 *)home
{
    _home6=nil;
    _home7=home;
    
    [imgvLogo loadImageHomeWithURL:home.logo];
    lblName.text=home.storeName;
    lblDate.text=home.date;
    [imgvCover loadImageHomeWithURL:home.cover];
    lblTitle.text=home.title;
    lblContent.text=home.content;
    
    [btnGoTo setTitle:@"GO" forState:UIControlStateNormal];
    
    if(home.gotostore.length>0)
        [btnGoTo setTitle:home.gotostore forState:UIControlStateNormal];
}

+(float)heightWithHome6:(UserHome6 *)home
{
    float height=222;
    height+=[home.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(257, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-10;
    
    return height;
}

+(float)heightWithHome7:(UserHome7 *)home
{
    float height=222;
    height+=[home.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(257, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-10;
    
    return height;
}

+(NSString *)reuseIdentifier
{
    return @"NewFeedInfoCell";
}

- (IBAction)btnGoToTouchUpInside:(id)sender {
    [self.delegate newFeedInfoCellTouchedGoTo:_home6?_home6:_home7];
}

@end
