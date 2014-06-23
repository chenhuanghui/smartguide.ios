//
//  ShopDetailInfoViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoViewController.h"
#import "GUIManager.h"
#import "ShopDetailInfoCell.h"
#import "ShopDetailInfoEmptyCell.h"
#import "ShopDetailInfoType1Cell.h"
#import "ShopDetailInfoType2Cell.h"
#import "ShopDetailInfoType3Cell.h"
#import "ShopDetailInfoType4Cell.h"
#import "ShopDetailInfoHeaderView.h"
#import "ShopDetailInfoDescCell.h"
#import "ASIOperationShopDetailInfo.h"
#import "Shop.h"
#import "ShopList.h"

#define SHOP_DETAIL_INFO_TABLE_EMPTY_CELL_HEIGHT 23.f

@interface ShopDetailInfoViewController ()<ShopDetailInfoDescCellDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ASIOperationPostDelegate>
{
    ASIOperationShopDetailInfo *_operation;
    enum SHOP_DETAIL_INFO_DESCRIPTION_MODE _descMode;
}

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
        [_operation clearDelegatesAndCancel];
        _operation=nil;
    }
}

-(void) storeRect
{
    _coverFrame=coverView.frame;
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
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoDescCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoDescCell reuseIdentifier]];
    
    _infos=[NSMutableArray new];
    _didLoadShopDetail=false;
    _descMode=SHOP_DETAIL_INFO_DESCRIPTION_NORMAL;
    
    _operation=[[ASIOperationShopDetailInfo alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng()];
    _operation.delegate=self;
    _operation.fScreen=SCREEN_CODE_SHOP_USER;
    
    [_operation addToQueue];
    
    if(_shop.shopGalleriesObjects.count>0)
    {
        ShopGallery *gallery=_shop.shopGalleriesObjects[0];
        
        [imgvCover loadShopCoverWithURL:gallery.cover];
    }
    
    [self reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if([cell isKindOfClass:[ShopDetailInfoType3Cell class]])
    {
        ShopDetailInfoType3Cell *infoCell=(ShopDetailInfoType3Cell*)cell;

        if(infoCell.info.idShop!=0)
        {
            [[GUIManager shareInstance].rootViewController presentShopUserWithIDShop:infoCell.info.idShop.integerValue];
        }
    }
    else if([cell isKindOfClass:[ShopDetailInfoDescCell class]])
    {
        ShopDetailInfoDescCell *descCell=(ShopDetailInfoDescCell*) cell;
        
        if(!descCell.canReadMore)
            return;
        
        _descMode=_descMode==SHOP_DETAIL_INFO_DESCRIPTION_NORMAL?SHOP_DETAIL_INFO_DESCRIPTION_FULL:SHOP_DETAIL_INFO_DESCRIPTION_NORMAL;
        [self reloadData];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopDetailInfo class]])
    {
        ASIOperationShopDetailInfo *ope=(ASIOperationShopDetailInfo*) operation;
        
        [_infos addObjectsFromArray:ope.infos];
        _didLoadShopDetail=true;
        
        [self reloadData];
        
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

-(void)scrollViewDidScroll1:(UIScrollView *)scrollView
{
    if(scrollView==table)
    {
        if(scrollView.offsetYWithInsetTop<0)
            [coverView l_v_setY:_coverFrame.origin.y+scrollView.offsetYWithInsetTop/4];
        else
        {
            float y=_coverFrame.origin.y+scrollView.offsetYWithInsetTop/4;
            
            y=MIN(0,y);
            
            [coverView l_v_setY:y];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // address, shop name
    int count=1;
    
    // description
    count++;
    
    // các block info
    count+=_infos.count;
    
    return count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: //address
            return 1;
            
        case 1: //desc
            return 2;
            
        default:
        {
            InfoTypeObject *obj=_infos[section-2];

            return obj.items.count+1;
        }
    }
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [ShopDetailInfoCell heightWithShop:_shop];
            
        case 1:
            if(indexPath.row==0)
                return [ShopDetailInfoDescCell heightWithShop:_shop withMode:_descMode];
            else
                return SHOP_DETAIL_INFO_TABLE_EMPTY_CELL_HEIGHT;
            
        default:
        {
            InfoTypeObject *obj=_infos[indexPath.section-2];
            
            if(indexPath.row==obj.items.count)
                return SHOP_DETAIL_INFO_TABLE_EMPTY_CELL_HEIGHT;
            
            switch (obj.enumType) {
                case DETAIL_INFO_TYPE_1:
                    return [ShopDetailInfoType1Cell heightWithInfo1:obj.items[indexPath.row]];
                    
                case DETAIL_INFO_TYPE_2:
                    return [ShopDetailInfoType2Cell heightWithInfo2:obj.items[indexPath.row]];
                    
                case DETAIL_INFO_TYPE_3:
                    return [ShopDetailInfoType3Cell heightWithInfo3:obj.items[indexPath.row]];
                    
                case DETAIL_INFO_TYPE_4:
                    return [ShopDetailInfoType4Cell heightWithInfo4:obj.items[indexPath.row]];
                    
                default:
                    return 0;
            }
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            ShopDetailInfoCell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoCell reuseIdentifier]];
            
            [cell loadWithShop:_shop];
            
            return cell;
        }
            
        case 1:
        {
            if(indexPath.row==0)
            {
                ShopDetailInfoDescCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopDetailInfoDescCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithShop:_shop mode:_descMode];
                
                return cell;
            }
            else
                return [self emptyCell];
        }
            
        default:
            return [self cellWithIndexPath:indexPath];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            
        default:
            return [ShopDetailInfoHeaderView height];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [UIView new];
            
        default:
        {
            NSString *title=@"";
            
            if(section==1)
                title=@"GIỚI THIỆU";
            else
                title=[_infos[section-2] header];
            
            ShopDetailInfoHeaderView *headerView=[[ShopDetailInfoHeaderView alloc] initWithTitle:title];

            CGRect rect=[table rectForSection:section];
            
            rect.size.height-=(SHOP_DETAIL_INFO_TABLE_EMPTY_CELL_HEIGHT+[ShopDetailInfoHeaderView height]-2);
            
            headerView.maxY=rect.origin.y+rect.size.height;

            return headerView;
        }
    }
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
        emptyCell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    return emptyCell;
}

