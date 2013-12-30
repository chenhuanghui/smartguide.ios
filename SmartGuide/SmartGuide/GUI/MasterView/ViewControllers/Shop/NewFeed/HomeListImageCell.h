//
//  NewFeedListImageCell.h
//  SmartGuide
//
//  Created by MacMini on 27/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeListImageCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
}

-(void) loadImageWithURL:(NSString*) url;

+(NSString *)reuseIdentifier;

@end
