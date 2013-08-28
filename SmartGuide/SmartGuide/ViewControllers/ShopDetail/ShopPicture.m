//
//  ShopPicture.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopPicture.h"
#import "ShopPictureCell.h"
#import "ShopGallery.h"
#import "ShopUserGallery.h"
#import "RootViewController.h"

@implementation ShopPicture
@synthesize isProcessedData,handler;

-(ShopPicture *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ShopPicture" owner:nil options:nil] objectAtIndex:0];
    
    [self setShop:shop];
    
    gridShop.itemSpacing=8;
    gridShop.centerGrid=false;
    gridShop.style=GMGridViewStylePush;
    gridShop.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontal];
    gridShop.layer.masksToBounds=true;
    gridShop.minEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 5);
    
    gridUser.itemSpacing=8;
    gridUser.centerGrid=false;
    gridUser.style=GMGridViewStylePush;
    gridUser.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontal];
    gridUser.layer.masksToBounds=true;
    gridUser.minEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 5);
    
    templateShop=[[GridViewTemplate alloc] initWithGridView:gridShop delegate:self];
    templateUser=[[GridViewTemplate alloc] initWithGridView:gridUser delegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userPosed:) name:NOTIFICATION_USER_POST_PICTURE object:nil];
    
    return self;
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return -1;
}

-(bool)gridViewTemplateAllowLoadMore:(GMGridView *)gridView
{
    return gridView==gridUser;
}

-(void)gridViewTemplateLoadNext:(GMGridView *)gridView needWait:(bool *)isWait
{
    *isWait=true;
    
    [self loadUserGalleryAtPage:templateUser.page+1];
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    if(gridView==gridUser)
    {
        GMGridViewCell *cell=[gridView dequeueReusableCellWithIdentifier:[ShopPictureCell reuseIdentifier]];
        
        if(!cell)
        {
            cell=[[GMGridViewCell alloc] init];
            cell.reuseIdentifier=[ShopPictureCell reuseIdentifier];
            cell.contentView=[[ShopPictureCell alloc] init];
        }
        
        ShopPictureCell *picture=(ShopPictureCell*)cell.contentView;
        ShopUserGallery *ug=[templateUser.datasource objectAtIndex:index];
        
        if(ug.imagePosed)
            [picture setImage:ug.imagePosed duration:0.5f];
        else
            [picture setURLString:ug.image duration:0.5f];
        
        return cell;
    }
    else if(gridView==gridShop)
    {
        GMGridViewCell *cell=[gridView dequeueReusableCellWithIdentifier:[ShopPictureCell reuseIdentifier]];
        
        if(!cell)
        {
            cell=[[GMGridViewCell alloc] init];
            cell.reuseIdentifier=[ShopPictureCell reuseIdentifier];
            cell.contentView=[[ShopPictureCell alloc] init];
        }
        
        ShopPictureCell *picture=(ShopPictureCell*)cell.contentView;
        ShopGallery *sg=[templateShop.datasource objectAtIndex:index];

        [picture setURLString:sg.image duration:0.5f];
        
        return cell;
    }
    else
    {
        GMGridViewCell *cell=[galleryView GMGridView:gridView cellForItemAtIndex:index];
        GalleryCell *gallery=(GalleryCell*)cell.contentView;
        
        if(!_isUserViewShopGallery)
        {
            ShopUserGallery *ug=[templateUser.datasource objectAtIndex:index];
            
            if(ug.imagePosed)
                [gallery setIMG:ug.imagePosed];
            else
                [gallery setImageURL:[NSURL URLWithString:ug.image]];
        }
        else
        {
            ShopGallery *sg=[templateShop.datasource objectAtIndex:index];
            
            [gallery setImageURL:[NSURL URLWithString:sg.image]];
        }
        
        return cell;
    }
}

-(void) userPosed:(NSNotification*) notification
{
    if(_isTemporaryUserGallery)
    {
        templateUser.datasource=[[NSMutableArray alloc] init];
        _isTemporaryUserGallery=false;
    }
    
    if(templateUser.datasource.count>0)
    {
        [templateUser.datasource insertObject:notification.object atIndex:0];
    }
    else
        [templateUser.datasource addObject:notification.object];
    
    [gridUser reloadData];
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if(gridView==gridUser || gridView==gridShop)
        return [ShopPictureCell size];
    
    return [galleryView GMGridView:gridShop sizeForItemsInInterfaceOrientation:orientation];
}

-(void)setShop:(Shop *)shop
{
    _shop=shop;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if(!newSuperview)
        return;
    
    if(isProcessedData)
    {
        [gridUser reloadData];
        [gridShop reloadData];
    }
    else
    {
        [self showLoadingWithTitle:nil];
    }
}

-(void)processFirstDataBackground:(NSMutableArray *)firstData
{
    templateUser.page=0;
    
    templateShop.datasource=[[NSMutableArray alloc] initWithArray:[firstData objectAtIndex:0]];
    templateUser.datasource=[[NSMutableArray alloc] initWithArray:[firstData objectAtIndex:1]];
    
    _isTemporaryUserGallery=false;
    if(templateUser.datasource.count==0)
    {
        [templateUser.datasource addObjectsFromArray:@[[ShopUserGallery temporary],[ShopUserGallery temporary],[ShopUserGallery temporary]]];
        _isTemporaryUserGallery=true;
    }
    
    _isTemporaryShopGallery=false;
    if(templateShop)
    {
        [templateShop.datasource addObjectsFromArray:@[[ShopGallery temporary],[ShopGallery temporary],[ShopGallery temporary]]];
        _isTemporaryShopGallery=true;
    }
    
    templateUser.isAllowLoadMore=templateUser.datasource.count==10;
    
    [gridShop reloadData];
    [gridUser reloadData];
    
    [self removeLoading];
    
    isProcessedData=true;
}

