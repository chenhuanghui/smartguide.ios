//
//  SUShopGalleryCell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUShopGalleryCell.h"
#import "ShopGalleryCell.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation SUShopGalleryCell
@synthesize delegate;

-(void)loadWithShop:(Shop *)shop
{
    _shop=shop;
    
    switch (shop.enumDataMode) {
        case SHOP_DATA_HOME_8:
        case SHOP_DATA_SHOP_LIST:
            
            lblShopName.text=shop.shopName;
            lblShopType.text=shop.shopTypeDisplay;
            lblNumOfComment.text=shop.numOfComment;
            lblNumOfView.text=shop.numOfView;
            
            [btnLove setLoveStatus:shop.enumLoveStatus withNumOfLove:shop.numOfLove animate:false];
            [imgvShopLogo loadShopLogoWithURL:shop.logo];
            
            [table reloadData];
            
            break;
            
        case SHOP_DATA_FULL:
            
            lblShopName.text=shop.shopName;
            lblShopType.text=shop.shopTypeDisplay;
            lblNumOfComment.text=shop.numOfComment;
            lblNumOfView.text=shop.numOfView;
            
            [btnLove setLoveStatus:shop.enumLoveStatus withNumOfLove:shop.numOfLove animate:false];
            [imgvShopLogo loadShopLogoWithURL:shop.logo];
            
            pageControl.numberOfPages=shop.shopGalleriesObjects.count;
            [table reloadData];
            
            break;
    }
}

+(NSString *)reuseIdentifier
{
    return @"SUShopGalleryCell";
}

+(float)height
{
    return 327;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==table)
    {
        [pageControl scrollViewDidScroll:scrollView isHorizontal:true];
    }
    else
    {
        if(CGRectIsEmpty(_tableFrame))
            _tableFrame=table.frame;
        
        [table l_v_setY:_tableFrame.origin.y+scrollView.contentOffset.y/2];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_shop.enumDataMode) {
        case SHOP_DATA_HOME_8:
        case SHOP_DATA_SHOP_LIST:
            return 1;
            
        case SHOP_DATA_FULL:
            return _shop.shopGalleriesObjects.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.l_v_w;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopGalleryCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopGalleryCell reuseIdentifier]];
    
    switch (_shop.enumDataMode) {
        case SHOP_DATA_HOME_8:
        case SHOP_DATA_SHOP_LIST:
            [cell loadImage:_shop.shopGalleryCover];
            break;
            
        case SHOP_DATA_FULL:
        {
            ShopGallery *gallery=_shop.shopGalleriesObjects[indexPath.row];
            
            [cell loadImage:gallery.cover];
        }
    }
    
    return cell;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    pageControl.dotColorCurrentPage=[UIColor whiteColor];
    pageControl.dotColorOtherPage=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    table.frame=rect;
    
    [table registerNib:[UINib nibWithNibName:[ShopGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopGalleryCell reuseIdentifier]];
    
    bgLineStatus.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_status.png"]];
    
    ButtonLove *love=[ButtonLove new];
    [love l_v_setO:CGPointMake(87, 288)];
    love.delegate=self;
    
    [self.contentView addSubview:love];
    
    btnLove=love;
}

-(void)buttonLoveTouched:(ButtonLove *)buttonLoveView
{
    if(_operationLoveShop)
        return;
 
    int idShop=_shop.idShop.integerValue;
    int willLove=_shop.enumLoveStatus==LOVE_STATUS_LOVED?false:true;
    
    if(willLove)
        [buttonLoveView love:true];
    else
        [buttonLoveView unlove:true];
    
    _operationLoveShop=[[ASIOperationLoveShop alloc] initWithIDShop:idShop userLat:userLat() userLng:userLng() isLove:willLove];
    _operationLoveShop.delegatePost=self;
    
    [_operationLoveShop startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationLoveShop class]])
    {
        ASIOperationLoveShop *ope=(ASIOperationLoveShop*) operation;
        
        [btnLove setLoveStatus:ope.loveStatus withNumOfLove:ope.numOfLove animate:true];
        
        _operationLoveShop=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationLoveShop class]])
    {
        _operationLoveShop=nil;
    }
}

-(void)dealloc
{
    if(_operationLoveShop)
    {
        [_operationLoveShop cancel];
        _operationLoveShop=nil;
    }
}

-(IBAction) btnInfoTouchUpInside:(id)sender
{
    [self.delegate suShopGalleryTouchedMoreInfo:self];
}

@end
