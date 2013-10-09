//
//  BottomBlockViewController.m
//  SmartGuide
//
//  Created by XXX on 7/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "BannerAdsViewController.h"
#import "Utility.h"
#import "DirectionObjectViewController.h"
#import "SlideQRCodeViewController.h"
#import "NavigationBarView.h"
#import "GMGridViewLayoutStrategies.h"
#import "RootViewController.h"
#import "BannerAdsCell.h"

@interface BannerAdsViewController ()

@property (nonatomic, readonly) DirectionObjectViewController *direction;

@end

@implementation BannerAdsViewController
@synthesize direction;

- (id)init
{
    self = [super initWithNibName:@"BannerAdsViewController" bundle:nil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"Bản đồ";

    ray.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ray_blue.png"]];
    
    CGRect rect=tableAds.frame;
    tableAds.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*6));
    tableAds.frame=rect;
    
    self.view.layer.masksToBounds=true;
    borderMap.layer.cornerRadius=8;
    borderMap.layer.masksToBounds=true;
    borderMap.frame=CGRECT_PHONE(borderMap.frame, CGRectMake(borderMap.frame.origin.x, borderMap.frame.origin.y-95, borderMap.frame.size.width, borderMap.frame.size.height+95));
    
    [tableAds registerNib:[UINib nibWithNibName:[BannerAdsCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[BannerAdsCell reuseIdentifier]];
    
    templateAds=[[TableTemplate alloc] initWithTableView:tableAds withDelegate:self];
    
    [self getAds];
}

-(void) getAds
{
    if(_opearationAds)
    {
        [_opearationAds cancel];
        _opearationAds=nil;
    }
    
    _opearationAds=[[ASIOperationGetAds alloc] initAds];
    _opearationAds.delegatePost=self;
    
    [_opearationAds startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    ASIOperationGetAds *ope=(ASIOperationGetAds*)operation;
    
    [templateAds.datasource addObjectsFromArray:ope.arrAds];
    [tableAds reloadData];
    
    _opearationAds=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    _opearationAds=nil;
    
    //reload ads sau 10s neu load du lieu ko thanh cong
    double delayInSeconds = 10.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self getAds];
    });
}

-(bool)tableTemplateAllowLoadMore:(TableTemplate *)tableTemplate
{
    return false;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(loop) withObject:nil afterDelay:DURATION_ADS_CHANGE];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self performSelector:@selector(loop) withObject:nil afterDelay:DURATION_ADS_CHANGE];
}

-(void) loop
{
    [self moveToPage:tableAds.currentPageForHoriTable+1];
    
    [self performSelector:@selector(loop) withObject:nil afterDelay:DURATION_ADS_CHANGE];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return templateAds.datasource.count>0?templateAds.datasource.count*2:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index=indexPath.row;
    
    while (index>=templateAds.datasource.count) {
        index-=templateAds.datasource.count;
    }
    
    BannerAdsCell *cell=[tableAds dequeueReusableCellWithIdentifier:[BannerAdsCell reuseIdentifier]];
    Ads *ads=[templateAds.datasource objectAtIndex:index];
    
    [cell setURL:ads.image_url page:index completed:^{
    }];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index=indexPath.row;
    
    while (index>=templateAds.datasource.count) {
        index-=templateAds.datasource.count;
    }
    
    Ads *ads=[templateAds.datasource objectAtIndex:index];
    
    if(ads.url.length>0)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ads.url]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [BannerAdsCell size].width;
}

-(void)addMap
{
    self.direction.mapView.showsUserLocation=true;
    if(self.direction.view.superview==self.view)
        return;
    
    if(self.direction.view.superview)
        [self.direction.view removeFromSuperview];
    
    [self.direction setFrame:CGRectMake(2, 2, borderMap.frame.size.width-4, borderMap.frame.size.height-4)];
    [borderMap addSubview:self.direction.view];
    self.direction.view.layer.cornerRadius=borderMap.layer.cornerRadius;
    self.direction.view.layer.masksToBounds=true;
    self.direction.mapView.showsUserLocation=true;
}

-(void)removeMap
{
    self.direction.mapView.showsUserLocation=false;
    [self.direction.view removeFromSuperview];
}

- (IBAction)btnLeftTouchUpInside:(id)sender {
    [self moveToPage:tableAds.currentPageForHoriTable-1];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(loop) withObject:0 afterDelay:DURATION_ADS_CHANGE];
}

-(void) moveToPage:(int) page
{
    btnLeft.userInteractionEnabled=false;
    btnRight.userInteractionEnabled=false;
    
    [tableAds scrollToPageForHoriTable:page];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    btnLeft.userInteractionEnabled=true;
    btnRight.userInteractionEnabled=true;
    
    if(tableAds.currentPageForHoriTable==templateAds.datasource.count)
    {
        [tableAds scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
    }
}

- (IBAction)btnRightTouchUpInside:(id)sender {
    [self moveToPage:tableAds.currentPageForHoriTable+1];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(loop) withObject:0 afterDelay:DURATION_ADS_CHANGE];
}

