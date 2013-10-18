//
//  CatalogueBlockViewController.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "CatalogueBlockViewController.h"
#import "AlertView.h"
#import "CatalogueListViewController.h"
#import "LocationManager.h"
#import "DataManager.h"
#import "City.h"
#import "MapView.h"
#import "Flags.h"
#import "LocationManager.h"
#import "UIImageView+AFNetworking.h"
#import "ActivityIndicator.h"
#import "Utility.h"

@interface CatalogueBlockViewController ()

@end

@implementation CatalogueBlockViewController
@synthesize delegate;

-(id)init
{
    self=[super initWithNibName:NIB_PHONE(@"CatalogueBlockViewController") bundle:nil];
    
    return self;
}

-(void)loadWithCity:(City *)city
{
    [self loadGroup:@"changed city"];
}

-(NSArray*) groupViews
{
    return @[groupAll,groupDrink,groupEducation,groupEntertaiment,groupFashion,groupFood,groupHealth,groupProduction,groupTravel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"DANH MỤC";
    
    for(City *city in [City allObjects])
    {
        [[DataManager shareInstance].managedObjectContext deleteObject:city];
    }
    
    [[DataManager shareInstance] save];
    
    City *city=[City insert];
    city.name=@"Hồ Chí Minh";
    city.idCity=@(1);
    
    [[DataManager shareInstance] save];
    
    [DataManager shareInstance].currentCity=[City cityWithID:1];
    
    [[LocationManager shareInstance] checkLocationAuthorize];
    
    //Nếu là lần đầu chạy app thì sẽ có alert xin location
    [[LocationManager shareInstance] tryGetUserLocationInfo];
    
    if([[LocationManager shareInstance] isAllowLocation])
    {
        CGRect rect=[RootViewController shareInstance].rootContaintView.frame;
        rect.origin=CGPointZero;
        if([UIScreen mainScreen].bounds.size.height==480)
        {
            rect.size.height-=60;
        }
        else
        {
            rect.size.width-=3;
            rect.size.height-=65;
        }
        
        [[RootViewController shareInstance].rootContaintView showLoadingWithTitle:Nil countdown:5 delegate:self rect:rect].tagID=@(1);
    }
    else
    {
        CGRect rect=[RootViewController shareInstance].rootContaintView.frame;
        rect.origin=CGPointZero;
        if([UIScreen mainScreen].bounds.size.height==480)
        {
            rect.size.height-=60;
        }
        else
        {
            rect.size.width-=3;
            rect.size.height-=65;
        }
        
        [[RootViewController shareInstance].rootContaintView showLoadingWithTitle:nil rect:rect];
        if(![[LocationManager shareInstance] isLocationServicesEnabled])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOCATION_PERMISSION_DENIED object:nil];
        }
    }
    
    self.view.backgroundColor=COLOR_BACKGROUND_APP;
    
    for(UIView* groupView in [self groupViews])
    {
        UIButton *btn=[self iconButton:groupView];
        [btn addTarget:self action:@selector(iconTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        btn=[self badgeButton:groupView];
        [btn setTitle:@"--" forState:UIControlStateNormal];
    }
}

-(void) iconTouchUpInside:(UIButton*) sender
{
    //clear hinh anh loading bi loi khi load tu server. Khi hinh anh bi loi khi load tu server thi mac dinh se dung UIIMAGE_IMAGE_EMPTY de tranh load lai hinh loi->lag
    [[AFImageCache af_sharedImageCache] clearEmptyImage];
    
    UIView *groupView=sender.superview;
    
    Group *group=[self groupWithView:groupView];
    
    if(group.count.integerValue>0)
    {
        if(delegate && [delegate respondsToSelector:@selector(catalogueBlockDidSelectedGroup:)])
            [delegate catalogueBlockDidSelectedGroup:[self groupWithView:groupView]];
    }
    else
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Danh mục hiện không có khuyến mãi" onOK:nil];
    }
}

-(void) loadGroup:(NSString*) log
{
    NSLog(@"load group %@",log);
    
    [self updateBlocks];
    
    if(delegate && [delegate respondsToSelector:@selector(catalogueBlockUpdated)])
    {
        [delegate catalogueBlockUpdated];
    }
    
    CGRect rect=[RootViewController shareInstance].rootContaintView.frame;
    rect.origin=CGPointZero;
    if([UIScreen mainScreen].bounds.size.height==480)
    {
        rect.size.height-=60;
    }
    else
    {
        rect.size.width-=3;
        rect.size.height-=65;
    }
    
    [[RootViewController shareInstance].rootContaintView showLoadingWithTitle:nil rect:rect];
}

