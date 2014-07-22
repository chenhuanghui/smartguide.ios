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
#import "ShopDetailBGView.h"
#import "ImageManager.h"
#import "WebViewController.h"

@interface ShopDetailInfoViewController ()<ShopDetailInfoDescCellDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ASIOperationPostDelegate,ShopDetailInfoType2Delegate>
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
    
    table.delegate=nil;
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
    
    [table registerShopDetailInfoCell];
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoEmptyCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoEmptyCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoType1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoType1Cell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoType2Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoType2Cell reuseIdentifier]];
    [table registerShopDetailInfoType3Cell];
    [table registerNib:[UINib nibWithNibName:[ShopDetailInfoType4Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoType4Cell reuseIdentifier]];
    [table registerShopDetailInfoDescCell];
    
    _infos=[NSMutableArray new];
    _didLoadShopDetail=false;
    _descMode=SHOP_DETAIL_INFO_DESCRIPTION_NORMAL;

    [self requestShopDetailInfo];
    
    if(_shop.shopGalleriesObjects.count>0)
    {
        ShopGallery *gallery=_shop.shopGalleriesObjects[0];
        
        [imgvCover loadShopCoverWithURL:gallery.cover];
    }
    
    [self showLoading];
}

-(void)viewWillAppearOnce
{
    [self reloadData];
}

-(void) requestShopDetailInfo
{
    _operation=[[ASIOperationShopDetailInfo alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng()];
    _operation.delegate=self;
    _operation.fScreen=SCREEN_CODE_SHOP_USER;
    
    [_operation addToQueue];
}

-(void) showLoading
{
    
}

-(void) removeLoading
{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if([cell isKindOfClass:[ShopDetailInfoType3Cell class]])
    {
        ShopDetailInfoType3Cell *infoCell=(ShopDetailInfoType3Cell*)cell;

        if(infoCell.info.idShop.integerValue!=0)
        {
            [self.delegate shopDetailInfoControllerTouchedShop:self idShop:infoCell.info.idShop.integerValue];
        }
    }
    else if([cell isKindOfClass:[ShopDetailInfoDescCell class]])
    {
        ShopDetailInfoDescCell *descCell=(ShopDetailInfoDescCell*) cell;
        
        if(!descCell.canReadMore)
            return;
        
        _descMode=_descMode==SHOP_DETAIL_INFO_DESCRIPTION_NORMAL?SHOP_DETAIL_INFO_DESCRIPTION_FULL:SHOP_DETAIL_INFO_DESCRIPTION_NORMAL;
        
        [descCell loadWithShop:_shop mode:_descMode];
        [descCell markedAnimation];
        
        [tableView beginUpdates];
        [tableView endUpdates];
        
        [descCell animationWithMode:_descMode duration:DURATION_DEFAULT];
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            [self reloadBGViews];
        }];
        
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopDetailInfo class]])
    {
        [self removeLoading];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
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
        
        scrollBG.contentOffset=table.contentOffset;
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
            return 1;
            
        default:
        {
            InfoTypeObject *obj=_infos[section-2];

            return obj.items.count;
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
        {
            ShopDetailInfoCell *cell=[tableView shopDetailInfoCell];
            
            [cell loadWithShop:_shop];
            [cell layoutSubviews];
            
            return [cell suggestHeight];
        }
            
        case 1:
            if(indexPath.row==0)
            {
                ShopDetailInfoDescCell *cell=[tableView shopDetailInfoDescCell];
                
                [cell loadWithShop:_shop mode:_descMode];
                [cell layoutSubviews];
                
                return [cell suggestHeight];
            }
            
        default:
        {
            InfoTypeObject *obj=_infos[indexPath.section-2];
            
            switch (obj.enumType) {
                case DETAIL_INFO_TYPE_1:
                    return [ShopDetailInfoType1Cell heightWithInfo1:obj.items[indexPath.row]];
                    
                case DETAIL_INFO_TYPE_2:
                    return [ShopDetailInfoType2Cell heightWithInfo2:obj.items[indexPath.row]];
                    
                case DETAIL_INFO_TYPE_3:
                {
                    ShopDetailInfoType3Cell *cell=[tableView shopDetailInfoType3Cell];
                    
                    [cell loadWithInfo3:obj.items[indexPath.row]];
                    [cell layoutSubviews];
                    
                    return [cell suggestHeight];
                }
                    
                case DETAIL_INFO_TYPE_4:
                    return [ShopDetailInfoType4Cell heightWithInfo4:obj.items[indexPath.row]];
                    
                case DETAIL_INFO_TYPE_UNKNOW:
                    return 0;
            }
        }
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            ShopDetailInfoCell *cell=[table shopDetailInfoCell];
            
            [cell loadWithShop:_shop];
            
            return cell;
        }
            
        case 1:
        {
            if(indexPath.row==0)
            {
                ShopDetailInfoDescCell *cell=[tableView shopDetailInfoDescCell];
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==tableView.numberOfSections-1)
        return 0;
    
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v=[UIView new];
    v.backgroundColor=[UIColor clearColor];
    return v;
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
            headerView.section=section;
            
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
            
            if(indexPath.row==obj.items.count-1)
                [cell setCellPos:CELL_POSITION_BOTTOM];
            else if(indexPath.row==0)
                [cell setCellPos:CELL_POSITION_TOP];
            else
                [cell setCellPos:CELL_POSITION_MIDDLE];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_2:
        {
            Info2 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType2Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType2Cell reuseIdentifier]];
            
            cell.delegate=self;
            [cell loadWithInfo2:item];
            
            if(indexPath.row==obj.items.count-1)
                [cell setCellPos:CELL_POSITION_BOTTOM];
            else if(indexPath.row==0)
                [cell setCellPos:CELL_POSITION_TOP];
            else
                [cell setCellPos:CELL_POSITION_MIDDLE];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_3:
        {
            Info3 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType3Cell *cell=[table shopDetailInfoType3Cell];
            
            [cell loadWithInfo3:item];
            
            if(indexPath.row==obj.items.count-1)
                [cell setCellPos:CELL_POSITION_BOTTOM];
            else if(indexPath.row==0)
                [cell setCellPos:CELL_POSITION_TOP];
            else
                [cell setCellPos:CELL_POSITION_MIDDLE];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_4:
        {
            Info4 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType4Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType4Cell reuseIdentifier]];
            
            [cell loadWithInfo4:item];
            
            if(indexPath.row==obj.items.count-1)
                [cell setCellPos:CELL_POSITION_BOTTOM];
            else if(indexPath.row==0)
                [cell setCellPos:CELL_POSITION_TOP];
            else
                [cell setCellPos:CELL_POSITION_MIDDLE];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_UNKNOW:
            break;
    }
    
    return [UITableViewCell new];
}

