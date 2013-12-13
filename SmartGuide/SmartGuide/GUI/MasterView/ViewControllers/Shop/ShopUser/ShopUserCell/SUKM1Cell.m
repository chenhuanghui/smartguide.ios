//
//  SUKM1Cell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUKM1Cell.h"
#import "Utility.h"

@implementation SUKM1Cell

-(void)loadWithKM:(NSArray *)array
{
    data=[array copy];
    
    table.dataSource=self;
    table.delegate=self;
    [table reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return data.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShopKM1Cell heightWithContent:data[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopKM1Cell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopKM1Cell reuseIdentifier]];
    
    NSArray *array=@[@"A",@"B",@"C",@"D"];
    
    [cell setVoucher:array[random_int(0, array.count)] content:data[indexPath.row] sgp:@"99" isHighlighted:random()%2==0];
    
    return cell;
}

+(NSString *)reuseIdentifier
{
    return @"SUKM1Cell";
}

+(float)heightWithKM:(NSArray *)array
{
    float height=208;
    for(NSString *str in array)
    {
        height+=[ShopKM1Cell heightWithContent:str];
    }
    
    return height;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerNib:[UINib nibWithNibName:[ShopKM1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKM1Cell reuseIdentifier]];
    
    bgStatusView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_status.png"]];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"k"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor redColor];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:11];
    
    [lbl100K addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"sp"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont fontWithName:@"Avenir-Heavy" size:11];
    
    [lblSP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"p"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont fontWithName:@"Avenir-Heavy" size:11];
    
    [lblP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:10];
    
    [lbl100K addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:10];
    
    [lblSP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:10];
    
    [lblP addStyle:style];
    
    [lbl100K setText:@"<text>Với mỗi <k>100k</k> trên hoá đơn bạn nhận được 1 lượt quét thẻ</text>"];
    [lblSP setText:@"<text><sp>300 SP</sp> tích luỹ</text>"];
    [lblP setText:@"<text><p>10 P</p> cho <p>1 SGP</p></text>"];
}

@end

@implementation PromotionDetailView

-(void)drawRect:(CGRect)rect
{
    if(!img)
        img=[UIImage imageNamed:@"pattern_promotion.png"];
    
    rect.origin=CGPointZero;
    
    [img drawAsPatternInRect:rect];
}

@end