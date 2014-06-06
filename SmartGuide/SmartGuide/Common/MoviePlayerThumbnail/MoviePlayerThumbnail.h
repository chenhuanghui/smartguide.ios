//
//  MoviePlayerThumbnail.h
//  Infory
//
//  Created by XXX on 6/6/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface MoviePlayerThumbnail : MPMoviePlayerController
{
    __weak UIImageView *imgvThumbnail;
    bool _isRegisterNotification;
}

@end
