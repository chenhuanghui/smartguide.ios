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
    
    templateShopGallery=[[TemplateShopGallery alloc] initWithTableView:tableShopGallery withDelegate:self];
    templateUserGallery=[[TemplateUserGallery alloc] initWithTableView:tableUserGallery withDelegate:self];
    
    templateShopGallery.isHoriTable=true;
    templateUserGallery.isHoriTable=true;
    
    [tableUserGallery registerNib:[UINib nibWithNibName:[ShopPictureCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopPictureCell reuseIdentifier]];
    [tableShopGallery registerNib:[UINib nibWithNibName:[ShopPictureCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopPictureCell reuseIdentifier]];
    
    CGRect rect=tableShopGallery.frame;
    tableShopGallery.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*6));
    tableShopGallery.frame=rect;
    
    rect=tableUserGallery.frame;
    tableUserGallery.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*6));
    tableUserGallery.frame=rect;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userPosed:) name:NOTIFICATION_USER_POST_PICTURE object:nil];
    
    return self;
}

-(bool)tableTemplateAllowAutoScrollFullCell:(TableTemplate *)tableTemplate
{
    return true;
}

-(void) userPosed:(NSNotification*) notification
{
    if(_isTemporaryUserGallery)
    {
        templateUserGallery.datasource=[NSMutableArray array];
        _isTemporaryUserGallery=false;
    }
    
    if(templateUserGallery.datasource.count>0)
    {
        [templateUserGallery.datasource insertObject:notification.object atIndex:0];
    }
    else
        [templateUserGallery.datasource addObject:notification.object];
    
    [tableUserGallery reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tableShopGallery)
        return templateShopGallery.datasource.count;
    else if(tableView==tableUserGallery)
        return templateUserGallery.datasource.count;
    
    if(_isUserViewShopGallery)
        return templateShopGallery.datasource.count;
    else
        return templateUserGallery.datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableShopGallery)
    {
        ShopPictureCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopPictureCell reuseIdentifier]];
        ShopGallery *sg=[templateShopGallery.datasource objectAtIndex:indexPath.row];
        [cell setURLString:sg.image duration:0.5f];
        
        return cell;
    }
    else if(tableView==tableUserGallery)
    {
        ShopPictureCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopPictureCell reuseIdentifier]];
        ShopUserGallery *sug=[templateUserGallery.datasource objectAtIndex:indexPath.row];
        
        if(sug.imagePosed)
            [cell setImage:sug.imagePosed duration:0.5f];
        else
            [cell setURLString:sug.image duration:0.5f];
        
        return cell;
    }
    
    
    GalleryCell *cell=(GalleryCell*)[galleryView tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if(_isUserViewShopGallery)
    {
        ShopGallery *sg=[templateShopGallery.datasource objectAtIndex:indexPath.row];
        [cell setImageURL:[NSURL URLWithString:sg.image]];
    }
    else
    {
        ShopUserGallery *sug=[templateUserGallery.datasource objectAtIndex:indexPath.row];
        if(sug.imagePosed)
            [cell setIMG:sug.imagePosed];
        else
            [cell setImageURL:[NSURL URLWithString:sug.image]];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableUserGallery || tableView == tableShopGallery)
        return [ShopPictureCell size].height+8;

    return [galleryView tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(bool)tableTemplateAllowLoadMore:(TableTemplate *)tableTemplate
{
    return [tableTemplate isKindOfClass:[TemplateUserGallery class]];
}

-(void)tableTemplateLoadNext:(TableTemplate *)tableTemplate wait:(bool *)isWait
{
    [self loadUserGalleryAtPage:tableTemplate.page+1];
    *isWait=true;
}

-(void)setShop:(Shop *)shop
{
    _shop=shop;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if(isProcessedData)
    {
        [tableUserGallery reloadData];
        [tableShopGallery reloadData];
    }
}

-(UITableView *)tableShopGallery
{
    return tableShopGallery;
}

-(UITableView *)tableUserGallery
{
    return tableUserGallery;
}

-(void)processFirstDataBackground:(NSMutableArray *)firstData
{
    templateUserGallery.page=0;
    
    templateShopGallery.datasource=[[NSMutableArray alloc] initWithArray:[firstData objectAtIndex:0]];
    templateUserGallery.datasource=[[NSMutableArray alloc] initWithArray:[firstData objectAtIndex:1]];
    
    _isTemporaryUserGallery=false;
    if(templateUserGallery.datasource.count==0)
    {
        [templateUserGallery.datasource addObjectsFromArray:@[[ShopUserGallery temporary],[ShopUserGallery temporary],[ShopUserGallery temporary]]];
        _isTemporaryUserGallery=true;
    }
    
    _isTemporaryShopGallery=false;
    if(templateShopGallery)
    {
        [templateShopGallery.datasource addObjectsFromArray:@[[ShopGallery temporary],[ShopGallery temporary],[ShopGallery temporary]]];
        _isTemporaryShopGallery=true;
    }
    
    [templateUserGallery setAllowLoadMore:templateUserGallery.datasource.count==10];
    
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
    
    templateUserGallery.page=0;
    templateShopGallery.datasource=[NSMutableArray array];
    templateUserGallery.datasource=[NSMutableArray array];
    
    [tableShopGallery reloadData];
    [tableUserGallery reloadData];

    if(_operationUserGallery)
    {
        [_operationUserGallery cancel];
        _operationUserGallery=nil;
    }
}

-(void)cancel
{
//    if(_operationShopGallery)
//        [_operationShopGallery cancel];
    
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
        [tableUserGallery removeLoading];
        
        ASIOperationShopUserGallery *operationUG=(ASIOperationShopUserGallery*)operation;
        
        if(operationUG.userGallerys.count>0)
        {
            templateUserGallery.page++;
            
            [templateUserGallery.datasource addObjectsFromArray:operationUG.userGallerys];
        }
        
        [templateUserGallery setAllowLoadMore:operationUG.userGallerys.count==10];
        [templateUserGallery endLoadNext];
    }
    if([operation isKindOfClass:[ASIOperationShopGallery class]])
    {
        [tableShopGallery removeLoading];
        
        ASIOperationShopGallery *operationSG=(ASIOperationShopGallery*)operation;
        
        if(operationSG.shopGalleries.count>0)
        {
            [templateShopGallery.datasource addObjectsFromArray:operationSG.shopGalleries];
        }
        
        [templateShopGallery endLoadNext];
        
//        if(galleryView)
//        {
//            [galleryView.tablePicture reloadData];
//        }
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    isProcessedData=true;
    
    if([operation isKindOfClass:[ASIOperationShopGallery class]])
        [tableShopGallery removeLoading];
    else
        [tableUserGallery removeLoading];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableUserGallery)
    {
        ShopPictureCell *cell=(ShopPictureCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        if(![cell userImage])
            return;
        
        _isUserViewShopGallery=false;
        _rootView=[[RootViewController shareInstance] giveARootView];
        _rootView.backgroundColor=[UIColor clearColor];
        
        galleryView=[[GalleryView alloc] init];
        galleryView.delegate=self;
        [templateUserGallery setTableView:galleryView.table];
        [_rootView addSubview:galleryView];
        
        CGRect rect=[tableView rectForRowAtIndexPath:indexPath];
        rect.size=[ShopPictureCell size];
        rect.origin=[tableView convertPoint:rect.origin fromView:cell];
        rect.origin=[self convertPoint:rect.origin fromView:tableView];
        rect.origin=[self convertPoint:rect.origin toView:galleryView];
//        rect.origin.x+=18;
        //rect.origin=[galleryView convertPoint:rect.origin toView:galleryView]; uncomment để lấy vị trí y
        rect.origin.y=344-20;
        [galleryView animationImage:cell.userImage startRect:rect];
        [galleryView.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:false];
    }
    else if(tableView==tableShopGallery)
    {
        ShopPictureCell *cell=(ShopPictureCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        if(![cell userImage])
            return;
        
        _isUserViewShopGallery=true;
        _rootView=[[RootViewController shareInstance] giveARootView];
        _rootView.backgroundColor=[UIColor clearColor];

        galleryView=[[GalleryView alloc] init];
        galleryView.delegate=self;
        [templateShopGallery setTableView:galleryView.table];
        [_rootView addSubview:galleryView];
        
        CGRect rect=[tableView rectForRowAtIndexPath:indexPath];
        rect.size=[ShopPictureCell size];
        rect.origin=[tableView convertPoint:rect.origin fromView:cell];
        rect.origin=[self convertPoint:rect.origin fromView:tableView];
        rect.origin=[self convertPoint:rect.origin toView:galleryView];
//        rect.origin.x+=18;
        //rect.origin=[galleryView convertPoint:rect.origin toView:galleryView]; uncomment để lấy vị trí y
        rect.origin.y=232-20;
        [galleryView animationImage:cell.userImage startRect:rect];
        [galleryView.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:false];
    }
}

-(void)galleryViewBack:(GalleryView *)_galleryView
{
    [galleryView removeFromSuperview];
    [[RootViewController shareInstance] removeRootView:_rootView];
    _rootView=nil;
    galleryView=nil;
    
    if(_isUserViewShopGallery)
        [templateShopGallery setTableView:tableShopGallery];
    else
        [templateUserGallery setTableView:tableUserGallery];
}

-(CGRect)galleryViewFrameForAnimationHide:(GalleryView *)_galleryView indexPath:(NSIndexPath *)indexPath
{
    if(_isUserViewShopGallery)
        return [self scrollTableShopGalleryToIndexPathAndGiveBackRect:_galleryView indexPath:indexPath];
    else
        return [self scrollTableUserGalleryToIndexPathAndGiveBackRect:_galleryView indexPath:indexPath];
}

int iii;
-(NSString *)galleryViewDescriptionImage:(int)index
{
    if(!_isUserViewShopGallery)
    {
        ShopUserGallery *ug=[templateUserGallery.datasource objectAtIndex:index];
        
        return [NSString stringWithFormat:@"%@ %i",ug.desc,iii++];
    }
    
    return @"";
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

-(CGRect)scrollTableShopGalleryToIndexPathAndGiveBackRect:(GalleryView*) gl indexPath:(NSIndexPath *)indexPath
{
    [templateShopGallery setTableView:tableShopGallery];
    [tableShopGallery scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:false];
    
    CGRect rect=[tableShopGallery rectForRowAtIndexPath:indexPath];
    
    rect.size=[ShopPictureCell size];
    rect.origin=[tableShopGallery convertPoint:rect.origin fromView:[tableShopGallery cellForRowAtIndexPath:indexPath]];
    rect.origin=[self convertPoint:rect.origin fromView:tableShopGallery];
    rect.origin=[self convertPoint:rect.origin toView:gl];
    rect.origin.y=232-20;//lấy từ lúc bắt đầu animation
    
    return rect;
}

-(CGRect)scrollTableUserGalleryToIndexPathAndGiveBackRect:(GalleryView*) gl indexPath:(NSIndexPath *)indexPath
{
    [templateUserGallery setTableView:tableUserGallery];
    [tableUserGallery scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:false];
    
    CGRect rect=[tableUserGallery rectForRowAtIndexPath:indexPath];
    
    rect.size=[ShopPictureCell size];
    rect.origin=[tableUserGallery convertPoint:rect.origin fromView:[tableUserGallery cellForRowAtIndexPath:indexPath]];
    rect.origin=[self convertPoint:rect.origin fromView:tableUserGallery];
    rect.origin=[self convertPoint:rect.origin toView:gl];
    rect.origin.y=344-20;//lấy từ lúc bắt đầu animation
    
    return rect;
}

@end

@implementation TemplateUserGallery

@end

@implementation TemplateShopGallery

@end