//
//  ImageEditor.m
//  SmartGuide
//
//  Created by XXX on 8/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ImageEditor.h"
#import "NLCropViewLayer.h"

@interface UIImage(Utility)

-(UIImage*) crop:(CGRect) rect;

@end

@interface ImageEditor()
{
    NLCropViewLayer *cropView;
}

@end

@implementation ImageEditor
@synthesize delegate;

-(ImageEditor *)initWithUIImage:(UIImage *)image frame:(CGRect)rect
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ImageEditor" owner:nil options:nil] objectAtIndex:0];
    self.frame=rect;

    scroll.scrollEnabled=false;
    
    rect.origin=CGPointZero;
    rect.size.height-=44;
    scroll.frame=rect;
    
//    scroll.contentSize=CGSizeMake(MAX(rect.size.width, image.size.width), MAX(rect.size.height, image.size.height));
    
    imgv.contentMode=UIViewContentModeScaleAspectFill;
    imgv.frame=CGRectMake(0, 0, scroll.frame.size.width, scroll.frame.size.height);
    imgv.image=image;
    
    cropView=[[NLCropViewLayer alloc] initWithFrame:CGRectMake(0, 0, scroll.frame.size.width, scroll.frame.size.height)];
    cropView.backgroundColor=[UIColor clearColor];
    
    [self addSubview:cropView];
    
    return self;
}

- (IBAction)btnCropTouchUpInside:(id)sender {

    CGRect imageRect = CGRectMake(cropView.cropRect.origin.x*imgv.image.scale,
                                  cropView.cropRect.origin.y*imgv.image.scale,
                                  cropView.cropRect.size.width*imgv.image.scale,
                                  cropView.cropRect.size.height*imgv.image.scale);
    
    imgv.contentMode=UIViewContentModeCenter;
    imgv.image=[imgv.image crop:imageRect];
    [delegate imageEditorCroped:imgv.image];
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [delegate imageEditorBack];
}

- (NSString *)applicationDocumentsDirectory
{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
    
    return documentPath;
}

@end



@implementation UIImage(Utility)

- (UIImage *)crop:(CGRect)rect {

    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

@end