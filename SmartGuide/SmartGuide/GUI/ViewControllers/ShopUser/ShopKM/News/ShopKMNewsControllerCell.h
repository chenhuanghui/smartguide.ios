//
//  SUKMNewsContaintCell.h
//  Infory
//
//  Created by XXX on 6/6/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPMoviePlayerController;

@interface ShopKMNewsControllerCell : UITableViewCell
{
    __weak IBOutlet UITableView *tableKM;
    __weak IBOutlet UIView *bg;
    NSArray *_kmNews;
    
    __strong MPMoviePlayerController *_player;
}

-(void) loadWithKMNews:(NSArray*) kms maxHeight:(float) maxHeight;
-(void) tableDidScroll:(UITableView*) table;
-(void) tableDidEndDisplayCell:(UITableView*) table;

+(float) heightWithKMNews:(NSArray*) kms;
+(NSString *)reuseIdentifier;

@end

@interface UITableView(ShopKMNewsControllerCell)

-(void) registerShopKMNewsControllerCell;
-(ShopKMNewsControllerCell*) shopKMNewsControllerCell;

@end