-(void)shopDetailInfoType2TouchedURL:(ShopDetailInfoType2Cell *)cell url:(NSURL *)url
{
    [self.delegate shopDetailInfoControllerTouchedURL:self url:url];
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

-(void) syncScroll
{
    scrollBG.contentOffset=table.contentOffset;
}

-(void) reloadData
{
    [table reloadData];
    
    [self syncScroll];
    
    [self clearBGView];
    
    int sectionCount=[table numberOfSections];
    
    for(int i=1;i<sectionCount;i++)
    {
        ShopDetailBGView *bg=[[ShopDetailBGView alloc] initWithFrame:[self rectForBackgroundView:i]];
        
        bg.section=i;
        
        [scrollBG addSubview:bg];
    }
}

-(void) reloadBGViews
{
    for(ShopDetailBGView *bg in scrollBG.subviews)
    {
        bg.frame=[self rectForBackgroundView:bg.section];
    }
}

-(CGRect) rectForBackgroundView:(int) section
{
    float headerHeight=[table rectForHeaderInSection:section].size.height;
    
    if(headerHeight>0)
        headerHeight-=43-38;
    
    CGRect rect=[table rectForSection:section];
    rect.size.width=300;
    rect.size.height-=[table rectForFooterInSection:section].size.height+headerHeight;
    rect.origin.y+=headerHeight;
    rect.origin.x=10;
    
    return rect;
}

-(void) clearBGView
{
    [scrollBG.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end