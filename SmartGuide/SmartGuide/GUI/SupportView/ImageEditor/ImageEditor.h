//
//  ImageEditor.h
//  SmartGuide
//
//  Created by XXX on 8/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageEditorDelegate <NSObject>

-(void) imageEditorCroped:(UIImage*) image;
-(void) imageEditorBack;

@end

@interface ImageEditor : UIView
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UIScrollView *scroll;
    
}

-(ImageEditor*) initWithUIImage:(UIImage*) image frame:(CGRect) rect;

@property (nonatomic, assign) id<ImageEditorDelegate> delegate;

@end
