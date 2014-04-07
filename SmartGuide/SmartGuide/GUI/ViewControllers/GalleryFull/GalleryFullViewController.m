//
//  GalleryFullViewController.m
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryFullViewController.h"
#import "LoadingMoreCollectionCell.h"
#import "GalleryManager.h"

@interface GalleryFullViewController ()

@end

@implementation GalleryFullViewController
@synthesize delegate;

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

-(void)setParentController:(SGViewController *)parentController
{
    [self removeFromParentViewController];
    _parentController=parentController;
    [_parentController addChildViewController:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    collView.collectionViewFlowLayout.itemSize=UIScreenSize();
    
    [collView registerNib:[UINib nibWithNibName:[GalleryFullCell reuseIdentifier] bundle:nil] forCellWithReuseIdentifier:[GalleryFullCell reuseIdentifier]];
    
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

-(void) show
{
    if(_parentController)
    {
        self.view.alpha=0;
        [self.view makeAlphaViewAtIndex:0];
        self.view.alphaView.backgroundColor=[UIColor blackColor];
        self.view.alphaView.alpha=0;
        
        [self.view l_v_setS:_parentController.view.l_v_s];
        [self.view.alphaView l_v_setS:self.view.l_v_s];
        [_parentController.view addSubview:self.view];
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            self.view.alpha=1;
            self.view.alphaView.alpha=0.9f;
        }];
    }
}

-(void)setSelectedObject:(id)selectedObject
{
    _selectedGallery=selectedObject;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for(GalleryFullCell *cell in collView.visibleCells)
        if([cell isKindOfClass:[GalleryFullCell class]])
            [cell collectionViewDidScroll];
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
    GalleryFullCell*cell=[collView dequeueReusableCellWithReuseIdentifier:[GalleryFullCell reuseIdentifier] forIndexPath:indexPath];
    
    cell.collView=collectionView;
    cell.indexPath=indexPath;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.l_v_w;
}

-(id)selectedObject
{
    NSIndexPath *indexPath= [collView indexPathForItemAtPoint:CGPointMake(collView.l_v_w/2,collView.l_co_y+collView.l_v_h/2)];
    
    if(indexPath)
    {
        return [self galleryItemAtIndex:indexPath.row];
    }
    
    return nil;
}

-(id)galleryItemAtIndex:(int)index
{
    return nil;
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    
    if(_parentController)
    {
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            self.view.alphaView.alpha=0;
            self.view.alpha=0;
        } completion:^(BOOL finished) {
            [self.delegate galleryFullTouchedBack:self];
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];
    }
    else
        [self.delegate galleryFullTouchedBack:self];
}

-(void)reloadData
{
    [collView reloadData];
    [self scrollViewDidScroll:collView];
}

@end

@implementation ShopGalleryFullViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [collView registerLoadingMoreCell];
}

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
    
    if(_selectedGallery)
    {
        int index=[_shop.shopGalleriesObjects indexOfObject:_selectedGallery];
        
        if(index!=NSNotFound)
        {
            [collView scrollToItemAtIndexPath:indexPath(index, 0) atScrollPosition:UICollectionViewScrollPositionNone animated:false];
        }
    }
}

-(id)galleryItemAtIndex:(int)index
{
    if([_shop.shopGalleriesObjects isIndexInside:index])
        return _shop.shopGalleriesObjects[index];
    
    return nil;
}

-(void) requestGalleries
{
    [[GalleryManager shareInstanceWithShop:_shop] requestShopGallery];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _shop.shopGalleriesObjects.count==0?0:1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _shop.shopGalleriesObjects.count+([GalleryManager shareInstanceWithShop:_shop].canLoadMoreShopGallery?1:0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([GalleryManager shareInstanceWithShop:_shop].canLoadMoreShopGallery && indexPath.row==[collView numberOfItemsInSection:indexPath.section]-1)
    {
        if(![GalleryManager shareInstanceWithShop:_shop].isLoadingMoreShopGallery)
        {
            [self requestGalleries];
        }
        
        return [collView loadingMoreCellAtIndexPath:indexPath];
    }
    
    GalleryFullCell *cell=(GalleryFullCell*)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    ShopGallery *gallery=_shop.shopGalleriesObjects[indexPath.row];
    
    [cell loadImageURL:gallery.image imageSize:CGSizeZero];
    
    return cell;
}

@end

@implementation UserGalleryFullViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [collView registerLoadingMoreCell];
}

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
    
    if(_selectedGallery)
    {
        int index=[_shop.userGalleriesObjects indexOfObject:_selectedGallery];
        
        if(index!=NSNotFound)
        {
            [collView scrollToItemAtIndexPath:indexPath(index, 0) atScrollPosition:UICollectionViewScrollPositionNone animated:false];
        }
    }
}

-(id)galleryItemAtIndex:(int)index
{
    if([_shop.userGalleriesObjects isIndexInside:index])
        return _shop.userGalleriesObjects[index];
    
    return nil;
}

-(void) requestGalleries
{
    [[GalleryManager shareInstanceWithShop:_shop] requestUserGallery];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _shop.userGalleriesObjects.count==0?0:1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _shop.userGalleriesObjects.count+([GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery?1:0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery && indexPath.row==[collView numberOfItemsInSection:indexPath.section]-1)
    {
        if(![GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery)
        {
            [self requestGalleries];
        }
        
        return [collView loadingMoreCellAtIndexPath:indexPath];
    }
    
    GalleryFullCell *cell=(GalleryFullCell*)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    ShopUserGallery *gallery=_shop.userGalleriesObjects[indexPath.row];
    
    [cell loadImageURL:gallery.image imageSize:CGSizeZero];
    
    return cell;
}

@end