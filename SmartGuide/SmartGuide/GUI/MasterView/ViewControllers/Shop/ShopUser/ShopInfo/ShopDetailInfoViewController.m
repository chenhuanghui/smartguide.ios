//
//  ShopDetailInfoViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoViewController.h"

#define SHOP_DETAIL_INFO_TABLE_MARGIN_HEIGHT 24.f

@interface ShopDetailInfoViewController ()

@end

@implementation ShopDetailInfoViewController

- (ShopDetailInfoViewController *)initWithShop:(Shop *)shop
{
    self = [super initWithNibName:@"ShopDetailInfoViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _shop=shop;
    }
    return self;
}

-(void)dealloc
{
    if(_operation)
    {
        [_operation cancel];
        _operation=nil;
    }
}

-(void) storeRect
{
    _coverFrame=coverView.frame;
}

-(void) maskTopLR:(UIView*) v
{
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:v.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(2.5f, 2.5f)];
    CAShapeLayer *shapeLayer=[CAShapeLayer new];
    shapeLayer.frame=v.bounds;
    shapeLayer.path=maskPath.CGPath;
    v.layer.mask=shapeLayer;
}

-(void) maskTableBottomLR:(UITableView*) v
{
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, v.l_cs_w, v.l_cs_h) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(2.5f, 2.5f)];
    CAShapeLayer *shapeLayer=[CAShapeLayer new];
    shapeLayer.frame=CGRectMake(0, 0, v.l_cs_w, v.l_cs_h);
    shapeLayer.path=maskPath.CGPath;
    v.layer.mask=shapeLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self storeRect];
    
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoEmptyCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoEmptyCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoType1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoType1Cell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoType2Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoType2Cell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoType3Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoType3Cell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoType4Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoType4Cell reuseIdentifier]];
    
    _infos=[NSMutableArray new];
    _didLoadShopDetail=false;
    _descMode=SHOP_DETAIL_INFO_DESCRIPTION_NORMAL;
    
    [_infos addObject:@""];
    
    _operation=[[ASIOperationShopDetailInfo alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng()];
    _operation.delegatePost=self;
    
    [_operation startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopDetailInfo class]])
    {
        ASIOperationShopDetailInfo *ope=(ASIOperationShopDetailInfo*) operation;
        
        [_infos addObjectsFromArray:ope.infos];
        _didLoadShopDetail=true;
        
        [table reloadData];
        
        _operation=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopDetailInfo class]])
    {
        _operation=nil;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _infos.count+(_didLoadShopDetail?0:1);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _didLoadShopDetail?2:1;
            
        case 1:
        {
            if(!_didLoadShopDetail)
                return 1;
            
            break;
        }
            
        default:
            break;
    }
    
    InfoTypeObject *obj=_infos[section];
    
    return obj.items.count+1;
}

