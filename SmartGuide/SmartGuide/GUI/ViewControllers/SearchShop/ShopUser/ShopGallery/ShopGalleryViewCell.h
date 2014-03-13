//
//  ShopGalleryViewCell.h
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopGalleryViewCell : UIView
{
    __weak IBOutlet UIImageView *imgvFrame;
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UIView *loading;
}

-(void) loadWithImage:(NSString*) url highlighted:(bool) isHighlighted;
-(void) showLoading;
-(void) hideLoading;

-(UIImageView*) imgv;

+(NSString*) reuseIdentifier;
+(float) height;

@end
