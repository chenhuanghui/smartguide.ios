//
//  UserGalleryFullViewController.m
//  SmartGuide
//
//  Created by MacMini on 23/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserGalleryFullViewController.h"

@interface UserGalleryFullViewController ()

@end

@implementation UserGalleryFullViewController

-(UserGalleryFullViewController *)initWithShop:(id)shop selectedGallery:(id)gallery
{
    self=[super init];
    
    _shop=shop;
    _selectedGallery=gallery;
    _galleries=[_shop.userGalleriesObjects mutableCopy];
    
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
            [table scrollToRowAtIndexPath:indexPath(index,0) atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    }
}

-(id)galleryItemAtIndex:(int)index
{
    if([_galleries isIndexInside:index])
        return _galleries[index];
    
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _galleries.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryFullCell *cell=(GalleryFullCell*)[super tableView:table cellForRowAtIndexPath:indexPath];
    ShopUserGallery *gallery=_galleries[indexPath.row];
    
    [cell loadImageURL:gallery.image];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
