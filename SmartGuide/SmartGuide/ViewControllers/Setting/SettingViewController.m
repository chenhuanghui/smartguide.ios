//
//  SettingViewController.m
//  SmartGuide
//
//  Created by XXX on 7/17/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "Constant.h"
#import "UIImageView+AFNetworking.h"
#import "DataManager.h"
#import "Utility.h"
#import "UIAlertTableCity.h"
#import "LocationManager.h"
#import "Flags.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init
{
    self = [super initWithNibName:NIB_PHONE(@"SettingViewController") bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    containView.backgroundColor=COLOR_BACKGROUND_APP;
    _settings=[[NSMutableArray alloc] init];
    
    lblName.text=[DataManager shareInstance].currentUser.name;
    
    //    SettingCellData *cell=[[SettingCellData alloc] init];
    //    cell.title=@"Nhận thông báo";
    //    cell.icon=[UIImage imageNamed:@"icon_notice.png"];
    //    [_settings addObject:cell];
    
    SettingCellData *cell=[[SettingCellData alloc] init];
    cell.title=@"Hướng dẫn sử dụng";
    cell.icon=[UIImage imageNamed:@"icon_shopmenu.png"];
    [_settings addObject:cell];
    
    cell=[[SettingCellData alloc] init];
    cell.title=@"Giới thiệu";
    cell.icon=[UIImage imageNamed:@"icon_intro.png"];
    [_settings addObject:cell];
    
    cell=[[SettingCellData alloc] init];
    cell.title=@"Cập nhật phiên bản";
    cell.icon=[UIImage imageNamed:@"icon_update.png"];
    [_settings addObject:cell];
    
    cell=[[SettingCellData alloc] init];
    cell.title=@"Đánh giá SmartGuide";
    cell.icon=[UIImage imageNamed:@"icon_report.png"];
    [_settings addObject:cell];
    
    [tableSetting registerNib:[UINib nibWithNibName:[SettingCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SettingCell reuseIdentifier]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActived:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void) appBecomeActived:(NSNotification*) notification
{
    [[LocationManager shareInstance] checkLocationAuthorize];
    
    switchLocation.delegate=nil;
    switchLocation.ON=[LocationManager shareInstance].isAllowLocation;
    switchLocation.delegate=self;
}

-(void)loadSetting
{
    lblCity.text=[DataManager shareInstance].currentCity.name;
    lblName.text=[DataManager shareInstance].currentUser.name;
    
    [[LocationManager shareInstance] checkLocationAuthorize];
    
    switchLocation.delegate=nil;
    switchLocation.ON=[LocationManager shareInstance].isAllowLocation;
    switchLocation.delegate=self;
    
    lblSP.text=@"";
    if(getTotalSP)
    {
        [getTotalSP cancel];
        getTotalSP=nil;
    }
    
    getTotalSP=[[ASIOperationGetTotalSP alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue];
    getTotalSP.delegatePost=self;
    
    [getTotalSP startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    ASIOperationGetTotalSP *ope=(ASIOperationGetTotalSP*)operation;
    lblSP.text=[[NSNumberFormatter numberFromNSNumber:@(ope.totalSP)] stringByAppendingString:@" P"];
    
    getTotalSP=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    getTotalSP=nil;
}

-(void)switchChanged:(SwitchSetting *)sw
{
    if(sw.ON && ![LocationManager shareInstance].isAllowLocation)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Location services is disabled" onOK:^{
            switchLocation.delegate=nil;
            switchLocation.ON=[LocationManager shareInstance].isAllowLocation;
            switchLocation.delegate=self;
        }];
    }
    else if(!sw.ON && [LocationManager shareInstance].isAllowLocation)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Location services is enabled" onOK:^{
            switchLocation.delegate=nil;
            switchLocation.ON=[LocationManager shareInstance].isAllowLocation;
            switchLocation.delegate=self;
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [avatar setSmartGuideImageWithURL:[NSURL URLWithString:[DataManager shareInstance].currentUser.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _settings.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell=[tableView dequeueReusableCellWithIdentifier:[SettingCell reuseIdentifier]];
    
    [cell setData:[_settings objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SettingCell height];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCellData *data=[_settings objectAtIndex:indexPath.row];
    
    if([data.title isEqualToString:@"Đánh giá SmartGuide"])
    {
        _isShowOtherView=true;
        
        FeedbackView *fbv=[[FeedbackView alloc] init];
        fbv.alpha=0;
        fbv.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2+20);
        fbv.delegate=self;
        
        [[RootViewController shareInstance].window addSubview:fbv];
        
        [UIView animateWithDuration:0.2f animations:^{
            fbv.alpha=1;
        }];
    }
    else if([data.title isEqualToString:@"Hướng dẫn sử dụng"])
    {
        [Flurry trackUserClickTutorial];
        
        _isShowOtherView=true;
        
        TutorialView *tutorial=[[TutorialView alloc] init];
        
        tutorial.alpha=0;
        tutorial.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        tutorial.delegate=self;
        
        [[RootViewController shareInstance].window addSubview:tutorial];
        
        [UIView animateWithDuration:0.2f animations:^{
            tutorial.alpha=1;
        }];
    }
    else if([data.title isEqualToString:@"Giới thiệu"])
    {
        _isShowOtherView=true;
        
        IntroView *intro=[[IntroView alloc] init];
        
        intro.alpha=0;
        intro.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        intro.delegate=self;
        
        [[RootViewController shareInstance].window addSubview:intro];
        
        [UIView animateWithDuration:0.2f animations:^{
            intro.alpha=1;
        }];
    }
}

-(void)introViewClose:(IntroView *)introView
{
    [UIView animateWithDuration:0.2 animations:^{
        introView.alpha=0;
    } completion:^(BOOL finished) {
        introView.delegate=nil;
        [introView removeFromSuperview];
        
        _isShowOtherView=false;
    }];
}

-(void)tutorialViewBack:(TutorialView *)tutorial
{
    tutorial.userInteractionEnabled=false;
    [UIView animateWithDuration:1.f animations:^{
        tutorial.alpha=0;
    } completion:^(BOOL finished) {
        tutorial.delegate=nil;
        [tutorial removeFromSuperview];
        
        _isShowOtherView=false;
    }];
}

-(void)feedbackViewBack:(FeedbackView *)feedbackView
{
    feedbackView.userInteractionEnabled=false;
    [UIView animateWithDuration:0.2f animations:^{
        feedbackView.alpha=0;
    } completion:^(BOOL finished) {
        feedbackView.delegate=nil;
        [feedbackView removeFromSuperview];
        
        _isShowOtherView=false;
    }];
}

- (void)viewDidUnload {
    tableSetting = nil;
    avatar = nil;
    switchLocation = nil;
    lblCity = nil;
    tableSetting = nil;
    containAvatar = nil;
    lblCity = nil;
    containView = nil;
    lblName = nil;
    [super viewDidUnload];
}

-(UITableView *)table
{
    return tableSetting;
}

- (IBAction)btnLocationTouchUpInside:(UIButton *)sender {
    UIAlertTableCity *alert=[[UIAlertTableCity alloc] initWithTitle:@"Thành phố" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    alert.selectedCity=[DataManager shareInstance].currentCity;
    
    [alert showOnOK:^{
        
        if([DataManager shareInstance].currentCity.idCity.integerValue!=alert.selectedCity.idCity.integerValue)
        {
            [self.view.window showLoadingWithTitle:nil];
            
            [RootViewController shareInstance].panSetting.enabled=false;
            [RootViewController shareInstance].tapSetting.enabled=false;
            
            [DataManager shareInstance].currentCity=alert.selectedCity;
            [Flags setUserCity:alert.selectedCity.idCity.integerValue];
            lblCity.text=alert.selectedCity.name;
            
            if([[RootViewController shareInstance].frontViewController.currentVisibleViewController isKindOfClass:[CatalogueBlockViewController class]])
            {
                __block __weak id obj = [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_CATALOGUEBLOCK_FINISHED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                    [self.view.window removeLoading];
                    
                    [[RootViewController shareInstance] hideSetting:nil];
                    
                    
                    [[NSNotificationCenter defaultCenter] removeObserver:obj];
                }];
                
                [[RootViewController shareInstance].frontViewController.catalogueBlock loadWithCity:[DataManager shareInstance].currentCity];
            }
            else if([[RootViewController shareInstance].frontViewController.currentVisibleViewController isKindOfClass:[CatalogueListViewController class]])
            {
                CatalogueListViewController *list=(CatalogueListViewController*)[RootViewController shareInstance].frontViewController.currentVisibleViewController;
                
                if(list.mode==LIST_SHOP)
                {
                    __block __weak id obj = [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_CATALOGUE_LIST_FINISHED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                        
                        [self.view.window removeLoading];
                        
                        [[NSNotificationCenter defaultCenter] removeObserver:obj];
                        
                        [[RootViewController shareInstance] hideSetting:nil];
                        [[RootViewController shareInstance].frontViewController.catalogueBlock setIsNeedLoad];
                    }];
                    
                    [list reloadDataForChangedCity:alert.selectedCity.idCity.integerValue];
                }
                else
                {
                    [self.view.window removeLoading];
                    
                    [[RootViewController shareInstance].frontViewController.catalogueBlock setIsNeedLoad];
                    [[RootViewController shareInstance] hideSetting:nil];
                }
            }
            else if([[RootViewController shareInstance].frontViewController.currentVisibleViewController isKindOfClass:[ShopDetailViewController class]])
            {
                [self.view.window removeLoading];
                
                [[RootViewController shareInstance].frontViewController.catalogueList setIsNeedReload];
                [[RootViewController shareInstance].frontViewController.catalogueBlock setIsNeedLoad];
                [[RootViewController shareInstance] hideSetting:nil];
            }
        }
    } onCancel:nil];
}

-(bool)isShowOtherView
{
    return _isShowOtherView;
}

@end