-(void) loadUserGalleryAtPage:(int) page
{
    if(_operationUserGallery)
        _operationUserGallery=nil;
    
    _operationUserGallery=[[ASIOperationShopUserGallery alloc] initWithIDShop:_shop.idShop.integerValue page:page];
    _operationUserGallery.delegatePost=self;
    [_operationUserGallery startAsynchronous];
}

-(void)reset
{
    _shop=nil;

    [templateUser reset];
    [templateShop reset];
    
    [gridShop setContentOffset:CGPointZero];
    [gridUser setContentOffset:CGPointZero];
    
    if(_operationUserGallery)
    {
        [_operationUserGallery cancel];
        _operationUserGallery=nil;
    }
}

-(void)cancel
{
    if(_operationUserGallery)
    {
        [_operationUserGallery cancel];
        _operationUserGallery=nil;
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    isProcessedData=true;
    
    if([operation isKindOfClass:[ASIOperationShopUserGallery class]])
    {
        ASIOperationShopUserGallery *operationUG=(ASIOperationShopUserGallery*)operation;
        
        if(operationUG.userGallerys.count>0)
        {
            templateUser.page++;
            [templateUser.datasource addObjectsFromArray:operationUG.userGallerys];
        }
        
        templateUser.isAllowLoadMore=operationUG.userGallerys.count==10;
        [templateUser endLoadNext];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    isProcessedData=true;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    GMGridViewCell *cell=[gridView cellForItemAtIndex:position];
    
    if(gridView==gridUser)
    {
        ShopPictureCell *picture=(ShopPictureCell*)cell.contentView;
        
        if(!picture.userImage)
            return;
        
        _isUserViewShopGallery=false;
        _rootView=[[RootViewController shareInstance] giveARootView];
        _rootView.backgroundColor=[UIColor clearColor];
        
        galleryView=[[GalleryView alloc] init];
        galleryView.selectedIndex=position;
        galleryView.delegate=self;
        
        templateUser.gView=galleryView.gridView;
        
        [_rootView addSubview:galleryView];
        
        CGRect rect=cell.frame;
        rect.origin.x+=2;
        rect.origin.y+=2;
        
        rect=[gridView convertRect:rect toView:self];
        rect=[self convertRect:rect toView:galleryView];
        
        [galleryView animationImage:picture.userImage startRect:rect];
    }
    else if(gridView==gridShop)
    {
        ShopPictureCell *picture=(ShopPictureCell*)cell.contentView;
        
        if(!picture.userImage)
            return;
        
        _isUserViewShopGallery=true;
        _rootView=[[RootViewController shareInstance] giveARootView];
        _rootView.backgroundColor=[UIColor clearColor];
        
        galleryView=[[GalleryView alloc] init];
        galleryView.selectedIndex=position;
        galleryView.delegate=self;
        
        templateShop.gView=galleryView.gridView;
        
        [_rootView addSubview:galleryView];
        
        CGRect rect=cell.frame;
        rect.origin.x+=2;
        rect.origin.y+=2;
        
        rect=[gridView convertRect:rect toView:self];
        rect=[self convertRect:rect toView:galleryView];
        
        [galleryView animationImage:picture.userImage startRect:rect];
    }
}

-(void)galleryViewBack:(GalleryView *)_galleryView
{
    templateUser.gView=gridUser;
    templateShop.gView=gridShop;
    
    [gridUser scrollToObjectAtIndex:templateUser.selectedIndex atScrollPosition:GMGridViewScrollPositionNone animated:false];
    [gridShop scrollToObjectAtIndex:templateShop.selectedIndex atScrollPosition:GMGridViewScrollPositionNone animated:false];
    
    [galleryView removeFromSuperview];
    [[RootViewController shareInstance] removeRootView:_rootView];
    _rootView=nil;
    galleryView=nil;
}

-(CGRect)galleryViewFrameForAnimationHide:(GalleryView *)_galleryView index:(int)index
{
    if(_isUserViewShopGallery)
    {
        templateShop.selectedIndex=index;
        
        CGRect rect=[gridShop cellForItemAtIndex:index].frame;
        rect=[gridShop convertRect:rect toView:self];
        rect=[self convertRect:rect toView:galleryView];
        
        return rect;
    }
    else
    {
        templateUser.selectedIndex=index;
        
        CGRect rect=[gridUser cellForItemAtIndex:index].frame;
        rect=[gridUser convertRect:rect toView:self];
        rect=[self convertRect:rect toView:galleryView];
        
        return rect;
    }
}

-(bool)galleryViewAllowDescription:(GalleryView *)galleryView
{
    return !_isUserViewShopGallery;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(galleryView)
    {
        [galleryView scrollViewDidEndDecelerating:scrollView];
    }
}

@end