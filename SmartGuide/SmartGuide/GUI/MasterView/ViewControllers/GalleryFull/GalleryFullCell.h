//
//  GalleryFullCell.h
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryFullCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UIScrollView *scroll;
}

-(void) loadImageURL:(NSString*) url;
-(void) tableDidScroll;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) UITableView *table;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
