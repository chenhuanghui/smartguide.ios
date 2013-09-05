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
    self=[[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"ShopPicture") owner:nil options:nil] objectAtIndex:0];
    
    [self setShop:shop];
    
    CGRect rect=tableShop.frame;
    tableShop.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*6));
    tableShop.frame=rect;
    
    rect=tableUser.frame;
    tableUser.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*6));
    tableUser.frame=rect;
    
    templateShop=[[TableTemplate alloc] initWithTableView:tableShop withDelegate:self];
    templateUser=[[TableTemplate alloc] initWithTableView:tableUser withDelegate:self];
    
    templateUser.alignAutoCell=10;
    templateShop.alignAutoCell=10;
    
    [tableShop registerNib:[UINib nibWithNibName:[ShopPictureCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopPictureCell reuseIdentifier]];
    [tableUser registerNib:[UINib nibWithNibName:[ShopPictureCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopPictureCell reuseIdentifier]];
    
    return self;
}

-(bool)tableTemplateAllowAutoScrollFullCell:(TableTemplate *)tableTemplate
{
    return true;
}

-(bool)tableTemplateAllowLoadMore:(TableTemplate *)tableTemplate
{
    return tableTemplate.tableView==tableUser;
}

-(void)tableTemplateLoadNext:(TableTemplate *)tableTemplate wait:(bool *)isWait
{
    *isWait=true;
    
    [self loadUserGalleryAtPage:templateUser.page+1];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tableShop)
        return templateShop.datasource.count;
    else if(tableView==tableUser)
        return templateUser.datasource.count;
    
    if(_isUserViewShopGallery)
        return templateShop.datasource.count;
    
    return templateUser.datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableUser)
    {
        ShopPictureCell *cell=[tableUser dequeueReusableCellWithIdentifier:[ShopPictureCell reuseIdentifier]];
        
        ShopUserGallery *ug=[templateUser.datasource objectAtIndex:indexPath.row];
        
        if(ug.imagePosed)
            [cell setImage:ug.imagePosed duration:0.5f];
        else
            [cell setURLString:ug.thumbnail duration:0.5f];
        
        return cell;
    }
    else if(tableView==tableShop)
    {
        ShopPictureCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopPictureCell reuseIdentifier]];
        ShopGallery *sg=[templateShop.datasource objectAtIndex:indexPath.row];
        
        [cell setURLString:sg.thumbnail duration:0.5f];
        
        return cell;
    }
    else
    {
        GalleryCell *cell=(GalleryCell*)[galleryView tableView:tableView cellForRowAtIndexPath:indexPath];
        
        if(!_isUserViewShopGallery)
        {
            ShopUserGallery *ug=[templateUser.datasource objectAtIndex:indexPath.row];
            
            if(ug.imagePosed)
                [cell setIMG:ug.imagePosed];
            else
                [cell setImageURL:[NSURL URLWithString:ug.image]];
        }
        else
        {
            ShopGallery *sg=[templateShop.datasource objectAtIndex:indexPath.row];
            
            [cell setImageURL:[NSURL URLWithString:sg.image]];
        }
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableUser || tableView==tableShop)
        return [ShopPictureCell size].height+12;
    
    return [galleryView tableView:tableView heightForRowAtIndexPath:indexPath];
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
        [tableUser reloadData];
        [tableShop reloadData];
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
        [templateUser.datasource addObjectsFromArray:@[[ShopUserGallery temporary],[ShopUserGallery temporary]]];
        _isTemporaryUserGallery=true;
    }
    
    _isTemporaryShopGallery=false;
    if(templateShop.datasource.count==0)
    {
        [templateShop.datasource addObjectsFromArray:@[[ShopGallery temporary],[ShopGallery temporary],[ShopGallery temporary]]];
        _isTemporaryShopGallery=true;
    }
    
    [templateUser setAllowLoadMore:templateUser.datasource.count==10];
    
    [tableShop reloadData];
    [tableUser reloadData];
    
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
    
    [templateUser resetData];
    [templateShop resetData];
    
    [tableShop setContentOffset:CGPointZero];
    [tableUser setContentOffset:CGPointZero];
    
    if(_operationUserGallery)
    {
        [_operationUserGallery cancel];
        _operationUserGallery=nil;
    }
    
    templateUser.page=0;
    
    templateUser.datasource=[[NSMutableArray alloc] init];
    [templateUser.datasource addObjectsFromArray:@[[ShopUserGallery temporary],[ShopUserGallery temporary]]];
    _isTemporaryUserGallery=true;
    
    templateShop.datasource=[[NSMutableArray alloc] init];
    [templateShop.datasource addObjectsFromArray:@[[ShopGallery temporary],[ShopGallery temporary],[ShopGallery temporary]]];
    _isTemporaryShopGallery=true;
    
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
        
        [templateUser setAllowLoadMore:operationUG.userGallerys.count==10];
        [templateUser endLoadNext];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    isProcessedData=true;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableUser)
    {
        ShopPictureCell *picture=(ShopPictureCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        if(!picture.userImage)
            return;
        
        _isUserViewShopGallery=false;
        _rootView=[[RootViewController shareInstance] giveARootView];
        _rootView.backgroundColor=[UIColor clearColor];
        
        galleryView=[[GalleryView alloc] init];
        galleryView.selectedIndex=indexPath;
        galleryView.delegate=self;
        
        [templateUser setTableView:galleryView.table];
        
        [_rootView addSubview:galleryView];
        
        [galleryView animationImage:picture.userImage startRect:CGRectZero];
    }
    else if(tableView==tableShop)
    {
        ShopPictureCell *picture=(ShopPictureCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        if(!picture.userImage)
            return;
        
        _isUserViewShopGallery=true;
        _rootView=[[RootViewController shareInstance] giveARootView];
        _rootView.backgroundColor=[UIColor clearColor];
        
        galleryView=[[GalleryView alloc] init];
        galleryView.selectedIndex=indexPath;
        galleryView.delegate=self;
        
        [templateShop setTableView:galleryView.table];
        
        [_rootView addSubview:galleryView];
        
        [galleryView animationImage:picture.userImage startRect:CGRectZero];
    }
}

-(void)galleryViewBack:(GalleryView *)_galleryView
{
    [templateUser setTableView:tableUser];
    [templateShop setTableView:tableShop];
    
    [tableUser scrollToRowAtIndexPath:templateUser.currentIndexPath atScrollPosition:UITableViewScrollPositionNone animated:true];
    [tableShop scrollToRowAtIndexPath:templateShop.currentIndexPath atScrollPosition:UITableViewScrollPositionNone animated:false];
    
    [galleryView removeFromSuperview];
    [[RootViewController shareInstance] removeRootView:_rootView];
    _rootView=nil;
    galleryView=nil;
}

-(NSString *)galleryViewDescriptionImage:(int)index
{
    if(index<templateUser.datasource.count)
    {
        return ((ShopUserGallery*)[templateUser.datasource objectAtIndex:index]).desc;
    }
    
    return @"";
}

-(CGRect)galleryViewFrameForAnimationHide:(GalleryView *)_galleryView index:(NSIndexPath *)indexPath
{
    if(_isUserViewShopGallery)
    {
        templateShop.currentIndexPath=indexPath;        
    }
    else
    {
        templateUser.currentIndexPath=indexPath;
    }
    
    return CGRectZero;
}

-(bool)galleryViewAllowDescription:(GalleryView *)galleryView
{
    return !_isUserViewShopGallery;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(galleryView)
    {
        [galleryView scrollViewDidScroll:scrollView];
    }
}

- (IBAction)btnAddTouchUpInside:(id)sender {
    ShopUserPose *userPose=[[ShopUserPose alloc] initWithViewController:self.handler.navigationController shop:_shop];
    userPose.delegate=self;
    
    [userPose show];
}

-(void)shopUserPostCancelled:(ShopUserPose *)userPose
{
    
}

-(void)shopUserPostFinished:(ShopUserPose *)userPose userGallery:(ShopUserGallery *)userGallery
{
    if(_isTemporaryUserGallery)
    {
        templateUser.datasource=[[NSMutableArray alloc] init];
        _isTemporaryUserGallery=false;
    }
    
    if(templateUser.datasource.count>0)
    {
        [templateUser.datasource insertObject:userGallery atIndex:0];
    }
    else
        [templateUser.datasource addObject:userGallery];
    
    [tableUser scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:true];
    
    [tableUser reloadData];
}

@end