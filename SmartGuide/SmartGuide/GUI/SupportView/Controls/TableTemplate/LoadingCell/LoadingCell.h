//
//  LoadingCell.h
//  SmartGuide
//
//  Created by XXX on 7/19/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingCell : UITableViewCell
{
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
    __weak IBOutlet UIView *blackView;
}

-(void) startAnimation;
+(NSString *)reuseIdentifier;

@end
