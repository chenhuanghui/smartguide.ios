//
//  ShopGalleryManager.m
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopManager.h"
#import "UserUploadGalleryManager.h"
#import "ASIOperationShopGallery.h"
#import "ASIOperationUserGallery.h"
#import "ASIOperationShopComment.h"
#import "ASIOperationPostComment.h"

static ShopManager *_galleryManager;

@interface ShopManager()<ASIOperationPostDelegate,NSFetchedResultsControllerDelegate>
{
    ASIOperationShopGallery *_operationShopGallery;
    ASIOperationUserGallery *_operationUserGallery;
    ASIOperationShopComment *_operationTimeComment;
    ASIOperationShopComment *_operationTopAgreedComment;
    ASIOperationPostComment *_operationPostComment;
    
    NSFetchedResultsController *_fetchedController;
}

@end

@implementation ShopManager
@synthesize isLoadingMoreCommentTime,isLoadingMoreCommentTopAgreed,isLoadingMoreShopGallery,isLoadingMoreUserGallery;
@synthesize canLoadMoreCommentTime,canLoadMoreCommentTopAgreed,canLoadMoreShopGallery,canLoadMoreUserGallery;
@synthesize selectedUserGallery,selectedShopGallery;

+(ShopManager *)shareInstanceWithShop:(Shop *)shop
{ 
    if(_galleryManager)
    {
        if(_galleryManager.shop==shop)
            return _galleryManager;
        
        _galleryManager=nil;
    }

    _galleryManager=[[ShopManager alloc] initWithShop:shop];
    
    return _galleryManager;
}

+(void)clean
{    
    _galleryManager=nil;
}

-(Shop *)shop
{
    return _shop;
}

-(ShopManager*) initWithShop:(Shop*) shop
{
    self=[super init];
    
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:Shop_ClassName];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K==%i",Shop_IdShop,shop.idShop.integerValue]];
    [fetchRequest setSortDescriptors:@[]];
    
    _fetchedController=[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[DataManager shareInstance].managedObjectContext sectionNameKeyPath:nil cacheName:@"ShopManager"];
    _fetchedController.delegate=self;
    
    NSError *error=nil;
    [_fetchedController performFetch:&error];
    _shop=_fetchedController.fetchedObjects[0];
    
    return self;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    
}

-(void) makeData
{
    self.shopGalleries=[_shop.shopGalleriesObjects mutableCopy];
    canLoadMoreShopGallery=self.shopGalleries.count==10;
    isLoadingMoreShopGallery=false;
    _pageGalleryShop=0;
    
    self.userGalleries=[_shop.userGalleriesObjects mutableCopy];
    canLoadMoreUserGallery=self.userGalleries.count==10;
    isLoadingMoreUserGallery=false;
    _pageGalleryUser=0;
    
    self.topAgreedComments=[_shop.topCommentsObjects mutableCopy];
    canLoadMoreCommentTime=self.topAgreedComments.count==10;
    isLoadingMoreCommentTopAgreed=false;
    _pageCommentsTopAgreed=0;
    
    canLoadMoreCommentTopAgreed=false;
    isLoadingMoreCommentTime=false;
    _pageCommentsTime=-1;
    
    _sortComments=SORT_SHOP_COMMENT_TOP_AGREED;
    
    if(!self.shopGalleries)
        self.shopGalleries=[NSMutableArray new];
    
    if(!self.userGalleries)
        self.userGalleries=[NSMutableArray new];
    
    if(!self.topAgreedComments)
        self.topAgreedComments=[NSMutableArray new];
    
    if(!self.timeComments)
        self.timeComments=[NSMutableArray new];
}

-(void)requestShopGallery
{
    if(isLoadingMoreShopGallery)
        return;
    
    if(_operationShopGallery)
        return;
    
    isLoadingMoreShopGallery=true;
    
    _operationShopGallery=[[ASIOperationShopGallery alloc] initWithWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() page:_pageGalleryShop+1];
    _operationShopGallery.delegate=self;
    
    [_operationShopGallery addToQueue];
}