-(void) updateBlocks
{
    if(_operationGroupInCity)
    {
        [_operationGroupInCity cancel];
        _operationGroupInCity=nil;
    }
    
    _operationGroupInCity=[[ASIOperationGroupInCity alloc] initWithIDCity:[DataManager shareInstance].currentCity.idCity.integerValue];
    _operationGroupInCity.delegatePost=self;
    [_operationGroupInCity startAsynchronous];
    
    CGRect rect=[RootViewController shareInstance].rootContaintView.frame;
    rect.origin=CGPointZero;
    if([UIScreen mainScreen].bounds.size.height==480)
    {
        rect.size.height-=60;
    }
    else
    {
        rect.size.width-=3;
        rect.size.height-=65;
    }
    
    [[RootViewController shareInstance].rootContaintView showLoadingWithTitle:nil rect:rect];
}

-(UIButton*) iconButton:(UIView*) groupView
{
    return (UIButton*)[groupView viewWithTag:3];
}

-(UIButton*) badgeButton:(UIView*) groupView
{
    return (UIButton*)[groupView viewWithTag:1];
}

-(UILabel*) labelName:(UIView*) groupView
{
    return (UILabel*)[groupView viewWithTag:2];
}

-(Group*) groupWithView:(UIView*) groupView
{
    if(groupView==groupFood)
        return [Group groupWithIDGroup:1];
    else if(groupView==groupDrink)
        return [Group groupWithIDGroup:2];
    else if(groupView==groupHealth)
        return [Group groupWithIDGroup:3];
    else if(groupView==groupEntertaiment)
        return [Group groupWithIDGroup:4];
    else if(groupView==groupFashion)
        return [Group groupWithIDGroup:5];
    else if(groupView==groupTravel)
        return [Group groupWithIDGroup:6];
    else if(groupView==groupProduction)
        return [Group groupWithIDGroup:7];
    else if(groupView==groupEducation)
        return [Group groupWithIDGroup:8];
    
    return [Group groupAll];
}

