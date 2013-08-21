//
//  GalleryCell.m
//  SmartGuide
//
//  Created by XXX on 8/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "GalleryCell.h"
#import "UIImageView+AFNetworking.h"
#import "Utility.h"

@implementation GalleryCell

-(void) setImageURL:(NSURL*) url
{
    imgv.image=nil;    
    [imgv setImageWithURL:url onCompleted:^(id image) {
        [self setIMG:image];
    }];
}

-(void)setIMG:(UIImage *)image
{
    imgv.image=nil;
    
    if(![image isKindOfClass:[UIImage class]])
        return;
    
    CGSize size=[Utility scaleProportionallyFromSize:image.size toSize:CGSizeMake(self.frame.size.height, self.frame.size.width)];
    imgv.frame=CGRectMake(0, 0, size.width, size.height);
    imgv.center=CGPointMake(self.frame.size.height/2, self.frame.size.width/2);
    imgv.image=image;
}

+(NSString *)reuseIdentifier
{
    return @"GalleryCell";
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self=[super awakeAfterUsingCoder:aDecoder];
    
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*2));
    
    return self;
}

-(UIImageView *)imgv
{
    return imgv;
}

@end
