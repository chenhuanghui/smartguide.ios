//
//  ShopDetailInfoViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoViewController.h"

#define SHOP_DETAIL_INFO_TABLE_MARGIN_HEIGHT 24.f

@interface ShopDetailInfoViewController ()<ShopDetailInfoDescCellDelegate>

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
        if(scrollView.l_co_y<0)
            [coverView l_v_setY:_coverFrame.origin.y+scrollView.l_co_y/4];
        else
        {
            float y=_coverFrame.origin.y+scrollView.l_co_y/4;
            
            y=MIN(0,y);
            
            [coverView l_v_setY:y];
        }
        
        for(HeaderViewObject *obj in _headerViewObjects)
        {
            NSLog(@"%i %@",obj.headerView.hidden,obj.headerView.superview);
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
            
            if(section==[tableView numberOfSections]-1)
                return obj.items.count;
            else //num of item + empty
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
            return [ShopDetailInfoCell height];
            
        case 1:
            if(indexPath.row==0)
                return [ShopDetailInfoDescCell heightWithShop:_shop withMode:_descMode];
            else
                return 23;
            
        default:
        {
            InfoTypeObject *obj=_infos[indexPath.section-2];
            
            if(indexPath.row==obj.items.count)
                return 23; //empty cell height
            
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
            
            if(!_headerViewObjects)
                _headerViewObjects=[NSMutableArray new];
            else
            {
                NSMutableArray *array=[NSMutableArray array];
                
                for(HeaderViewObject *obj in _headerViewObjects)
                {
                    if(!obj.headerView)
                        [array addObject:obj];
                }
                
                NSLog(@"empty %@",array);
                
                [_headerViewObjects removeObjectsInArray:array];
            }
            
            ShopDetailInfoHeaderView *headerView=[[ShopDetailInfoHeaderView alloc] initWithTitle:title];

            bool found=false;
            for(HeaderViewObject *obj in _headerViewObjects)
            {
                if(obj.headerView==headerView)
                {
                    found=true;
                    break;
                }
            }
            
            if(!found)
            {
                HeaderViewObject *objNew=[HeaderViewObject new];
                objNew.headerView=headerView;
                objNew.section=section;
                
                [_headerViewObjects addObject:objNew];
            }
            
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
    
    switch (obj.type) {
        case DETAIL_INFO_TYPE_1:
        {
            Info1 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType1Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType1Cell reuseIdentifier]];
            
            [cell loadWithInfo1:item];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_2:
        {
            Info2 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType2Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType2Cell reuseIdentifier]];
            
            [cell loadWithInfo2:item];
            
            return cell;
        }
            break;
            
        case DETAIL_INFO_TYPE_3:
        {
            Info3 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType3Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType3Cell reuseIdentifier]];
            
            [cell loadWithInfo3:item];
            
            return cell;
        }
            break;
            
        case DETAIL_INFO_TYPE_4:
        {
            Info4 *item=obj.items[indexPath.row];
            
            ShopDetailInfoType4Cell *cell=[table dequeueReusableCellWithIdentifier:[ShopDetailInfoType4Cell reuseIdentifier]];
            
            [cell loadWithInfo4:item];
            
            return cell;
        }
            break;
            
        default:
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
        rect.size.height-=23;
        
        ShopDetailBGView *bg=[[ShopDetailBGView alloc] initWithFrame:rect];
        
        [table insertSubview:bg atIndex:0];
    }
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

@implementation HeaderViewObject
@synthesize headerView,section;

@end