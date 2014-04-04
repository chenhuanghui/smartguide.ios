//
//  HomeImageType9Cell.h
//  SmartGuide
//
//  Created by MacMini on 06/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHome.h"

@interface HomeImageType9Cell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *imgv;
}

-(void) loadWithURL:(NSString*) url size:(CGSize) size;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak,readwrite) UICollectionView *collView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak, readwrite) UserHome *home;

@end