-(void)detailInfoCellTouchedMore:(ShopDetailInfoCell *)cell
{
    _descMode=(_descMode==SHOP_DETAIL_INFO_DESCRIPTION_NORMAL?SHOP_DETAIL_INFO_DESCRIPTION_FULL:SHOP_DETAIL_INFO_DESCRIPTION_NORMAL);
    
    switch (_descMode) {
        case SHOP_DETAIL_INFO_DESCRIPTION_NORMAL:
            if(_didLoadShopDetail)
            {
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
                [table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
                [table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
            }
            else
            {
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
                [table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
            
        case SHOP_DETAIL_INFO_DESCRIPTION_FULL:
            [table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if(indexPath.row==0)
            {
                ShopDetailInfoCell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithShop:_shop height:[table rectForRowAtIndexPath:indexPath].size.height mode:_descMode];
                
                return cell;
            }
            else
            {
                return [self emptyCell];
            }
        }
            
        case 1:
        {
            if(!_didLoadShopDetail)
            {
                ShopDetailInfoEmptyCell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoEmptyCell reuseIdentifier]];
                
                return cell;
            }
            
            break;
        }
            
        default:
            break;
    }
    
    return [self cellWithIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            
        case 1:
            if(!_didLoadShopDetail)
                return 0;
            
        default:
            break;
    }
    
    return [ShopDetailInfoHeaderView height];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [UIView new];
            
        case 1:
            if(!_didLoadShopDetail)
                return [UIView new];
            
        default:
            break;
    }
    
    UITableViewHeaderFooterView *headerFooter=[tableView dequeueReusableHeaderFooterViewWithIdentifier:[ShopDetailInfoHeaderView reuseIdentifier]];
    
    if(!headerFooter)
    {
        headerFooter=[[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:[ShopDetailInfoHeaderView reuseIdentifier]];
        headerFooter.backgroundView.backgroundColor=[UIColor clearColor];
        headerFooter.contentView.backgroundColor=[UIColor clearColor];
        
        ShopDetailInfoHeaderView *header=[[ShopDetailInfoHeaderView alloc] initWithTitle:@""];
        
        [headerFooter.contentView addSubview:header];
    }
    
    ShopDetailInfoHeaderView *header=headerFooter.contentView.subviews[0];
    InfoTypeObject *obj=_infos[section];
    
    [header setTitle:obj.header];
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if(indexPath.row==0)
            {
                _heightDesc=[ShopDetailInfoCell heightWithContent:_shop.desc mode:_descMode];
                
                return _heightDesc;
            }
            else
                return 23;
        }
            
        case 1:
            if(!_didLoadShopDetail)
                return self.l_v_h-_heightDesc;
            
        default:
            break;
    }
    
    InfoTypeObject *obj=_infos[indexPath.section];
    
    if(indexPath.row==obj.items.count)
    {
        return 23;
    }
    
    switch (obj.type) {
        case DETAIL_INFO_TYPE_1:
            return [ShopDetailInfoType1Cell heightWithContent:[obj.items[indexPath.row] content]];
            
        case DETAIL_INFO_TYPE_2:
            return [ShopDetailInfoType2Cell heightWithContent:[obj.items[indexPath.row] content]];
            
        case DETAIL_INFO_TYPE_3:
            return [ShopDetailInfoType3Cell heightWithContent:[obj.items[indexPath.row] content]];
            
        case DETAIL_INFO_TYPE_4:
            return [ShopDetailInfoType4Cell heightWithContent:[obj.items[indexPath.row] content]];
            
        default:
            break;
    }
    
    return 0;
}

-(UITableViewCell*) emptyCell
{
    UITableViewCell *emptyCell=[table dequeueReusableCellWithIdentifier:@"emptyCell"];
    
    if(!emptyCell)
    {
        emptyCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emptyCell"];
        emptyCell.backgroundColor=[UIColor clearColor];
        emptyCell.contentView.backgroundColor=[UIColor clearColor];
        emptyCell.backgroundView.backgroundColor=[UIColor clearColor];
    }
    
    return emptyCell;
}

-(UITableViewCell*) cellWithIndexPath:(NSIndexPath*) indexPath
{
    InfoTypeObject *obj=_infos[indexPath.section];
    
    if(indexPath.row==obj.items.count)
    {
        return [self emptyCell];
    }
    
    switch (obj.type) {
        case DETAIL_INFO_TYPE_1:
        {
            Info1 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType1Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType1Cell reuseIdentifier]];
            
            [cell loadWithInfo1:item isLastCell:indexPath.row==obj.items.count-1];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_2:
        {
            Info2 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType2Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType2Cell reuseIdentifier]];
            
            [cell loadWithInfo2:item isLastCell:indexPath.row==obj.items.count-1];
            
            return cell;
        }
            break;
            
        case DETAIL_INFO_TYPE_3:
        {
            Info3 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType3Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType3Cell reuseIdentifier]];
            
            [cell loadWithInfo3:item isLastCell:indexPath.row==obj.items.count-1];
            
            return cell;
        }
            break;
            
        case DETAIL_INFO_TYPE_4:
        {
            Info4 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType4Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType4Cell reuseIdentifier]];
            
            [cell loadWithInfo4:item isLastCell:indexPath.row==obj.items.count-1];
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return [UITableViewCell new];
}

@end