//
//  GalleryFullViewController.m
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryFullViewController.h"
#import "LoadingMoreCellHori.h"
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
    
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    table.frame=rect;
    [table registerNib:[UINib nibWithNibName:[GalleryFullCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[GalleryFullCell reuseIdentifier]];
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
    for(GalleryFullCell *cell in table.visibleCells)
        if([cell isKindOfClass:[GalleryFullCell class]])
            [cell tableDidScroll];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryFullCell*cell=(GalleryFullCell*)[tableView dequeueReusableCellWithIdentifier:[GalleryFullCell reuseIdentifier]];
    
    cell.table=tableView;
    cell.indexPath=indexPath;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.l_v_w;
}

-(id)selectedObject
{
    NSIndexPath *indexPath=[table indexPathForRowAtPoint:CGPointMake(table.l_v_w/2,table.l_co_y+table.l_v_h/2)];
    
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
    [table reloadData];
    [self scrollViewDidScroll:table];
}

@end

@implementation ShopGalleryFullViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [table registerLoadingMoreCellHori];
}

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
    
    if(_selectedGallery)
    {
        int index=[_shop.shopGalleriesObjects indexOfObject:_selectedGallery];
        
        if(index!=NSNotFound)
        {
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _shop.shopGalleriesObjects.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shop.shopGalleriesObjects.count+([GalleryManager shareInstanceWithShop:_shop].canLoadMoreShopGallery?1:0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([GalleryManager shareInstanceWithShop:_shop].canLoadMoreShopGallery && indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
    {
        if(![GalleryManager shareInstanceWithShop:_shop].isLoadingMoreShopGallery)
        {
            [self requestGalleries];
        }
        
        return [tableView loadingMoreCellHori];
    }
    
    GalleryFullCell *cell=(GalleryFullCell*)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    ShopGallery *gallery=_shop.shopGalleriesObjects[indexPath.row];
    
    [cell loadImageURL:gallery.image];
    
    return cell;
}

@end

@implementation UserGalleryFullViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [table registerLoadingMoreCellHori];
}

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
    
    if(_selectedGallery)
    {
        int index=[_shop.userGalleriesObjects indexOfObject:_selectedGallery];
        
        if(index!=NSNotFound)
        {
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _shop.userGalleriesObjects.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shop.userGalleriesObjects.count+([GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery?1:0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery && indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
    {
        if(![GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery)
        {
            [self requestGalleries];
        }
        
        return [tableView loadingMoreCellHori];
    }
    
    GalleryFullCell *cell=(GalleryFullCell*)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    ShopUserGallery *gallery=_shop.userGalleriesObjects[indexPath.row];
    
    [cell loadImageURL:gallery.image];
    
    return cell;
}

@end