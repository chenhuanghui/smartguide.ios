//
//  SUKMNewsContaintCell.h
//  Infory
//
//  Created by XXX on 6/6/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPMoviePlayerController;

@interface SUKMNewsContaintCell : UITableViewCell
{
    __weak IBOutlet UITableView *tableKM;
    NSArray *_kmNews;
    
    __strong MPMoviePlayerController *_player;
}

-(void) loadWithKMNews:(NSArray*) kms;
-(void) tableDidScroll:(UITableView*) table;
-(void) tableDidEndDisplayCell:(UITableView*) table;

+(float) heightWithKMNews:(NSArray*) kms;

@end

@interface UITableView(SUKMNewsContaintCell)

-(void) registerSUKMNewsContaintCell;
-(SUKMNewsContaintCell*) SUKMNewsContaintCell;

@end