-(void)requestUserGallery
{
    if(isLoadingMoreUserGallery)
        return;
    
    if(_operationUserGallery)
        return;
    
    isLoadingMoreUserGallery=true;
    
    _operationUserGallery=[[ASIOperationUserGallery alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() page:_pageGalleryUser+1];
    _operationUserGallery.delegate=self;
    
    [_operationUserGallery addToQueue];
}

-(NSArray *)commentWithSort:(enum SORT_SHOP_COMMENT)sortType
{
    switch (sortType) {
        case SORT_SHOP_COMMENT_TIME:
            return self.timeComments;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            return self.topAgreedComments;
    }
}

-(enum SORT_SHOP_COMMENT)sortComments
{
    return _sortComments;
}

-(void)newCommentWithComment:(NSString *)comment
{
    if(_operationPostComment)
        return;
    
    _operationPostComment=[[ASIOperationPostComment alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() comment:comment sort:_sortComments];
    _operationPostComment.delegate=self;
    
    [_operationPostComment addToQueue];
}

-(void) requestComments
{
    [self requestCommentWithSort:_sortComments];
}

-(void)requestCommentWithSort:(enum SORT_SHOP_COMMENT)sortType
{
    if(_sortComments!=sortType)
    {
        self.timeComments=[NSMutableArray new];
        self.topAgreedComments=[NSMutableArray new];
        
        canLoadMoreCommentTime=false;
        canLoadMoreCommentTopAgreed=false;
        isLoadingMoreCommentTime=false;
        isLoadingMoreCommentTopAgreed=false;
        _pageCommentsTime=-1;
        _pageCommentsTopAgreed=-1;
        
        if(_operationTimeComment)
        {
            [_operationTimeComment clearDelegatesAndCancel];
            _operationTimeComment=nil;
        }
        
        if(_operationTopAgreedComment)
        {
            [_operationTopAgreedComment clearDelegatesAndCancel];
            _operationTopAgreedComment=nil;
        }
        
        _sortComments=sortType;
    }
    
    switch (sortType) {
        case SORT_SHOP_COMMENT_TIME:
            if(isLoadingMoreCommentTime)
                return;
            
            if(_operationTimeComment)
                return;
            
            isLoadingMoreCommentTime=true;
            
            _operationTimeComment=[[ASIOperationShopComment alloc] initWithIDShop:_shop.idShop.integerValue page:_pageCommentsTime+1 sort:SORT_SHOP_COMMENT_TIME];
            _operationTimeComment.delegate=self;
            
            [_operationTimeComment addToQueue];
            break;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            if(isLoadingMoreCommentTopAgreed)
                return;
            
            if(_operationTopAgreedComment)
                return;
            
            isLoadingMoreCommentTopAgreed=true;
            
            _operationTopAgreedComment=[[ASIOperationShopComment alloc] initWithIDShop:_shop.idShop.integerValue page:_pageCommentsTopAgreed+1 sort:SORT_SHOP_COMMENT_TOP_AGREED];
            _operationTopAgreedComment.delegate=self;
            
            [_operationTopAgreedComment addToQueue];
            break;
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopGallery class]])
    {
        ASIOperationShopGallery *ope=(ASIOperationShopGallery*) operation;
        
        [self.shopGalleries addObjectsFromArray:(ope.galleries?:@[])];
        canLoadMoreShopGallery=ope.galleries.count==10;
        isLoadingMoreShopGallery=false;
        _pageGalleryShop++;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GALLERY_FINISED_SHOP object:nil];
        
        _operationShopGallery=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserGallery class]])
    {
        ASIOperationUserGallery *ope=(ASIOperationUserGallery*) operation;
        
        [self.userGalleries addObjectsFromArray:(ope.galleries?:@[])];
        canLoadMoreUserGallery=ope.galleries.count==10;
        isLoadingMoreUserGallery=false;
        _pageGalleryUser++;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GALLERY_FINISED_USER object:nil];
        
        _operationUserGallery=nil;
    }
    else if([operation isKindOfClass:[ASIOperationShopComment class]])
    {
        if(operation==_operationTimeComment)
        {
            ASIOperationShopComment *ope=(ASIOperationShopComment*) operation;
            
            [self.timeComments addObjectsFromArray:(ope.comments?:@[])];
            canLoadMoreCommentTime=ope.comments.count==10;
            isLoadingMoreCommentTime=false;
            _pageCommentsTime++;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_COMMENTS_FINISHED_TIME object:nil];
            
            _operationTimeComment=nil;
        }
        else if(operation==_operationTopAgreedComment)
        {
            ASIOperationShopComment *ope=(ASIOperationShopComment*) operation;
            
            [self.topAgreedComments addObjectsFromArray:(ope.comments?:@[])];
            canLoadMoreCommentTopAgreed=ope.comments.count==10;
            isLoadingMoreCommentTopAgreed=false;
            _pageCommentsTopAgreed++;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_COMMENTS_FINISHED_TOP_AGREED object:nil];
            
            _operationTopAgreedComment=nil;
        }
    }
    else if([operation isKindOfClass:[ASIOperationPostComment class]])
    {
        switch (_operationPostComment.sortComment) {
            case SORT_SHOP_COMMENT_TIME:
                
                if(self.timeComments.count==0)
                    [self.timeComments addObject:_operationPostComment.userComment];
                else
                    [self.timeComments insertObject:_operationPostComment.userComment atIndex:0];
                
                break;
                
            case SORT_SHOP_COMMENT_TOP_AGREED:
                
                if(self.topAgreedComments.count==0)
                    [self.topAgreedComments addObject:_operationPostComment.userComment];
                else
                    [self.topAgreedComments insertObject:_operationPostComment.userComment atIndex:0];
                
                break;
        }
        
        _operationPostComment=nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_COMMENTS_FINISHED_NEW_COMMENT object:nil];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopGallery class]])
    {
        _operationShopGallery=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserGallery class]])
    {
        _operationUserGallery=nil;
    }
    else if([operation isKindOfClass:[ASIOperationShopComment class]])
    {
        if(operation==_operationTimeComment)
        {
            _operationTimeComment=nil;
        }
        else if(operation==_operationTopAgreedComment)
        {
            _operationTopAgreedComment=nil;
        }
    }
    else if([operation isKindOfClass:[ASIOperationPostComment class]])
    {
        _operationPostComment=nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_COMMENTS_FINISHED_NEW_COMMENT object:operation.error];
    }
}

