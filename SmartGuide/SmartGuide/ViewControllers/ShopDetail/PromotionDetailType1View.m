//
//  PromotionDetailView.m
//  SmartGuide
//
//  Created by XXX on 8/1/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PromotionDetailType1View.h"
#import "PromotionDetailCell.h"
#import "PromotionDetail.h"
#import "PromotionRequire.h"
#import "AlertView.h"
#import "RootViewController.h"
#import "SlideQRCodeViewController.h"

@implementation PromotionDetailType1View
@synthesize handler;

-(PromotionDetailType1View *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"PromotionDetailType1View" owner:nil options:nil] objectAtIndex:0];
    
    [self setShop:shop];
    [tableRank registerNib:[UINib nibWithNibName:[PromotionDetailCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PromotionDetailCell reuseIdentifier]];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"cost"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor color255WithRed:123 green:124 blue:120 alpha:255];
    style.font=[UIFont boldSystemFontOfSize:10];
    
    [lblCost addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"a"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor color255WithRed:123 green:124 blue:120 alpha:255];
    style.font=[UIFont systemFontOfSize:7];
    [lblCost addStyle:style];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userScanedQRCode:) name:NOTIFICATION_USER_SCANED_QR_CODE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userScanedQRCode:) name:NOTIFICATION_USER_CANCELED_SCAN_QR_CODE object:nil];
    
    return self;
}

-(void)setShop:(Shop *)shop
{
    if(!shop)
    {
        [self reset];
        return;
    }
    
    _shop=shop;
    
    _isNeedAnimaionScore=false;
    
    lblDuration.text=_shop.promotionDetail.duration;
    lblSgp.text=[NSString stringWithFormat:@"%lld",_shop.promotionDetail.sgp.longLongValue];
    lblSP.text=[NSString stringWithFormat:@"%lld",_shop.promotionDetail.sp.longLongValue];
    
    [lblCost setText:[NSString stringWithFormat:@"<cost>%@</cost><a>/1SGP</a>",[NSNumberFormatter moneyFromNSNumber:_shop.promotionDetail.cost]]];
    
    [tableRank reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _shop==nil?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shop.promotionDetail.requiresObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromotionDetailCell *cell=[tableRank dequeueReusableCellWithIdentifier:[PromotionDetailCell reuseIdentifier]];
    PromotionRequire *require=[_shop.promotionDetail.requiresObjects objectAtIndex:indexPath.row];
    
    [cell setSGP:require.sgpRequired.longLongValue content:require.content hightlighted:_shop.promotionDetail.sgp.longLongValue>=require.sgpRequired.longLongValue];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PromotionDetailCell height]+6;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    double currentSGP=_shop.promotionDetail.sgp.doubleValue;
    
    PromotionRequire *require=[_shop.promotionDetail.requiresObjects objectAtIndex:indexPath.row];
    double sgpRequire=require.sgpRequired.doubleValue;
    
    if(currentSGP<sgpRequire)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Không đủ sgp" onOK:nil];
        return;
    }
    
    int idReward=require.idRequire.integerValue;
    [[RootViewController shareInstance].slideQRCode scanGetAwardPromotion1WithIDAward:idReward];
    
    [self showLoadingWithTitle:@"Wait scan QRCode"];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationSGPToReward class]])
    {
        ASIOperationSGPToReward *ope=(ASIOperationSGPToReward*)operation;
        
        if(ope.status==0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:ope.content onOK:nil];
            return;
        }
        else if(ope.status==1)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:ope.content onOK:nil];
            return;
        }
        else if(ope.status==2)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:ope.content onOK:^{
                
                _shop.promotionDetail.sgp=@(ope.totalSGP);
                
                [[DataManager shareInstance] save];
                
                [self animationScore];
            }];
        }
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self removeLoading];
}

-(void)setSGP:(double)sgp
{
    
}

-(void)reset
{
    _shop=nil;
    [tableRank reloadData];
    lblDuration.text=@"";
    lblSgp.text=@"";
    lblSP.text=@"";
    _isNeedAnimaionScore=false;
}

-(void)reloadWithShop:(Shop *)shop
{
    [self setShop:shop];
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(_isNeedAnimaionScore)
    {
        [self animationScore];
        
        _isNeedAnimaionScore=false;
    }
}

-(void) animationScore
{
    if(_shop)
    {
        [lblSgp stopAnimationScore];
        
        if(!_scoreFormater)
        {
            _scoreFormater=[[NSNumberFormatter alloc] init];
            _scoreFormater.groupingSeparator=@".";
            _scoreFormater.maximumFractionDigits=0;
        }
        
        lblSgp.text=@"";
        [lblSgp animationScoreWithDuration:DURATION_SCORE startValue:0 endValue:_shop.promotionDetail.sgp.longLongValue format:_scoreFormater];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_SCORE_FINISHED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            
            lblSgp.text=[_scoreFormater stringFromNumber:_shop.promotionDetail.sgp];
            
            [[NSNotificationCenter defaultCenter] removeObserver:note];
        }];
    }
}

-(void) userScanedQRCode:(NSNotification*) notification
{
    [self removeLoading];
    
    if(notification.object)
    {
        QRCode *qrCode=[notification.object objectAtIndex:0];
        
        if(!(_shop && _shop.idShop.integerValue==qrCode.idShop))
            return;
        
        //đang đc hiển thị trên màn hình
        if(self.superview)
            [self animationScore];
        else
        {
            _isNeedAnimaionScore=true;
        }
    }
}

-(void)setNeedAnimationScore
{
    _isNeedAnimaionScore=true;
}

@end