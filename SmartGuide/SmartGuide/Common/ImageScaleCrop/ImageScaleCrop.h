//
//  ImageScaleCrop.h
//  SmartGuide
//
//  Created by MacMini on 27/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageDefaultBGView : UIView

@end

@interface ImageDefault : UIImageView

@property (nonatomic, weak, readonly) ImageDefaultBGView *bgView;

@end

@interface ImageScaleCrop : ImageDefault

@property (nonatomic, assign) CGSize viewWillSize;

@end

@interface ImageScaleCropHeight : ImageDefault

@property (nonatomic, assign) CGSize viewWillSize;
+(CGSize) makeSizeFromImageSize:(CGSize) imageSize willWidth:(float) willWidth;

@end

@interface ImageScaleShopGallery : ImageDefault

@property (nonatomic, assign) CGSize viewWillSize;
+(CGSize) makeSizeFromImageSize:(CGSize) imageSize willHeight:(float) willHeight;

@end