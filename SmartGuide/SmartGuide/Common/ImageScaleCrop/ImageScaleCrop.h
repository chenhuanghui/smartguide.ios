//
//  ImageScaleCrop.h
//  SmartGuide
//
//  Created by MacMini on 27/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScaleCrop : UIImageView

@property (nonatomic, assign) CGSize viewWillSize;

@end

@interface ImageScaleCropHeight : UIImageView

@property (nonatomic, assign) CGSize viewWillSize;
+(CGSize) makeSizeFromImageSize:(CGSize) imageSize willWidth:(float) willWidth;

@end