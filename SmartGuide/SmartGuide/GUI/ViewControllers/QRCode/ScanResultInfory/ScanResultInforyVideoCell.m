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
    _object=decode;
    
    [imgv defaultLoadImageWithURL:_object.videoThumbnail];
    
    [self setNeedsLayout];
}

-(float)calculatorHeight:(ScanCodeDecode *)object
{
    if(CGSizeIsZero(object.videoSize))
        object.videoSize=CGSizeResizeToWidth(UIApplicationSize().width, CGSizeMake(object.videoWidth.floatValue, object.videoHeight.floatValue));
    
    imgv.frame=CGRectMake(0, 10, self.SW, object.videoSize.height);
    btn.frame=CGRectMake(0, 10, self.SW, object.videoSize.height);
    videoView.frame=CGRectMake(0, 10, self.SW, object.videoSize.height);
    imgvPlay.frame=CGRectMake(0, 10, self.SW, object.videoSize.height);
    
    return imgv.yh+imgv.OY;
}

-(void)layoutSubviews
{
    if(_isPrototypeCell)
        return;
    
    [super layoutSubviews];

    [videoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    videoView.hidden=true;
    imgvPlay.hidden=false;
    
    [self calculatorHeight:_object];
}

-(IBAction)btnTouchUpInside:(id)sender
{
    MPMoviePlayerController* player=[self.delegate scanResultInforyVideoCellRequestMoviePlayer:self];
    [player stop];
    [player.view removeFromSuperview];
    
    [player.view l_v_setO:CGPointZero];
    [player.view l_v_setS:videoView.l_v_s];
    [player setContentURL:URL(_object.video)];
    
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

#import <objc/runtime.h>
static char ScanResultInforyVideoPrototypeCellKey;
@implementation UITableView(ScanResultInforyVideoCell)

-(void)registerScanResultInforyVideoCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyVideoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyVideoCell reuseIdentifier]];
}

-(ScanResultInforyVideoCell *)scanResultInforyVideoCell
{
    ScanResultInforyVideoCell *obj=[self dequeueReusableCellWithIdentifier:[ScanResultInforyVideoCell reuseIdentifier]];
    
    obj.isPrototypeCell=false;
    
    return obj;
}

-(ScanResultInforyVideoCell *)scanResultInforyVideoPrototypeCell
{
    ScanResultInforyVideoCell *obj=objc_getAssociatedObject(self, &ScanResultInforyVideoPrototypeCellKey);
    
    if(!obj)
    {
        obj=[self scanResultInforyVideoCell];
        objc_setAssociatedObject(self, &ScanResultInforyVideoPrototypeCellKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.isPrototypeCell=true;
    
    return obj;
}

@end