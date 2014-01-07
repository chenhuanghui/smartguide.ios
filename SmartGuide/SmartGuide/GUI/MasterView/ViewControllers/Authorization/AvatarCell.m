//
//  AvatarCell.m
//  SmartGuide
//
//  Created by MacMini on 06/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "AvatarCell.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation AvatarCell

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"AvatarCell" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

-(void)loadWithURL:(NSString *)url
{
    _url=[url copy];
    [imgv loadCommentAvatarWithURL:_url];
}

-(void)loadWithImage:(UIImage *)image
{
    [imgv setImage:image];
}

-(NSString *)url
{
    return _url;
}

+(NSString *)reuseIdentifier
{
    return @"AvatarCell";
}

+(CGSize)size
{
    return CGSizeMake(160, 154);
}

@end
