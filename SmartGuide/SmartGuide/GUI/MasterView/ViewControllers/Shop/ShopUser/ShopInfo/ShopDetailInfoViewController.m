//
//  ShopDetailInfoViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoViewController.h"
#import "ShopDetailInfoToolCell.h"
#import "ShopDetailInfoDetailCell.h"
#import "ShopDetailInfoImageCell.h"

#define SHOP_DETAIL_INFO_TABLE_MARGIN_HEIGHT 24.f

@interface ShopDetailInfoViewController ()

@end

@implementation ShopDetailInfoViewController

- (id)init
{
    self = [super initWithNibName:@"ShopDetailInfoViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) storeRect
{
    _contentFrame=lblContent.frame;
    _tableToolFrame=tableTool.frame;
    _tableDetailFrame=tableDetail.frame;
    _tableImageFrame=tableImage.frame;
    _infoFrame=infoView.frame;
}

-(void) maskTopLR:(UIView*) v
{
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:v.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *shapeLayer=[CAShapeLayer new];
    shapeLayer.frame=v.bounds;
    shapeLayer.path=maskPath.CGPath;
    v.layer.mask=shapeLayer;
}

-(void) maskTableBottomLR:(UITableView*) v
{
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, v.cs_w, v.cs_h) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *shapeLayer=[CAShapeLayer new];
    shapeLayer.frame=CGRectMake(0, 0, v.cs_w, v.cs_h);
    shapeLayer.path=maskPath.CGPath;
    v.layer.mask=shapeLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self storeRect];

    introView.layer.cornerRadius=8;
    introView.layer.masksToBounds=true;
    
    [self maskTopLR:toolView];
    [self maskTopLR:detailView];
    [self maskTopLR:imageView];
    
    [tableTool registerNib:[UINib nibWithNibName:[ShopDetailInfoToolCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoToolCell reuseIdentifier]];
    [tableDetail registerNib:[UINib nibWithNibName:[ShopDetailInfoDetailCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoDetailCell reuseIdentifier]];
    [tableImage registerNib:[UINib nibWithNibName:[ShopDetailInfoImageCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoImageCell reuseIdentifier]];
    
    [self alignIntro];
    [self alignTool];
    [self alignDetail];
    [self alignImage];
    
    scroll.contentSize=CGSizeMake(self.l_v_w, tableImage.l_v_y+tableImage.cs_h+5);
}

-(void) alignIntro
{
    CGSize size=[lblContent.text sizeWithFont:lblContent.font constrainedToSize:CGSizeMake(lblContent.l_v_w, 9999) lineBreakMode:lblContent.lineBreakMode];
    btnMoreIntro.hidden=size.height<_contentFrame.size.height;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==scroll)
    {
        CGPoint pnt=scrollView.contentOffset;
        
        if(pnt.y<_infoFrame.origin.y)
        {
            [infoView l_v_setY:pnt.y];
        }
        else
        {
            [infoView l_v_setY:_infoFrame.origin.y];
        }
        
        if(pnt.y>=_tableToolFrame.origin.y)
        {
            [tableTool l_v_setY:pnt.y];
            [tableTool co_setY:pnt.y-_tableToolFrame.origin.y];
        }
        else
        {
            [tableTool l_v_setY:_tableToolFrame.origin.y];
            [tableTool co_setY:0];
        }
        
        if(pnt.y>=_tableDetailFrame.origin.y)
        {
            [tableDetail l_v_setY:pnt.y];
            [tableDetail co_setY:pnt.y-_tableDetailFrame.origin.y];
        }
        else
        {
            [tableDetail l_v_setY:_tableDetailFrame.origin.y];
            [tableDetail co_setY:0];
        }
        
        if(pnt.y>=_tableImageFrame.origin.y)
        {
            [tableImage l_v_setY:pnt.y];
            [tableImage co_setY:pnt.y-_tableImageFrame.origin.y];
        }
        else
        {
            [tableImage l_v_setY:_tableImageFrame.origin.y];
            [tableImage co_setY:0];
        }
        
        NSLog(@"%f",pnt.y);
    }
}

-(void) moveBottomView:(float) y
{
    [toolView l_v_addY:y];
    [tableTool l_v_addY:y];
    _tableToolFrame.origin.y+=y;
    
    [detailView l_v_addY:y];
    [tableDetail l_v_addY:y];
    _tableDetailFrame.origin.y+=y;
    
    [imageView l_v_addY:y];
    [tableImage l_v_addY:y];
    _tableImageFrame.origin.y+=y;
}

-(void) alignBottom
{
    tableDetail.dataSource=self;
    tableDetail.delegate=self;
    [tableDetail reloadData];
    
    [self alignDetail];
    
    tableImage.dataSource=self;
    tableImage.delegate=self;
    [tableImage reloadData];
    
    [self alignImage];
}

-(void) alignTool
{
    [toolView l_v_setY:introView.l_v_y+introView.l_v_h+SHOP_DETAIL_INFO_TABLE_MARGIN_HEIGHT];
    
    tableTool.dataSource=self;
    tableTool.delegate=self;
    [tableTool reloadData];
    
    [tableTool l_v_setY:toolView.l_v_y+toolView.l_v_h];
    [tableTool l_v_setH:MIN(self.l_v_h,tableTool.cs_h)];
    
    _tableToolFrame=tableTool.frame;
    
    [self maskTableBottomLR:tableTool];
}

-(void) alignDetail
{
    [detailView l_v_setY:tableTool.l_v_y+tableTool.cs_h+SHOP_DETAIL_INFO_TABLE_MARGIN_HEIGHT];
    
    tableDetail.dataSource=self;
    tableDetail.delegate=self;
    [tableDetail reloadData];
    
    [tableDetail l_v_setY:detailView.l_v_y+detailView.l_v_h];
    [tableDetail l_v_setH:MIN(self.l_v_h,tableTool.cs_h)];
    
    _tableDetailFrame=tableDetail.frame;
    
    [self maskTableBottomLR:tableDetail];
}

-(void) alignImage
{
    [imageView l_v_setY:tableDetail.l_v_y+tableDetail.cs_h+SHOP_DETAIL_INFO_TABLE_MARGIN_HEIGHT];
    
    tableImage.dataSource=self;
    tableImage.delegate=self;
    [tableImage reloadData];
    
    [tableImage l_v_setY:imageView.l_v_y+imageView.l_v_h];
    [tableImage l_v_setH:MIN(self.l_v_h,tableImage.cs_h)];
    
    _tableImageFrame=tableImage.frame;
    
    [self maskTableBottomLR:tableImage];
}

-(IBAction) btnMoreIntroTouchUpInside:(id)sender
{
    if(btnMoreIntro.tag==0)
    {
        btnMoreIntro.tag=1;
        [btnMoreIntro setTitle:@"Thu nhỏ" forState:UIControlStateNormal];
        
        CGSize size=[lblContent.text sizeWithFont:lblContent.font constrainedToSize:CGSizeMake(lblContent.l_v_w, 9999) lineBreakMode:lblContent.lineBreakMode];
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            float height=size.height-_contentFrame.size.height+10;
            [introView l_v_addH:height];
            [self moveBottomView:height];
            [scroll cs_addH:height];
        }];
    }
    else
    {
        btnMoreIntro.tag=0;
        [btnMoreIntro setTitle:@"Xem thêm" forState:UIControlStateNormal];
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            float height=-(lblContent.l_v_h-_contentFrame.size.height);
            [introView l_v_addH:height];
            [self moveBottomView:height];
            [scroll cs_addH:height];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableTool)
    {
        ShopDetailInfoToolCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopDetailInfoToolCell reuseIdentifier]];
        
        [cell loadWithContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." withState:rand()%2==0];
        
        return cell;
    }
    else if(tableView==tableDetail)
    {
        ShopDetailInfoDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopDetailInfoDetailCell reuseIdentifier]];
        
        [cell loadWithName:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." withContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
        
        return cell;
    }
    else if(tableView==tableImage)
    {
        ShopDetailInfoImageCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopDetailInfoImageCell reuseIdentifier]];
        
        [cell loadWithImage:[UIImage imageNamed:@"ava.png"] withTitle:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." withContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableTool)
    {
        return [ShopDetailInfoToolCell heightWithContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
    }
    else if(tableView==tableDetail)
    {
        return [ShopDetailInfoDetailCell heightWithContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
    }
    else if(tableView==tableImage)
    {
        return [ShopDetailInfoImageCell heightWithContent:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
    }
    
    return 0;
}

@end
