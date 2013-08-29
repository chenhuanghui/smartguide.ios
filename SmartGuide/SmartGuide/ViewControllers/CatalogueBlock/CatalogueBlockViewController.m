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

@interface CatalogueBlockViewController ()

@end

@implementation CatalogueBlockViewController
@synthesize delegate;

-(id)init
{
    self=[super initWithNibName:@"CatalogueBlockViewController" bundle:nil];
    
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
    
    int idCity=[Flags userCity];
    if(idCity!=-1)
        [DataManager shareInstance].currentCity=[City cityWithID:idCity];
    
    [[LocationManager shareInstance] checkLocationAuthorize];
    
    //Nếu là lần đầu chạy app thì sẽ có alert xin location
    [[LocationManager shareInstance] tryGetUserLocationInfo];
    
    if([[LocationManager shareInstance] isAllowLocation])
    {
        [self.view showLoadingWithTitle:nil countdown:5 delegate:self].tagID=@(1);
    }
    else
    {
        [self.view showLoadingWithTitle:nil];
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
        [AlertView showAlertOKWithTitle:nil withMessage:@"Group empty" onOK:nil];
    }
}

-(void) detectCity:(NSString*) city
{
    operationCity=[[ASIOperationCity alloc] initOperationCity];
    operationCity.delegatePost=self;
    
    [operationCity startAsynchronous];
}

-(void) loadGroup:(NSString*) log
{
    NSLog(@"load group %@",log);
    
    ASIOperationGroupInCity *operaion=[[ASIOperationGroupInCity alloc] initWithIDCity:[DataManager shareInstance].currentCity.idCity.integerValue];
    operaion.delegatePost=self;
    [operaion startAsynchronous];
    
    if(delegate && [delegate respondsToSelector:@selector(catalogueBlockUpdated)])
    {
        [delegate catalogueBlockUpdated];
    }
    
    [self.view showLoadingWithTitle:nil];
}

-(void) updateBlocks
{
    ASIOperationGroupInCity *operaion=[[ASIOperationGroupInCity alloc] initWithIDCity:[DataManager shareInstance].currentCity.idCity.integerValue];
    operaion.delegatePost=self;
    [operaion startAsynchronous];

    [self.view showLoadingWithTitle:nil];
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
        
        for(Group *group in ope.groups)
        {
            UIView *groupView=[self groupViewWithIDGroup:group.idGroup.integerValue];
            
            UIButton *btn = [self badgeButton:groupView];
            int badge=group.count.integerValue;
            
            NSString *str=[NSString stringWithFormat:@"%02d",badge];
            if(badge>99)
                str=@"99+";
            
            [btn setTitle:str forState:UIControlStateNormal];
            btn.hidden=badge==0;
        }

        _isFinishedLoading=true;
        [self.view removeLoading];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CATALOGUEBLOCK_FINISHED object:nil];
    }
    else if([operation isKindOfClass:[ASIOperationCity class]])
    {
        [[DataManager shareInstance] setUserCity:[LocationManager shareInstance].userCurrentCity];
        [Flags setUserCity:[DataManager shareInstance].currentCity.idCity.integerValue];

        [self loadGroup:@"ASIOperaionPostFinished"];
        
        operationCity=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationCity class]])
    {
        _isFinishedLoading=true;
        
        [DataManager shareInstance].currentCity=[City HCMCity];
        [Flags setUserCity:[DataManager shareInstance].currentCity.idCity.integerValue];
        
        [self loadGroup:@"ASIOperaionPostFailed ASIOperationCity"];
        
        operationCity=nil;
    }
    else if([operation isKindOfClass:[ASIOperationGroupInCity class]])
    {
        [self.view showLoadingWithTitle:nil countdown:3 delegate:self];
        
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
    if([notification.name isEqualToString:NOTIFICATION_LOCATION_CITY_AVAILABLE])
    {
        [self.view showLoadingWithTitle:nil];
        
        NSString *userCity=notification.object;
        [self detectCity:userCity];
    }
    else if([notification.name isEqualToString:NOTIFICATION_LOCATION_AVAILABLE])
    {
        [DataManager shareInstance].currentUser.location=[LocationManager shareInstance].userLocation;
        
        if(![DataManager shareInstance].currentCity)
        {
            [self.view showLoadingWithTitle:nil countdown:5 delegate:self].tagID=@(2);
            [[LocationManager shareInstance] tryGetUserCityInfo];
        }
        else
            [self loadGroup:@"NOTIFICATION_LOCATION_AVAILABLE"];
    }
    else if([notification.name isEqualToString:NOTIFICATION_LOCATION_PERMISSION_DENIED])
    {
        [[LocationManager shareInstance] checkLocationAuthorize];
        
//        if(![[LocationManager shareInstance] isAuthorizeLocation] && ![Flags isFirstRunApp])
//        {
//            [AlertView showAlertOKWithTitle:nil withMessage:@"Setting to allow location" onOK:nil];
//        }
        
        [DataManager shareInstance].currentUser.location=CLLocationCoordinate2DMake(-1, -1);
        
        if(![DataManager shareInstance].currentCity)
        {
            [DataManager shareInstance].currentCity=[City HCMCity];
            [Flags setUserCity:[DataManager shareInstance].currentCity.idCity.integerValue];
        }
        
        [self loadGroup:@"NOTIFICATION_LOCATION_PERMISSION_DENIED"];
    }
    else if([notification.name isEqualToString:NOTIFICATION_USER_CHANGED_CITY])
    {
        [self updateBlocks];
    }
}

-(NSArray *)registerNotification
{
    return @[NOTIFICATION_LOCATION_CITY_AVAILABLE,NOTIFICATION_LOCATION_AUTHORIZE_CHANGED,NOTIFICATION_LOCATION_PERMISSION_DENIED,NOTIFICATION_LOCATION_AVAILABLE,NOTIFICATION_USER_CHANGED_CITY];
}

-(void)activityIndicatorCountdownEnded:(ActivityIndicator *)activityIndicator
{
    if([activityIndicator.tagID integerValue]==1)
    {
        [[LocationManager shareInstance] stopGetUserLocationInfo];
        [DataManager shareInstance].currentUser.location=CLLocationCoordinate2DMake(-1, -1);
        
        if(![DataManager shareInstance].currentCity)
            [DataManager shareInstance].currentCity=[City HCMCity];
        
        [self loadGroup:@"activityIndicatorCountdownEnded"];
    }
    else if([activityIndicator.tagID integerValue]==2)
    {
        [[LocationManager shareInstance] stopGetUserCityInfo];
        [DataManager shareInstance].currentCity=[City HCMCity];
        [Flags setUserCity:[DataManager shareInstance].currentCity.idCity.integerValue];
        
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

-(NSArray *)disableRightNavigationItems
{
    return @[@(ITEM_FILTER)];
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