- (void)dealloc
{
    _shop=nil;
    
    if(_operationUserGallery)
    {
        [_operationUserGallery clearDelegatesAndCancel];
        _operationUserGallery=nil;
    }
    
    if(_operationShopGallery)
    {
        [_operationShopGallery clearDelegatesAndCancel];
        _operationShopGallery=nil;
    }
    
    if(_operationTimeComment)
    {
        [_operationTimeComment clearDelegatesAndCancel];
        _operationTimeComment=nil;
    }
    
    if(_operationTopAgreedComment)
    {
        [_operationTopAgreedComment clearDelegatesAndCancel];
        _operationTopAgreedComment=nil;
    }
    
    if(_operationPostComment)
    {
        _operationPostComment.delegate=nil;
        _operationPostComment=nil;
    }
    
    self.userGalleries=nil;
    self.shopGalleries=nil;
    self.timeComments=nil;
    self.topAgreedComments=nil;
}

-(void)setSelectedShopGallery:(id)selectedShopGallery_
{
    selectedShopGallery=selectedShopGallery_;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GALLERY_SELECTED_CHANGE object:nil];
}

-(void)setSelectedUserGallery:(id)selectedUserGallery_
{
    selectedUserGallery=selectedUserGallery_;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GALLERY_SELECTED_CHANGE object:nil];
}

@end
