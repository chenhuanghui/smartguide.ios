//
//  ImageCollectionCell.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ImageCollectionCell.h"
#import "Utility.h"

@implementation ImageCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.backgroundColor=[UIColor clearColor];
    self.autoresizesSubviews=false;
    
    UIImageView *imgv=[UIImageView new];
    imgv.S=self.S;
    
    [self addSubview:imgv];
    
    _imgv=imgv;
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgv.S=self.S;
}

@end
