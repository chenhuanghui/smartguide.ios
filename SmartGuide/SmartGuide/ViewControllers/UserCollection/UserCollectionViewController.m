//
//  UserCollectionViewController.m
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserCollectionViewController.h"
#import "UIImageView+AFNetworking.h"
#import "RootViewController.h"
#import "UserCollectionCell.h"
#import "Shop.h"
#import "UIImageView+AFNetworking.h"

@interface UserCollectionViewController ()

@end

@implementation UserCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"USER";
    self.view.backgroundColor=COLOR_BACKGROUND_APP;
    
    blurTop.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_bottom.png"]];
    blurTop.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
    blurBottom.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_bottom.png"]];
    
    _userCollection=[[NSMutableArray alloc] init];
    
    [table registerNib:[UINib nibWithNibName:[UserCollectionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserCollectionCell reuseIdentifier]];
    templateTable=[[TableTemplate alloc] initWithTableView:table withDelegate:self];
    
    CGRect rect=table.frame;
    rect.origin=CGPointZero;
    rect.size.height=5;
    UIView *vi =[[UIView alloc] initWithFrame:rect];
    vi.backgroundColor=[UIColor clearColor];
    table.tableHeaderView=vi;
}

-(bool)tableTemplateAllowLoadMore:(TableTemplate *)tableTemplate
{
    return true;
}

-(void)tableTemplateLoadNext:(TableTemplate *)tableTemplate wait:(bool *)isWait
{
    [self loadCollectionAtPage:_page];
    
    *isWait=true;
}

- (void)viewDidUnload {
    lblPoint = nil;
    btnPoint = nil;
    avatar = nil;
    table = nil;
    blurTop = nil;
    blurBottom = nil;
    [super viewDidUnload];
}

- (IBAction)btnPointTouchUpInside:(id)sender {
}

- (IBAction)btnUpTouchUpInside:(id)sender {
}

- (IBAction)btnDownTouchUpInside:(id)sender {
}

-(NSArray *)rightNavigationItems
{
    return @[@(ITEM_FILTER),@(ITEM_COLLECTION),@(ITEM_LIST)];
}

-(void)loadUserCollection
{
    if(_operation)
    {
        [_operation cancel];
        _operation=nil;
    }
    
    _userCollection=[[NSMutableArray alloc] init];
    [table reloadData];
    _page=0;
    
    [avatar setSmartGuideImageWithURL:[NSURL URLWithString:[DataManager shareInstance].currentUser.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
    
    [self loadCollectionAtPage:0];
    
    [self.view showLoadingWithTitle:nil];
}

-(void) loadCollectionAtPage:(int) page
{
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    double lat=[DataManager shareInstance].currentUser.location.latitude;
    double lon=[DataManager shareInstance].currentUser.location.longitude;
    
    _operation=[[ASIOperationUserCollection alloc] initWithUserID:idUser lat:lat lon:lon page:page status:true];
    _operation.delegatePost=self;
    
    [_operation startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserCollection class]])
    {
        ASIOperationUserCollection *ope=(ASIOperationUserCollection*)operation;
        
        if(ope.userCollection.count>0)
        {
            [_userCollection addObjectsFromArray:ope.userCollection];
            
            _page++;
        }
        
        NSNumberFormatter *numF=[[NSNumberFormatter alloc] init];
        numF.groupingSeparator=@".";
        numF.numberStyle=NSNumberFormatterNoStyle;
        [numF setMaximumFractionDigits:0];
        
        lblPoint.text=[numF stringFromNumber:@(ope.totalSP)];
        
        [templateTable setAllowLoadMore:ope.userCollection.count==5];
        
        [self.view removeLoading];
        [templateTable endLoadNext];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self.view removeLoading];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _userCollection.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userCollection.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCollectionCell *cell=[tableView dequeueReusableCellWithIdentifier:[UserCollectionCell reuseIdentifier]];
    Shop *collection=[_userCollection objectAtIndex:indexPath.row];
    
    [cell loadData:collection];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Shop *collection=[_userCollection objectAtIndex:indexPath.row];
    [[RootViewController shareInstance] showShopDetailFromUserCollection:collection];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UserCollectionCell size].height+10;
}

-(NSArray *)disableRightNavigationItems
{
    return @[@(ITEM_FILTER),@(ITEM_COLLECTION)];
}

@end

@implementation UserCollectionView



@end