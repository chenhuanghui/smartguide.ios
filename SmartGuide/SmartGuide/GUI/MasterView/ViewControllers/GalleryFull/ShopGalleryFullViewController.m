//
//  ShopGalleryFullViewController.m
//  SmartGuide
//
//  Created by MacMini on 23/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopGalleryFullViewController.h"

@interface ShopGalleryFullViewController ()

@end

@implementation ShopGalleryFullViewController

-(ShopGalleryFullViewController *)initWithShop:(Shop *)shop selectedGallery:(ShopGallery *)gallery
{
    self=[super init];
    
    _shop=shop;
    _selectedGallery=gallery;
    _galleries=[_shop.shopGalleriesObjects mutableCopy];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if(_selectedGallery)
    {
        int index=[_galleries indexOfObject:_selectedGallery];
        
        if(index!=NSNotFound)
        {
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    }
}

-(id)galleryItemAtIndex:(int)index
{
    if([_galleries isIndexInside:index])
        return _galleries[index];
    
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _galleries.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryFullCell *cell=(GalleryFullCell*)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    ShopGallery *gallery=_galleries[indexPath.row];
    
    [cell loadImageURL:gallery.image];
    
    return cell;
}
@end
