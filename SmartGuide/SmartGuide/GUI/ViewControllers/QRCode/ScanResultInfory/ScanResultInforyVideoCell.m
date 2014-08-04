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
@synthesize suggestHeight,isCalculatingSuggestHeight;

-(void)calculatingSuggestHeight
{
    isCalculatingSuggestHeight=true;
    [self layoutSubviews];
    isCalculatingSuggestHeight=false;
}

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    _decode=decode;
    isCalculatingSuggestHeight=false;
    [self setNeedsLayout];
    [videoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(CGSizeEqualToSize(_decode.videoSize,CGSizeZero))
        _decode.videoSize=CGSizeResizeToWidth(320, CGSizeMake(_decode.videoWidth.floatValue, _decode.videoHeight.floatValue));

    [videoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    videoView.hidden=true;
    imgvPlay.hidden=false;
    
    [imgv l_v_setH:_decode.videoSize.height];
    [btn l_v_setH:_decode.videoSize.height];
    [videoView l_v_setH:_decode.videoSize.height];
    [imgvPlay l_v_setH:_decode.videoSize.height];
    
    if(!isCalculatingSuggestHeight)
        [imgv loadScanVideoThumbnailWithURL:_decode.videoThumbnail];
    
    suggestHeight=imgv.l_v_h+imgv.l_v_y+10;
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