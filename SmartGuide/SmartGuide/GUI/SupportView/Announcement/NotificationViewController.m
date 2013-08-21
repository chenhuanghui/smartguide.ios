//
//  AnnouncementViewController.m
//  SmartGuide
//
//  Created by XXX on 7/15/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

#import <QuartzCore/QuartzCore.h>
#import "Utility.h"
#import "Constant.h"

#define ANNOUNCEMENT_DURATION 2.5f

@interface NotificationViewController ()

-(void) alignLayout;

@property (nonatomic,strong) UIImage *_image;
@property (nonatomic,strong) NSString *_content;
@property (nonatomic,strong) NSURL *_url;

@end

@implementation NotificationViewController
@synthesize closedWhenTouched,tag,_image,_content,_url;

-(NotificationViewController *)initWithType:(enum NOTIFICATION_TYPE)announType withImage:(UIImage *)image withContent:(NSString *)content
{
    self=[super initWithNibName:@"NotificationViewController" bundle:nil];
    
    _type=announType;
    self._image=image;
    self._content=content;
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    imgv.image=self._image;
    txtContent.text=self._content;
    
    switch (_type) {
        case NOTIFICATION_ERROR:
            self.view.backgroundColor=[UIColor redColor];
            break;
            
        case NOTIFICATION_WARNING:
            self.view.backgroundColor=[UIColor yellowColor];
            break;
            
        default:
            self.view.backgroundColor=[UIColor blueColor];
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ANNOUNCEMENT_SHOWED object:self];
    
    [self alignLayout];
    
    [self.view scaleToSmall:0.5f];
    
    self.view.alpha=0.3f;
    [UIView animateWithDuration:0.5f animations:^{
        self.view.alpha=1;
    }];
}

-(void)alignLayout
{
    if(!imgv.image)
    {
        imgv.hidden=true;
        txtContent.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    else
    {
        imgv.hidden=false;
        txtContent.frame=CGRectMake(44, 0, self.view.frame.size.width-44, self.view.frame.size.height);
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!closedWhenTouched)
        [self performSelector:@selector(hide) withObject:nil afterDelay:ANNOUNCEMENT_DURATION];
}

-(void) hide
{
    [self.view setUserInteractionEnabled:false];
    [UIView animateWithDuration:0.5f animations:^{
        self.view.alpha=0.3f;
    } completion:^(BOOL finished) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ANNOUNCEMENT_HIDED object:self];
        
        [self.view removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ANNOUNCEMENT_TOUCHED object:self];
    [self hide];
}

-(void)viewDidUnload
{
    imgv = nil;
    txtContent = nil;
    [super viewDidUnload];
    
    self.tag=nil;
}

-(enum NOTIFICATION_TYPE)type
{
    return _type;
}

@end