-(UIView*) groupViewWithIDGroup:(int) idGroup
{
    switch (idGroup) {
        case 1:
            return groupFood;
        case 2:
            return groupDrink;
        case 3:
            return groupHealth;
        case 4:
            return groupEntertaiment;
        case 5:
            return groupFashion;
        case 6:
            return groupTravel;
        case 7:
            return groupProduction;
        case 8:
            return groupEducation;
            
        default:
            return groupAll;
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationGroupInCity class]])
    {
        ASIOperationGroupInCity *ope = (ASIOperationGroupInCity*)operation;
        
        if(ope.groupStatus==0)
        {
            [RootViewController shareInstance].window.userInteractionEnabled=false;
            
            UIImageView *imgv=nil;
            if(!_launchingView)
            {
                CGRect rect=CGRECT_PHONE(CGRectMake(0, 0, 320, 328), CGRectMake(0, 0, 320, 400));
                _launchingView=[[UIView alloc] initWithFrame:rect];
                _launchingView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
                _launchingView.alpha=0;
                
                imgv=[[UIImageView alloc] initWithFrame:rect];
                imgv.contentMode=UIViewContentModeScaleAspectFit;
                
                [_launchingView addSubview:imgv];
            }
            else
            {
                imgv=(UIImageView*)[_launchingView.subviews objectAtIndex:0];
            }
            
            imgv.image=nil;
            
            __weak UIImageView *_weakImgv=imgv;
            
            [imgv setImageWithLoading:[NSURL URLWithString:ope.groupUrl] emptyImage:nil success:^(UIImage *image) {
                [[RootViewController shareInstance].rootContaintView removeLoading];
                _weakImgv.image=image;
                
                if(!_launchingView.superview)
                    [self.view addSubview:_launchingView];
                
                [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                    _launchingView.alpha=1;
                }];
            } failure:^(UIImage *emptyImage) {
                
            }];
            
            __block __weak id obs=[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                
                [self updateBlocks];
                
                [[NSNotificationCenter defaultCenter] removeObserver:obs];
            }];
        }
        else
        {
            if(_launchingView)
            {
                [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                    _launchingView.alpha=0;
                } completion:^(BOOL finished) {
                    [_launchingView removeFromSuperview];
                    _launchingView=nil;
                }];
                
                [RootViewController shareInstance].window.userInteractionEnabled=true;
            }
            
            for(Group *group in ope.groups)
            {
                UIView *groupView=[self groupViewWithIDGroup:group.idGroup.integerValue];
                
                UIButton *btn = [self badgeButton:groupView];
                int badge=group.count.integerValue;
                
                NSString *str=@"";
                if(badge>0)
                    str=[NSString stringWithFormat:@"%02d",badge];
                else
                    str=@"0";
                
                if(badge>99)
                    str=@"99+";
                
                [btn setTitle:str forState:UIControlStateNormal];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CATALOGUEBLOCK_FINISHED object:nil];
        }
        
        _isFinishedLoading=true;
        [[RootViewController shareInstance].rootContaintView removeLoading];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationGroupInCity class]])
    {
        CGRect rect=[RootViewController shareInstance].rootContaintView.frame;
        rect.origin=CGPointZero;
        if([UIScreen mainScreen].bounds.size.height==480)
        {
            rect.size.height-=60;
        }
        else
        {
            rect.size.width-=3;
            rect.size.height-=65;
        }
        
        [[RootViewController shareInstance].rootContaintView showLoadingWithTitle:nil countdown:3 delegate:self rect:rect];
        
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self loadGroup:@"ASIOperaionPostFailed ASIOperationGroupInCity"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CATALOGUEBLOCK_FINISHED object:nil];
        });
    }
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_LOCATION_AVAILABLE])
    {
        [DataManager shareInstance].currentUser.location=[LocationManager shareInstance].userLocation;
        [self loadGroup:@"NOTIFICATION_LOCATION_AVAILABLE"];
        
        [self showTutorial];
    }
    else if([notification.name isEqualToString:NOTIFICATION_LOCATION_PERMISSION_DENIED])
    {
        [DataManager shareInstance].currentUser.location=CLLocationCoordinate2DMake(-1, -1);
        [self loadGroup:@"NOTIFICATION_LOCATION_PERMISSION_DENIED"];
        
        [self showTutorial];
    }
}

-(void) showTutorial
{
    if(![Flags isShowedTutorial])
    {
        [Flags setIsShowedTutorial:true];
        
        TutorialView *tutorial=[[TutorialView alloc] init];
        tutorial.alpha=0;
        tutorial.delegate=self;
        tutorial.isHideClose=false;
        
        [self.view.window addSubview:tutorial];
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            tutorial.alpha=1;
        }];
    }
}
-(void)tutorialViewBack:(TutorialView *)tutorial
{
    tutorial.userInteractionEnabled=false;
    [UIView animateWithDuration:0.2f animations:^{
        tutorial.alpha=0;
    } completion:^(BOOL finished) {
        [tutorial removeFromSuperview];
    }];
}

-(NSArray *)registerNotification
{
    return @[NOTIFICATION_LOCATION_AUTHORIZE_CHANGED,NOTIFICATION_LOCATION_PERMISSION_DENIED,NOTIFICATION_LOCATION_AVAILABLE];
}

-(void)activityIndicatorCountdownEnded:(ActivityIndicator *)activityIndicator
{
    if([activityIndicator.tagID integerValue]==1)
    {
        [[LocationManager shareInstance] stopGetUserLocationInfo];
        [DataManager shareInstance].currentUser.location=CLLocationCoordinate2DMake(-1, -1);
        
        [self loadGroup:@"activityIndicatorCountdownEnded"];
    }
}

-(bool)isFinishedLoading
{
    return _isFinishedLoading;
}

- (void)viewDidUnload {
    groupAll = nil;
    groupFood = nil;
    groupHealth = nil;
    groupEntertaiment = nil;
    groupFashion = nil;
    groupTravel = nil;
    groupProduction = nil;
    groupEducation = nil;
    groupDrink=nil;
    [super viewDidUnload];
}

-(NSArray *)rightNavigationItems
{
    return @[@(ITEM_FILTER),@(ITEM_COLLECTION),@(ITEM_MAP)];
}

-(void)setIsNeedLoad
{
    _isNeedLoad=true;
}

-(void)catalogueShowed
{
    if(_isNeedLoad)
    {
        [self updateBlocks];
    }
}

@end

@implementation BlockView



@end