-(void)prepareShowMap
{
    [self addMap];
    
    height=[UIScreen mainScreen].bounds.size.height;
    height-=20;
    height-=[NavigationBarView height];
    height-=[[RootViewController shareInstance] heightAds_QR];
    
    pntRay=ray.center;
    pntSelf=self.view.center;
    pntLeft=btnLeft.center;
    pntRight=btnRight.center;
    pntGrid=tableAds.center;
    pntMap=borderMap.center;
}

-(void) showMap
{
    self.view.center=CGPointMake(pntSelf.x, pntSelf.y-height/2);
    
    CGRect rect=self.view.bounds;
    rect.size.height+=height;
    self.view.bounds=rect;
    
    btnLeft.center=CGPointMake(pntLeft.x, pntLeft.y+height);
    btnRight.center=CGPointMake(pntRight.x, pntRight.y+height);
    tableAds.center=CGPointMake(pntGrid.x, pntGrid.y+height);
    borderMap.center=CGPointMake(pntMap.x, pntMap.y+height);
}

-(void)prepareHideMap
{
    //    pntAds=btnAds.center;
    //    pntRay=ray.center;
    //    pntSelf=self.view.center;
    //    pntLeft=btnLeft.center;
    //    pntRight=btnRight.center;
    //    pntGrid=gridAds.center;
    //
    //    UIView *map=[self.view viewWithTag:112];
    //    //    map.center=CGPointMake(map.center.x, map.center.y-300);
    //    pntMap=map.center;
    //
    //    height=[UIScreen mainScreen].bounds.size.height;
    //    height-=33;
    //    height-=[BannerAdsViewController size].height;
    //    height-=[SlideQRCodeViewController size].height;
    //
    //    pntSelf.y+=height/2;
    //    pntAds.y-=height;
    //    pntRay.y-=height;
    //    pntMap.y-=height;
    //    pntLeft.y-=height;
    //    pntRight.y-=height;
    //    pntGrid.y-=height;
}

-(void)hideMap:(bool)animate
{
    if(animate)
    {
        [UIView animateWithDuration:DURATION_SHOW_MAP animations:^{
            self.view.center=pntSelf;
            
            CGRect rect=self.view.bounds;
            rect.size.height-=height;
            self.view.bounds=rect;
            
            btnLeft.center=pntLeft;
            btnRight.center=pntRight;
            tableAds.center=pntGrid;
            borderMap.center=pntMap;
        } completion:^(BOOL finished) {
            //finished fail khi map dang animation an nhung user lai click show map
            
            if(finished)
                [self removeMap];
        }];
    }
    else
    {
        self.view.center=pntSelf;
        
        CGRect rect=self.view.bounds;
        rect.size.height-=height;
        self.view.bounds=rect;
        
        btnLeft.center=pntLeft;
        btnRight.center=pntRight;
        tableAds.center=pntGrid;
        borderMap.center=pntMap;
        
        [self removeMap];
    }
}

-(void)hideMap
{
    [self hideMap:true];
}

+(CGSize)size
{
    return CGSizeMake(320, 87);
}

- (void)viewDidUnload {
    ray = nil;
    btnLeft = nil;
    btnRight = nil;
    tableAds = nil;
    animationView = nil;
    borderMap = nil;
    tableAds = nil;
    [super viewDidUnload];
}

-(void)prepareAnimationShowShopDetail
{
    CGRect rect=animationView.frame;
    rect.origin.y=-rect.size.height;
    animationView.frame=rect;
    animationView.hidden=false;
}

-(void) animationShowShopDetail:(bool) animated completed:(void (^)(BOOL))completed
{
    if(animated)
    {
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            CGRect rect=animationView.frame;
            rect.origin.y=0;
            animationView.frame=rect;
            
            rect=ray.frame;
            rect.origin.y=self.view.frame.size.height;
            ray.frame=rect;
        } completion:completed];
    }
    else
    {
        CGRect rect=animationView.frame;
        rect.origin.y=0;
        animationView.frame=rect;
        
        rect=ray.frame;
        rect.origin.y=self.view.frame.size.height;
        ray.frame=rect;
    }
}

-(void)animationShowShopDetail:(void (^)(BOOL))completed
{
    [self animationShowShopDetail:true completed:completed];
}

-(void)animationHideShopDetail
{
    self.view.hidden=false;
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        CGRect rect=animationView.frame;
        rect.origin.y=-rect.size.height;
        animationView.frame=rect;
        
        rect=ray.frame;
        rect.origin.y=0;
        ray.frame=rect;
    }];
}

-(NSArray *)rightNavigationItems
{
    return @[@(ITEM_FILTER),@(ITEM_COLLECTION),@(ITEM_LIST)];
}

-(NSArray *)disableRightNavigationItems
{
    return @[@(ITEM_FILTER)];
}

-(DirectionObjectViewController*) direction
{
    return [RootViewController shareInstance].directionObject;
}

@end

@implementation BannerAdsView



@end