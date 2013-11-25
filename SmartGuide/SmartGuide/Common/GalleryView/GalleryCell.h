//
//  GalleryCell.h
//  SmartGuide
//
//  Created by XXX on 8/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollGallery;

@interface GalleryCell : UIView<UIScrollViewDelegate>
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UITextView *txt;
    __weak IBOutlet ScrollGallery *scroll;
    __weak IBOutlet UIView *blurr;
    
    
    bool _isZoomed;
    bool _isHiddenDesc;
}


-(void) setImageURL:(NSURL*) url desc:(NSString*) desc;
-(void) setIMG:(UIImage*) image desc:(NSString*) desc;
-(UIImageView*) imgv;
-(void) setDescriptionVisibleWithDuration:(bool) visible duration:(float) duration;
-(void) setDescriptVisible:(bool) visible;
-(void) setBlurrVisible:(bool) isVisible animation:(bool) isAnimation duration:(float) duration;

+(CGSize) size;
+(NSString *)reuseIdentifier;

@end

@interface ScrollGallery : UIScrollView<UIGestureRecognizerDelegate>

@end