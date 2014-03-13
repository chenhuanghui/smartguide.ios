//
//  ShopGalleryCell.h
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopGalleryCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UIScrollView *scroll;
}

-(void) loadImage:(NSString*) url;
-(void) tableViewDidScroll;
+(NSString *)reuseIdentifier;
@property (nonatomic, weak) UITableView *table;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
