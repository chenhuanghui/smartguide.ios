//
//  MoviePlayerThumbnail.m
//  Infory
//
//  Created by XXX on 6/6/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "MoviePlayerThumbnail.h"
#import "Utility.h"

@implementation MoviePlayerThumbnail

-(void)setContentURL:(NSURL *)contentURL
{
    [super setContentURL:contentURL];
    
    if(!_isRegisterNotification && contentURL)
    {
        _isRegisterNotification=true;
 
        [self cancelAllThumbnailImageRequests];
        [self requestThumbnailImagesAtTimes:@[@(0)] timeOption:MPMovieTimeOptionNearestKeyFrame];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(durationAvailable:) name:MPMovieDurationAvailableNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thumbnailAvailable:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStateChanged:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    }
}

-(void) durationAvailable:(NSNotification*) notification
{
    [self requestThumbnail];
}

-(void) requestThumbnail
{    
    [self cancelAllThumbnailImageRequests];
    [self requestThumbnailImagesAtTimes:@[@(self.currentPlaybackTime)] timeOption:MPMovieTimeOptionNearestKeyFrame];
}

-(void) playStateChanged:(NSNotification*) notification
{
    if(notification.object!=self)
        return;
    
    imgvThumbnail.hidden=self.playbackState!=MPMoviePlaybackStateStopped;
    
    [self requestThumbnail];
}

-(void)play
{
    [super play];
}

-(void) thumbnailAvailable:(NSNotification*) notification
{
    if(notification.object!=self)
        return;
    
    if(!imgvThumbnail)
    {
        UIImageView *imgv=[UIImageView new];
        imgv.autoresizingMask=UIViewAutoresizingDefault();
        imgv.contentMode=UIViewContentModeScaleAspectFit;
        imgv.backgroundColor=[UIColor clearColor];
        [self.backgroundView addSubview:imgv];
        
        imgvThumbnail=imgv;
    }
    
    CGRect rect=self.view.frame;
    rect.origin=CGPointZero;
    imgvThumbnail.frame=rect;
    
    UIImage *img=notification.userInfo[MPMoviePlayerThumbnailImageKey];
    
    if(img)
        imgvThumbnail.image=img;
}

-(void)dealloc
{
    if(_isRegisterNotification)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

@end
