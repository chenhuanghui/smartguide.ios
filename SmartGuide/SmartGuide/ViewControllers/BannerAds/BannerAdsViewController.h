//
//  BottomBlockViewController.h
//  SmartGuide
//
//  Created by XXX on 7/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "TableTemplate.h"
#import "Ads.h"
#import "ASIOperationGetAds.h"

@class DirectionObjectViewController;

@interface BannerAdsViewController : ViewController<UIScrollViewDelegate,TableTemplateDelegate,ASIOperationPostDelegate>
{
    __weak IBOutlet UIView *ray;
    __weak IBOutlet UIButton *btnLeft;
    __weak IBOutlet UIButton *btnRight;
    __weak IBOutlet UITableView *tableAds;
    __weak IBOutlet UIView *animationView;
    __weak IBOutlet UIView *borderMap;
    
    TableTemplate *templateAds;
    ASIOperationGetAds *_opearationAds;
    
    CGPoint pntAds;
    CGPoint pntRay;
    CGPoint pntSelf;
    CGPoint pntLeft;
    CGPoint pntRight;
    CGPoint pntGrid;
    float height;
    CGPoint pntMap;
}

+(CGSize) size;

-(void) prepareShowMap;
-(void) prepareHideMap;
-(void) showMap;
-(void) hideMap;
-(void) hideMap:(bool) animate;
-(void) addMap;
-(void) removeMap;
- (IBAction)btnLeftTouchUpInside:(id)sender;
- (IBAction)btnRightTouchUpInside:(id)sender;
-(void) prepareAnimationShowShopDetail;
-(void) animationShowShopDetail:(void(^)(BOOL finished)) completed;
-(void) animationShowShopDetail:(bool) animated completed:(void (^)(BOOL))completed;
-(void) animationHideShopDetail;

@end

@interface BannerAdsView : UIView

@end