-(UITableViewCell*) cellWithIndexPath:(NSIndexPath*) indexPath
{
    InfoTypeObject *obj=_infos[indexPath.section-2];
    
    if(indexPath.row==obj.items.count)
    {
        return [self emptyCell];
    }
    
    switch (obj.enumType) {
        case DETAIL_INFO_TYPE_1:
        {
            Info1 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType1Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType1Cell reuseIdentifier]];
            
            [cell loadWithInfo1:item];
            
            if(indexPath.row==0)
                [cell setCellPos:CELL_POSITION_TOP];
            else if(indexPath.row==obj.items.count-1)
                [cell setCellPos:CELL_POSITION_BOTTOM];
            else
                [cell setCellPos:CELL_POSITION_MIDDLE];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_2:
        {
            Info2 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType2Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType2Cell reuseIdentifier]];
            
            [cell loadWithInfo2:item];
            
            if(indexPath.row==0)
                [cell setCellPos:CELL_POSITION_TOP];
            else if(indexPath.row==obj.items.count-1)
                [cell setCellPos:CELL_POSITION_BOTTOM];
            else
                [cell setCellPos:CELL_POSITION_MIDDLE];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_3:
        {
            Info3 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType3Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType3Cell reuseIdentifier]];
            
            [cell loadWithInfo3:item];
            
            if(indexPath.row==0)
                [cell setCellPos:CELL_POSITION_TOP];
            else if(indexPath.row==obj.items.count-1)
                [cell setCellPos:CELL_POSITION_BOTTOM];
            else
                [cell setCellPos:CELL_POSITION_MIDDLE];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_4:
        {
            Info4 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType4Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType4Cell reuseIdentifier]];
            
            [cell loadWithInfo4:item];
            
            if(indexPath.row==0)
                [cell setCellPos:CELL_POSITION_TOP];
            else if(indexPath.row==obj.items.count-1)
                [cell setCellPos:CELL_POSITION_BOTTOM];
            else
                [cell setCellPos:CELL_POSITION_MIDDLE];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_UNKNOW:
            break;
    }
    
    return [UITableViewCell new];
}

-(void)shopDetailInfoDescCellTouchedReadLess:(ShopDetailInfoDescCell *)cell
{
    _descMode=SHOP_DETAIL_INFO_DESCRIPTION_NORMAL;
    [self reloadData];
}

-(void)shopDetailInfoDescCellTouchedReadMore:(ShopDetailInfoDescCell *)cell
{
    _descMode=SHOP_DETAIL_INFO_DESCRIPTION_FULL;
    [self reloadData];
}

-(void) reloadData
{
    [table reloadData];
    
    [self clearBGView];
    
    int sectionCount=[table numberOfSections];
    
    CGRect rect=CGRectZero;
    
    for(int i=1;i<sectionCount;i++)
    {
        rect=[table rectForSection:i];
        rect.size.height-=SHOP_DETAIL_INFO_TABLE_EMPTY_CELL_HEIGHT;
        
        ShopDetailBGView *bg=[[ShopDetailBGView alloc] initWithFrame:rect];
        
        [table insertSubview:bg atIndex:0];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    for(UIView *bg in tableView.subviews)
        if([bg isKindOfClass:[ShopDetailBGView class]])
            [tableView sendSubviewToBack:bg];
}

-(void) clearBGView
{
    UIView *view=nil;
    
    for(view in table.subviews)
    {
        if([view isKindOfClass:[ShopDetailBGView class]])
            break;
    }
    
    if([view isKindOfClass:[ShopDetailBGView class]])
    {
        [view removeFromSuperview];
        [self clearBGView];
    }
}

@end

@implementation ShopDetailBGView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.contentMode=UIViewContentModeRedraw;
    self.backgroundColor=[UIColor clearColor];
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    if(!imgMid)
    {
        imgTop=[UIImage imageNamed:@"bg_detail_placelist_header.png"];
        imgMid=[UIImage imageNamed:@"bg_detail_info_mid.png"];
        imgBottom=[UIImage imageNamed:@"bg_detail_info_bottom.png"];
    }
    
    [imgTop drawInRect:CGRectMake(0, 0, imgTop.size.width, imgTop.size.height)];
    [imgBottom drawAtPoint:CGPointMake(0, rect.size.height-imgTop.size.height)];
    
    rect.origin.y=imgTop.size.height;
    rect.origin.x=0;
    rect.size.height-=(imgTop.size.height+imgBottom.size.height-1);
    
    [imgMid drawAsPatternInRect:rect];
}



@end