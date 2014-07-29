//
//  GradientLayer.h
//  Infory
//
//  Created by XXX on 7/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

enum GRADIENT_LAYER_MASK
{
    GRADIENT_LAYER_MASK_BOTH=0,
    GRADIENT_LAYER_MASK_TOP=1,
    GRADIENT_LAYER_MASK_BOT=2,
};

@interface GradientLayer : CALayer

-(CAGradientLayer*) createGradientMask;

@property (nonatomic, readwrite, strong) NSNumber *gradientLengthFactor;
@property (nonatomic, assign) enum GRADIENT_LAYER_MASK gradientMask;
@property (nonatomic, weak) CAGradientLayer *maskLayer;

//+(GradientLayer*) createGradientLayerWithLength:(float) gradientLengthFactor;
//+(GradientLayer*) createGradientLayerWithLength:(float) gradientLengthFactor mask:(enum GRADIENT_LAYER_MASK) mask;

@end

@interface GradientLayerTop : GradientLayer

@end

@interface GradientLayerBot : GradientLayer

@end

@interface GradientView : UIView

-(GradientLayer*) gradientLayer;
@property (nonatomic, readwrite, strong) NSNumber *gradientLengthFactor;

@end

@interface GradientViewTop : GradientView

@end

@interface GradientViewBot : GradientView

@end