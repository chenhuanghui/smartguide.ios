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
    __weak IBOutlet UIImageView *imgvLoading;
    __weak IBOutlet UIImageView *imgvImage;
}

-(void) setURLString:(NSString*) url duration:(float) duration;
-(void) setImage:(UIImage*) image duration:(float) duration;
-(UIImage*) userImage;

+(NSString *)reuseIdentifier;
+(CGSize) size;
+(CGSize) imageSize;

@end
