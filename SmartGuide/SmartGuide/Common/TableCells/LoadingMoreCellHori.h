//
//  LoadingMoreCell.h
//  SmartGuide
//
//  Created by MacMini on 21/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingMoreCellHori : UITableViewCell
{
        __weak IBOutlet UIImageView *imgv;
}

-(void) showLoading;

+(NSString *)reuseIdentifier;

@end

@interface UITableView(LoadingMore)

-(void) registerLoadingMoreCellHori;
-(LoadingMoreCellHori*) loadingMoreCellHori;

@end