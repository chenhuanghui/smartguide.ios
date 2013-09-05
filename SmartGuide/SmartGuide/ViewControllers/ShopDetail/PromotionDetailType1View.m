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
    self=[[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"PromotionDetailType1View") owner:nil options:nil] objectAtIndex:0];
    
    [self setShop:shop];
    [tableRank registerNib:[UINib nibWithNibName:[PromotionDetailCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PromotionDetailCell reuseIdentifier]];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"cost"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor color255WithRed:201 green:84 blue:54 alpha:255];
    style.font=[UIFont boldSystemFontOfSize:10];
    
    [lblCost addStyle:style];
        
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont systemFontOfSize:10];
    
    [lblCost addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"sp"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor blackColor];
    style.font=[UIFont boldSystemFontOfSize:12];
    
    [lblSP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont systemFontOfSize:10];
    
    [lblSP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"p"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor blackColor];
    style.font=[UIFont boldSystemFontOfSize:12];
    
    [lblP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont systemFontOfSize:10];
    
    [lblP addStyle:style];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userScanedQRCode:) name:NOTIFICATION_USER_SCANED_QR_CODE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userScanedQRCode:) name:NOTIFICATION_USER_CANCELED_SCAN_QR_CODE object:nil];
    
    return self;
}

-(void) setSP:(int) sp
{
    if(sp==-1)
    {
        [lblSP setText:@"<sp> </sp><text> </text>"];;
        return;
    }
    
    [lblSP setText:[NSString stringWithFormat:@"<sp>%i</sp><text> SP tích luỹ</text>",sp]];
}

-(void) setP:(int) p
{
    if(p==-1)
    {
        [lblP setText:@"<p> </p><text> </text>"];
        return;
    }
    
    [lblP setText:[NSString stringWithFormat:@"<p>%i</p><text> P cho 1 SGP</text>",p]];
}

-(void) setCost:(NSString *) cost
{
    [lblCost setText:[NSString stringWithFormat:@"<text>Với mỗi <cost>%@K</cost> trên hoá đơn bạn sẽ được 1 lượt quét thẻ</text>",cost]];
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
    
    [self setSP:_shop.promotionDetail.sp.integerValue];
    [self setP:_shop.promotionDetail.p.integerValue];
    [self setCost:[NSNumberFormatter numberFromNSNumber:@(_shop.promotionDetail.cost.longLongValue/1000)]];
    
    lblSgp.text=[NSString stringWithFormat:@"%lld",_shop.promotionDetail.sgp.longLongValue];
    
    
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
    return [PromotionDetailCell height]+2;
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
    
//    [self showLoadingWithTitle:@"Wait scan QRCode"];
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
        
        __block __weak id obj = [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_SCORE_FINISHED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            
            lblSgp.text=[_scoreFormater stringFromNumber:_shop.promotionDetail.sgp];
            
            [[NSNotificationCenter defaultCenter] removeObserver:obj];
        }];
    }
}

-(void) userScanedQRCode:(NSNotification*) notification
{
//    [self removeLoading];
    
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
        
        [tableRank reloadData];
    }
}

-(void)setNeedAnimationScore
{
    _isNeedAnimaionScore=true;
}

@end