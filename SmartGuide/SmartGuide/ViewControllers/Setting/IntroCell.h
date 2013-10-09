//
//  IntroCell.h
//  SmartGuide
//
//  Created by XXX on 9/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
}

-(void) setImageIntro:(UIImage*) img;
+(NSString *)reuseIdentifier;

@end
