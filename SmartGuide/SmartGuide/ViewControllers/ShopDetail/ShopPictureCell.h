//
//  ShopPictureCell.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopPictureCell : UITableViewCell
{
    __weak IBOutlet UIImageView *picture;
    __weak IBOutlet UIView *imageContaint;
    __weak IBOutlet UIImageView *animationView;
}

-(void) setURLString:(NSString*) url duration:(float) duration;
-(void) setImage:(UIImage*) image duration:(float) duration;
-(UIImage*) userImage;

+(NSString *)reuseIdentifier;
+(CGSize) size;
+(CGSize) imageSize;

@end
