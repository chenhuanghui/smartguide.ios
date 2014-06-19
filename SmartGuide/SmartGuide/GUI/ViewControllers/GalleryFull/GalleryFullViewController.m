//
//  GalleryFullViewController.m
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryFullViewController.h"
#import "LoadingMoreCollectionCell.h"
#import "ShopManager.h"
#import "UserUploadGalleryManager.h"
#import "GalleryFullCell.h"

@interface GalleryFullViewController ()<GalleryFullCellDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation GalleryFullViewController

-(GalleryFullViewController *)initWithShop:(Shop *)shop
{
    self = [super initWithNibName:@"GalleryFullViewController" bundle:nil];
    if (self) {
        _shop=shop;
    }
    return self;
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_GALLERY_FINISED_SHOP,NOTIFICATION_GALLERY_FINISED_USER];
}

-(void)receiveNotification:(NSNotification *)notification
{
    [self reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [collView registerLoadingMoreCell];
    [collView registerGalleryFullCell];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCollView:)];
    
    [collView addGestureRecognizer:tap];
    [collView.panGestureRecognizer requireGestureRecognizerToFail:tap];
    
    tapCollView=tap;
}

-(void) tapCollView:(UITapGestureRecognizer*) tap
{
    CGPoint pnt=[tap locationInView:collView];
    
    NSIndexPath *indexPath=[collView indexPathForItemAtPoint:pnt];
    GalleryFullCell *cell=(GalleryFullCell*)[collView cellForItemAtIndexPath:indexPath];
    
    tap.enabled=false;
    pnt.x-=collView.contentOffset.x;
    [cell zoom:pnt completed:^{
        tap.enabled=true;
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for(GalleryFullCell *cell in collView.visibleCells)
        if([cell isKindOfClass:[GalleryFullCell class]])
            [cell collectionViewDidScroll:collView indexPath:[collView indexPathForCell:cell]];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryFullCell*cell=[collectionView galleryFullCellForIndexPath:indexPath];
    cell.delegate=self;
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.l_v_s;
}

-(id)galleryAtIndex:(int)index
{
    return nil;
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.delegate galleryFullTouchedBack:self];
}

-(void)reloadData
{
    [collView reloadData];
    [self scrollViewDidScroll:collView];
}

-(void)galleryFullCellTouchedOutsideImage:(GalleryFullCell *)cell
{
    [self.delegate galleryFullTouchedBack:self];
}

-(id)currentGallery
{
    CGPoint pnt=CGPointMake(collView.l_co_x+UIApplicationSize().width/2, UIApplicationSize().height/2);
    NSIndexPath *idx=[collView indexPathForItemAtPoint:pnt];
    
    if(idx)
        return [self galleryAtIndex:idx.row];
    
    return nil;
}

@end

@implementation ShopGalleryFullViewController

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
    
    if([ShopManager shareInstanceWithShop:_shop].selectedShopGallery)
    {
        int index=[[self galleries] indexOfObject:[ShopManager shareInstanceWithShop:_shop].selectedShopGallery];
        
        if(index!=NSNotFound)
        {
            [collView scrollToItemAtIndexPath:makeIndexPath(index, 0) atScrollPosition:UICollectionViewScrollPositionNone animated:false];
        }
    }
}

-(id)galleryAtIndex:(int)index
{
    if([[self galleries] isIndexInside:index])
        return [self galleries][index];
    
    return nil;
}

-(void) requestGalleries
{
    [[ShopManager shareInstanceWithShop:_shop] requestShopGallery];
}

-(NSArray*) galleries
{
    return [[ShopManager shareInstanceWithShop:_shop] shopGalleries];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self galleries].count==0?0:1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self galleries].count+([ShopManager shareInstanceWithShop:_shop].canLoadMoreShopGallery?1:0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([ShopManager shareInstanceWithShop:_shop].canLoadMoreShopGallery && indexPath.row==[self galleries].count)
    {
        if(![ShopManager shareInstanceWithShop:_shop].isLoadingMoreShopGallery)
        {
            [self requestGalleries];
        }
        
        return [collView loadingMoreCellAtIndexPath:indexPath];
    }
    
    GalleryFullCell *cell=(GalleryFullCell*)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    ShopGallery *gallery=_shop.shopGalleriesObjects[indexPath.row];
    
    NSString *url=gallery.image;
    
    [cell loadImageURL:url];
    
    return cell;
}

@end

@implementation UserGalleryFullViewController

-(NSArray*) galleries
{
    return [[ShopManager shareInstanceWithShop:_shop] userGalleries];
}

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
    
    if([ShopManager shareInstanceWithShop:_shop].selectedUserGallery)
    {
        int index=[[self galleries] indexOfObject:[ShopManager shareInstanceWithShop:_shop].selectedUserGallery];
        
        if(index!=NSNotFound)
        {
            [collView scrollToItemAtIndexPath:makeIndexPath(index, 0) atScrollPosition:UICollectionViewScrollPositionNone animated:false];
        }
    }
}

-(id)galleryAtIndex:(int)index
{
    if([[self galleries] isIndexInside:index])
        return [self galleries][index];
    
    return nil;
}

-(void) requestGalleries
{
    [[ShopManager shareInstanceWithShop:_shop] requestUserGallery];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self galleries].count==0?0:1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self galleries].count+([ShopManager shareInstanceWithShop:_shop].canLoadMoreUserGallery?1:0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([ShopManager shareInstanceWithShop:_shop].canLoadMoreUserGallery && indexPath.row==[self galleries].count)
    {
        if(![ShopManager shareInstanceWithShop:_shop].canLoadMoreUserGallery)
        {
            [self requestGalleries];
        }
        
        return [collView loadingMoreCellAtIndexPath:indexPath];
    }
    
    GalleryFullCell *cell=(GalleryFullCell*)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    id gallery=[self galleries][indexPath.row];
    
    if([gallery isKindOfClass:[ShopUserGallery class]])
    {
        ShopUserGallery *obj=gallery;
        [cell loadImageURL:obj.image];
    }
    else if([gallery isKindOfClass:[UserGalleryUpload class]])
    {
        UserGalleryUpload *obj=gallery;
        [cell loadWithImage:[UIImage imageWithData:obj.image]];
    }
    
    return cell;
}

@end

@implementation GalleryFullCollectionView

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(contentOffset.x<0)
        contentOffset.x=0;
    
    [super setContentOffset:contentOffset];
}

@end