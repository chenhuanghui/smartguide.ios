//
//  ShopGalleryTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageControlShopGallery;

@interface ShopGalleryTableCell : UITableViewCell
{
    __weak IBOutlet UICollectionView *collView;
    __weak IBOutlet PageControlShopGallery *pageControl;
}

-(void) loadWithGalleries:(NSArray*) galleries;

+(NSString *)reuseIdentifier;
+(float) height;

@property (nonatomic, strong) NSArray *galleries;

@end

@interface UITableView(ShopGalleryTableCell)

-(void) registerShopGalleryTableCell;
-(ShopGalleryTableCell*) shopGalleryTableCell;

@end