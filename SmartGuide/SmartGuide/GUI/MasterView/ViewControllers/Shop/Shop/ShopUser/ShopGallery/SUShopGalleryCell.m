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
#import "GUIManager.h"
#import "LoadingMoreCellHori.h"

@implementation SUShopGalleryCell
@synthesize delegate;

-(void)loadWithShop:(Shop *)shop
{
    _shop=shop;
    
    _canLoadMore=shop.shopGalleriesObjects.count>0 && shop.shopGalleriesObjects.count%10==0;
    _isLoadingMore=false;
    _page=MAX(0,shop.shopGalleriesObjects.count/10-1);
    
    switch (shop.enumDataMode) {
            
        case SHOP_DATA_IDSHOP:
            
            break;
            
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

-(void) requestShopGallery
{
    if(_operationShopGallery)
    {
        [_operationShopGallery clearDelegatesAndCancel];
        _operationShopGallery=nil;
    }
    
    _operationShopGallery=[[ASIOperationShopGallery alloc] initWithWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() page:_page+1];
    _operationShopGallery.delegatePost=self;
    
    [_operationShopGallery startAsynchronous];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==table)
    {
        [pageControl scrollViewDidScroll:scrollView isHorizontal:true];
        
        for(ShopGalleryCell *cell in table.visibleCells)
        {
            if([cell isKindOfClass:[ShopGalleryCell class]])
                [cell tableViewDidScroll];
        }
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
    return _shop.shopGalleriesObjects.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_shop.enumDataMode) {
        case SHOP_DATA_HOME_8:
        case SHOP_DATA_SHOP_LIST:
            
            return 1;
            
        case SHOP_DATA_FULL:
            return _shop.shopGalleriesObjects.count+(_canLoadMore?1:0);
            
        case SHOP_DATA_IDSHOP:
            return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.l_v_w;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_canLoadMore && indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
    {
        if(!_isLoadingMore)
        {
            _isLoadingMore=true;
            
            [self requestShopGallery];
        }
        
        return [tableView loadingMoreCellHori];
    }
    
    ShopGalleryCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopGalleryCell reuseIdentifier]];
    
    cell.table=tableView;
    cell.indexPath=indexPath;
    
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
            break;
            
        case SHOP_DATA_IDSHOP:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate suShopGalleryTouchedCover:self object:_shop.shopGalleriesObjects[indexPath.row]];
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
    [table registerLoadingMoreCellHori];
    
    ButtonLove *love=[ButtonLove new];
    [love l_v_setO:CGPointMake(87, 288)];
    love.delegate=self;
    
    [self.contentView addSubview:love];
    
    btnLove=love;
}

-(void) love
{
    if(_operationLoveShop)
    {
        [_operationLoveShop clearDelegatesAndCancel];
        _operationLoveShop=nil;
    }
    
    switch (_shop.enumLoveStatus) {
        case LOVE_STATUS_LOVED:
            _shop.loveStatus=@(LOVE_STATUS_NONE);
            _shop.totalLove=MAX(@(0),@(_shop.totalLove.integerValue-1));
            _shop.numOfLove=[NSNumberFormatter numberFromNSNumber:_shop.totalLove];
            break;
            
        case LOVE_STATUS_NONE:
            _shop.loveStatus=@(LOVE_STATUS_LOVED);
            _shop.totalLove=@(_shop.totalLove.integerValue+1);
            _shop.numOfLove=[NSNumberFormatter numberFromNSNumber:_shop.totalLove];
            break;
    }
    
    [btnLove setLoveStatus:_shop.enumLoveStatus withNumOfLove:_shop.numOfLove animate:true];
    
    _operationLoveShop=[[ASIOperationLoveShop alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() loveStatus:_shop.enumLoveStatus];
    _operationLoveShop.delegatePost=self;
    _operationLoveShop.fScreen=SCREEN_CODE_SHOP_USER;
    [_operationLoveShop startAsynchronous];
}

-(void)buttonLoveTouched:(ButtonLove *)buttonLoveView
{
    if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^
        {
            [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_LOVE_SHOP;
            [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
        } onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self love];
        }];
        
        return;
    }
    else if(currentUser().enumDataMode==USER_DATA_CREATING)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeUserProfileRequire() onOK:^
        {
            [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_LOVE_SHOP;
            [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
        } onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self love];
        }];
        
        return;
    }
    
    [self love];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationLoveShop class]])
    {
        ASIOperationLoveShop *ope=(ASIOperationLoveShop*) operation;
        
        [btnLove setLoveStatus:ope.loveStatus withNumOfLove:ope.numOfLove animate:true];
        
        _operationLoveShop=nil;
    }
    else if([operation isKindOfClass:[ASIOperationShopGallery class]])
    {
        ASIOperationShopGallery *ope=(ASIOperationShopGallery*) operation;
        _canLoadMore=ope.galleries.count==10;
        _isLoadingMore=false;
        _page++;
        
        [table reloadData];
        [self scrollViewDidScroll:table];
        
        _operationShopGallery=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationLoveShop class]])
    {
        _operationLoveShop=nil;
    }
    else if([operation isKindOfClass:[ASIOperationShopGallery class]])
    {
        _operationShopGallery=nil;
    }
}

-(void)dealloc
{
    if(_operationLoveShop)
    {
        [_operationLoveShop clearDelegatesAndCancel];
        _operationLoveShop=nil;
    }
    
    if(_operationShopGallery)
    {
        [_operationShopGallery clearDelegatesAndCancel];
        _operationShopGallery=nil;
    }
}

-(IBAction) btnInfoTouchUpInside:(id)sender
{
    [self.delegate suShopGalleryTouchedMoreInfo:self];
}

-(void)reloadImage
{
    [table reloadData];
    [self scrollViewDidScroll:table];
}

@end

@implementation BGShopGalleryView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentMode=UIViewContentModeRedraw;
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"background_status.png"] drawAsPatternInRect:rect];
}

@end