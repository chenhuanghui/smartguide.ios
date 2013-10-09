//
//  TutorialCell.h
//  SmartGuide
//
//  Created by XXX on 9/3/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
}

-(void) setTutorialImage:(UIImage*) image;
+(CGSize) size;
+(NSString *)reuseIdentifier;

@end
