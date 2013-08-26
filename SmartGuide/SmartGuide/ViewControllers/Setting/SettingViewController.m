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
    self = [super initWithNibName:@"SettingViewController" bundle:nil];
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
    
    [[LocationManager shareInstance] checkLocationAuthorize];
    
    switchLocation.delegate=nil;
    switchLocation.ON=[LocationManager shareInstance].isAllowLocation;
    switchLocation.delegate=self;
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
        FeedbackView *fbv=[[FeedbackView alloc] init];
        fbv.alpha=0;
        fbv.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        fbv.delegate=self;
        
        [self.view addSubview:fbv];
        
        [UIView animateWithDuration:0.2f animations:^{
            fbv.alpha=1;
        }];
    }
}

-(void)feedbackViewBack:(FeedbackView *)feedbackView
{
    [UIView animateWithDuration:0.2f animations:^{
        feedbackView.alpha=0;
    } completion:^(BOOL finished) {
        [feedbackView removeFromSuperview];
    }];
}

- (void)viewDidUnload {
    tableSetting = nil;
    avatar = nil;
    lblPoint = nil;
    lblSGP = nil;
    switchLocation = nil;
    lblCity = nil;
    lblAddress = nil;
    tableSetting = nil;
    containAvatar = nil;
    lblCity = nil;
    containView = nil;
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
        [DataManager shareInstance].currentCity=alert.selectedCity;
        [Flags setUserCity:alert.selectedCity.idCity.integerValue];
        lblCity.text=alert.selectedCity.name;
    } onCancel:nil];
}


@end