//
//  SUUserGalleryCell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUUserGalleryCell.h"
#import "Utility.h"
#import "ShopUserGalleryCell.h"

@implementation SUUserGalleryCell
@synthesize delegate;

-(void)loadWithShop:(Shop *)shop
{
    imgvFirsttime.hidden=shop.userGalleriesObjects.count>0;
    
    [table reloadData];
}

+(NSString *)reuseIdentifier
{
    return @"SUUserGalleryCell";
}

+(float)height
{
    return 182;
}

-(IBAction) btnMakePictureTouchUpInside:(id)sender
{
    [self.delegate userGalleryTouchedMakePicture:self];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    table.frame=rect;
    
    [table registerNib:[UINib nibWithNibName:[ShopUserGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopUserGalleryCell reuseIdentifier]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _shop.userGalleriesObjects.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shop.userGalleriesObjects.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return table.l_v_w;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopUserGalleryCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopUserGalleryCell reuseIdentifier]];
    [cell loadWithURL:[_shop.userGalleriesObjects[indexPath.row] thumbnail]];
    
    return cell;
}

@end