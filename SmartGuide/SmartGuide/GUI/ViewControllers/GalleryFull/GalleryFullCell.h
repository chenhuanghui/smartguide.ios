//
//  GalleryFullCell.h
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryFullCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UIScrollView *scroll;
}

-(void) loadImageURL:(NSString*) url;
-(void) galleryDidScroll;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) UICollectionView *collView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
