//
//  SUShopGalleryCell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"

@class SUShopGalleryCell;

@protocol SUShopGalleryDelegate <NSObject>

-(void)suShopGalleryTouchedMoreInfo:(SUShopGalleryCell*) cell;

@end

@interface SUShopGalleryCell : UITableViewCell<UIScrollViewDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet PageControlNext *pageControl;
}

@property (nonatomic, weak) id<SUShopGalleryDelegate> delegate;

+(NSString *)reuseIdentifier;
+(float) height;

@end