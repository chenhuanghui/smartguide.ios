//
//  ScanResultInforyVideoCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyVideoCell.h"
#import "ScanCodeDecode.h"
#import "ImageManager.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ScanResultInforyVideoCell()
{

}

@end

@implementation ScanResultInforyVideoCell

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    [videoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    videoView.hidden=true;
    _decode=decode;
    imgvPlay.hidden=false;
    [imgv loadScanVideoThumbnailWithURL:decode.videoThumbnail];
}

-(IBAction)btnTouchUpInside:(id)sender
{
    MPMoviePlayerController* player=[self.delegate scanResultInforyVideoCellRequestMoviePlayer:self];
    [player stop];
    [player.view removeFromSuperview];
    
    [player.view l_v_setO:CGPointZero];
    [player.view l_v_setS:videoView.l_v_s];
    [player setContentURL:URL(_decode.video)];
    
    videoView.hidden=false;
    imgvPlay.hidden=true;
    [videoView addSubview:player.view];
    
    [player play];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyVideoCell";
}

+(float)heightWithDecode:(ScanCodeDecode *)decode
{
    if(CGSizeEqualToSize(decode.videoSize,CGSizeZero))
        decode.videoSize=makeSizeProportional(320, CGSizeMake(decode.videoWidth.floatValue, decode.videoHeight.floatValue));
    
    return decode.videoSize.height+20;
}

@end

@implementation UITableView(ScanResultInforyVideoCell)

-(void)registerScanResultInforyVideoCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyVideoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyVideoCell reuseIdentifier]];
}

-(ScanResultInforyVideoCell *)scanResultInforyVideoCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyVideoCell reuseIdentifier]];
}

@end