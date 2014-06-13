//
//  ShopGalleryManager.h
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shop.h"

#define NOTIFICATION_GALLERY_FINISED_SHOP @"galleryFinishedShop"
#define NOTIFICATION_GALLERY_FINISED_USER @"galleryFinishedUser"
#define NOTIFICATION_GALLERY_SELECTED_CHANGE @"gallerySelectedChange"
#define NOTIFICATION_COMMENTS_FINISHED_TOP_AGREED @"commentsFinishedTopAgreed"
#define NOTIFICATION_COMMENTS_FINISHED_TIME @"commentsFinishedTime"

@interface ShopManager : NSObject
{
    __strong Shop *_shop;
    
    int _pageGalleryUser;
    int _pageGalleryShop;
    int _pageCommentsTopAgreed;
    int _pageCommentsTime;
}

+(ShopManager*) shareInstanceWithShop:(Shop*) shop;
+(void) clean;

-(void) makeData;
-(Shop*) shop;

-(void) requestUserGallery;
-(void) requestShopGallery;
-(void) requestCommentWithSort:(enum SORT_SHOP_COMMENT) sortType;
-(NSArray*) commentWithSort:(enum SORT_SHOP_COMMENT) sortType;

@property (nonatomic, readonly) bool canLoadMoreCommentTopAgreed;
@property (nonatomic, readonly) bool canLoadMoreCommentTime;
@property (nonatomic, readonly) bool canLoadMoreShopGallery;
@property (nonatomic, readonly) bool canLoadMoreUserGallery;
@property (nonatomic, readonly) bool isLoadingMoreCommentTopAgreed;
@property (nonatomic, readonly) bool isLoadingMoreCommentTime;
@property (nonatomic, readonly) bool isLoadingMoreShopGallery;
@property (nonatomic, readonly) bool isLoadingMoreUserGallery;
@property (nonatomic, strong) NSMutableArray *shopGalleries;
@property (nonatomic, strong) NSMutableArray *userGalleries;
@property (nonatomic, strong) NSMutableArray *topAgreedComments;
@property (nonatomic, strong) NSMutableArray *timeComments;
@property (nonatomic, weak) id selectedShopGallery;
@property (nonatomic, weak) id selectedUserGallery;

@end
