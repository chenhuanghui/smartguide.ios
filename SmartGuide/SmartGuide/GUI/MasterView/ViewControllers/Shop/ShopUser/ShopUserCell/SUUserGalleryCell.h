//
//  SUUserGalleryCell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ShopUserGallery.h"

@class SUUserGalleryCell;

@protocol UserGalleryDelegate <NSObject>

-(void) userGalleryTouchedMakePicture:(SUUserGalleryCell*) cell;

@end

@interface SUUserGalleryCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    __weak Shop* _shop;
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIImageView *imgvFirsttime;
}

-(void) loadWithShop:(Shop*) shop;

+(float) height;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<UserGalleryDelegate> delegate;

@end
