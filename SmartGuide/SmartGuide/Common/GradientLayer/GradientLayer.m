//
//  GradientLayer.m
//  Infory
//
//  Created by XXX on 7/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GradientLayer.h"

#define GRADIENT_LAYER_LENGTH_FACTOR 0.3f

@implementation GradientLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gradientLengthFactor=@(0.3f);
        self.gradientMask=GRADIENT_LAYER_MASK_BOTH;
    }
    return self;
}

-(void)setGradientLengthFactor:(NSNumber *)gradientLengthFactor
{
    if(_gradientLengthFactor.floatValue!=gradientLengthFactor.floatValue)
    {
        _gradientLengthFactor=gradientLengthFactor;
        
        [self updateGradientFactor];
    }
}

-(void) updateGradientFactor
{
    switch (self.gradientMask) {
        case GRADIENT_LAYER_MASK_BOTH:
            self.maskLayer.locations = @[@(0.f), self.gradientLengthFactor, @(1.f - self.gradientLengthFactor.floatValue), @(1.f)];
            break;
            
        case GRADIENT_LAYER_MASK_BOT:
            self.maskLayer.locations = @[@(0.f), @(0), @(1.f - self.gradientLengthFactor.floatValue), @(1.f)];
            break;
            
        case GRADIENT_LAYER_MASK_TOP:
            self.maskLayer.locations = @[@(0.f), self.gradientLengthFactor];
            break;
    }
}

-(CAGradientLayer *)createGradientMask
{
    //creating our gradient mask
    CAGradientLayer *maskLayer = [CAGradientLayer layer];
    
    //this is the anchor point for our gradient, in our case top left. setting it in the middle (.5, .5) will produce a radial gradient. our startPoint and endPoints are based off the anchorPoint
    maskLayer.anchorPoint=CGPointZero;
    
    //The line between these two points is the line our gradient uses as a guide
    //starts in bottom left
    maskLayer.startPoint = CGPointMake(0.0f, 0.0f);
    //ends in top right
    maskLayer.endPoint = CGPointMake(0.0f, 1.0f);
    
    //setting our colors - since this is a mask the color itself is irrelevant - all that matters is the alpha. A clear color will completely hide the layer we're masking, an alpha of 1.0 will completely show the masked view.
    UIColor *outerColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    UIColor *innerColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    
    switch (self.gradientMask) {
        case GRADIENT_LAYER_MASK_BOTH:
            maskLayer.colors = @[(id)outerColor.CGColor, (id)innerColor.CGColor, (id)innerColor.CGColor, (id)outerColor.CGColor];
            maskLayer.locations = @[@(0.f), self.gradientLengthFactor, @(1.f - self.gradientLengthFactor.floatValue), @(1.f)];
            break;
            
        case GRADIENT_LAYER_MASK_BOT:
            maskLayer.colors = @[(id)innerColor.CGColor, (id)innerColor.CGColor, (id)innerColor.CGColor, (id)outerColor.CGColor];
            maskLayer.locations = @[@(0.f), @(0), @(1.f - self.gradientLengthFactor.floatValue), @(1.f)];
            break;
            
        case GRADIENT_LAYER_MASK_TOP:
            maskLayer.colors = @[(id)outerColor.CGColor, (id)innerColor.CGColor, (id)innerColor.CGColor, (id)innerColor.CGColor];
            maskLayer.locations = @[@(0.f), self.gradientLengthFactor];
            break;
    }
    
    return maskLayer;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if(self.maskLayer)
    {
        self.maskLayer.frame=(CGRect){CGPointZero,frame.size};
    }
    else
    {
        self.maskLayer=[self createGradientMask];
        self.maskLayer.frame=(CGRect){CGPointZero,frame.size};
        
        self.mask=self.maskLayer;
    }
}

@end

@implementation GradientLayerTop

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gradientMask=GRADIENT_LAYER_MASK_TOP;
    }
    return self;
}

@end

@implementation GradientLayerBot

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gradientMask=GRADIENT_LAYER_MASK_BOT;
    }
    return self;
}

@end

@interface GradientView()
{
    CGSize _size;
}

@end

@implementation GradientView

+(Class)layerClass
{
    return [GradientLayer class];
}

-(GradientLayer *)gradientLayer
{
    return (GradientLayer*)self.layer;
}

-(void)setGradientLengthFactor:(NSNumber *)gradientLengthFactor
{
    self.gradientLayer.gradientLengthFactor=gradientLengthFactor;
}

-(NSNumber *)gradientLengthFactor
{
    return self.gradientLayer.gradientLengthFactor;
}

@end

@implementation GradientViewTop

+(Class)layerClass
{
    return [GradientLayerTop class];
}

@end

@implementation GradientViewBot

+(Class)layerClass
{
    return [GradientLayerBot class];
}

@end