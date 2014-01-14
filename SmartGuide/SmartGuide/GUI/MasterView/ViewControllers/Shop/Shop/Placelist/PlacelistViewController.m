//
//  PlacelistViewController.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "PlacelistViewController.h"
#import "PlacelistHeaderCell.h"
#import "PlacelistCreateCell.h"
#import "PlaceListInfoCell.h"

@interface PlacelistViewController ()
{
    enum PLACELIST_CREATE_CELL_MODE _createCellMode;
}

@end

@implementation PlacelistViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"PlacelistViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(PlacelistViewController *)initWithShopList:(ShopList *)shoplist;
{
    self = [super initWithNibName:@"PlacelistViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _shoplist=shoplist;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _createCellMode=PLACELIST_CREATE_CELL_SMALL;
    
    [table registerNib:[UINib nibWithNibName:[PlacelistHeaderCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PlacelistHeaderCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[PlacelistCreateCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PlacelistCreateCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[PlaceListInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PlaceListInfoCell reuseIdentifier]];
    
    _page=-1;
    _isCanLoadMore=true;
    _isLoadingMore=false;
    _placelists=[NSMutableArray array];
    
    [self requestUserPlacelist];
}

-(void) requestUserPlacelist
{
    _operationUserPlacelist=[[ASIOperationUserPlacelist alloc] initWithUserLat:userLat() userLng:userLng() page:_page+1];
    _operationUserPlacelist.delegatePost=self;
    
    [_operationUserPlacelist startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return 2;
    else if(section==1)
        return _placelists.count+1;
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if(indexPath.row==0)
                return [PlacelistHeaderCell height];
            else
                return [PlacelistCreateCell heightWithMode:_createCellMode];

        case 1:
            if(indexPath.row==0)
                return [PlacelistHeaderCell height];
            else
                return table.l_v_h-[table rectForSection:0].size.height-[PlacelistHeaderCell height];
            
        default:
            return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            
            if(indexPath.row==0)
            {
                PlacelistHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:[PlacelistHeaderCell reuseIdentifier]];
                
                [cell setHeader:@"Tạo placelist"];
                
                return cell;
            }
            else
            {
                PlacelistCreateCell *cell=[tableView dequeueReusableCellWithIdentifier:[PlacelistCreateCell reuseIdentifier]];
                
                [cell loadWithMode:_createCellMode];
                
                return cell;
            }
            
            break;
            
        case 1:
            
            if(indexPath.row==0)
            {
                PlacelistHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:[PlacelistHeaderCell reuseIdentifier]];
                
                [cell setHeader:@"Tạo placelist"];
                
                return cell;
            }
            else
            {
                PlaceListInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[PlaceListInfoCell reuseIdentifier]];
                
                return cell;
            }
            
            break;
    }
    
    return [UITableViewCell new];
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
