//
//  HomeImagesType9Cell.h
//  SmartGuide
//
//  Created by MacMini on 06/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHome.h"
#import "PageControl.h"

@interface HomeImagesType9Cell : UITableViewCell
{
    __weak IBOutlet UICollectionView *collView;
    __weak UserHome *_home;
    __weak IBOutlet PageControlNext *page;
}

-(void) loadWithHome9:(UserHome*) home;
+(NSString *)reuseIdentifier;

@end
