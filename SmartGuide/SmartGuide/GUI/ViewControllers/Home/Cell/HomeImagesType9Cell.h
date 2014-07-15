//
//  HomeImagesType9Cell.h
//  SmartGuide
//
//  Created by MacMini on 06/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeImagesType9Cell, UserHome, PageControl, PageControlNext;

@protocol HomeImagesType9CellDelegate <NSObject>

-(void) homeImagesType9Cell:(HomeImagesType9Cell*) cell touchedHome:(UserHome*) home;

@end

@interface HomeImagesType9Cell : UITableViewCell
{
    __weak IBOutlet UICollectionView *collView;
    __weak UserHome *_home;
    __weak IBOutlet PageControlNext *page;
}

-(void) loadWithHome9:(UserHome*) home;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<HomeImagesType9CellDelegate> delegate;

@end
