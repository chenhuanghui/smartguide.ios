//
//  NewFeedImageCell.h
//  SmartGuide
//
//  Created by MacMini on 25/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeImageCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
}

-(void) tableDidScroll:(UITableView*) table;
-(void) loadImage:(NSString*) url;

+(NSString *)reuseIdentifier;

@end
