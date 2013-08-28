//
//  GalleryCell.h
//  SmartGuide
//
//  Created by XXX on 8/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryCell : UIView
{
    __weak IBOutlet UIImageView *imgv;
    
}

-(void) setImageURL:(NSURL*) url;
-(void) setIMG:(UIImage*) image;
-(UIImageView*) imgv;

+(CGSize) size;
+(NSString *)reuseIdentifier;

@end
