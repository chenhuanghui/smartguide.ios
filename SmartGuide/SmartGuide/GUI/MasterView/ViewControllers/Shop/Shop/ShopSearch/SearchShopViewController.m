//
//  SearchShopViewController.m
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SearchShopViewController.h"
#import "GUIManager.h"
#import "SearchShopCell.h"
#import "SearchShopHeaderCell.h"

@interface SearchShopViewController ()
{
    SearchShopBGView *bg1;
    SearchShopBGView *bg2;
}

@end

@implementation SearchShopViewController
@synthesize delegate,searchController;

- (SearchShopViewController *)initWithKeyword:(NSString *)keyword
{
    self = [super initWithNibName:@"SearchShopViewController" bundle:nil];
    if (self) {
        // Custom initialization
        
        _keyword=[NSString stringWithStringDefault:keyword];
    }
    return self;
}

-(void)setKeyword:(NSString *)keyword
{
    _keyword=keyword;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [table registerNib:[UINib nibWithNibName:[SearchShopCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SearchShopCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[SearchShopHeaderCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SearchShopHeaderCell reuseIdentifier]];
    
    _autocomplete=[[NSMutableDictionary alloc] init];
    
    txt.text=_keyword;
    txt.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txt.l_v_h)];
    txt.leftView.backgroundColor=[UIColor clearColor];
    txt.leftViewMode=UITextFieldViewModeAlways;
    
    [txt becomeFirstResponder];
    [txt addTarget:self action:@selector(textFieldDidChangedText:) forControlEvents:UIControlEventEditingChanged];
    
    _placeLists=[NSMutableArray array];
    
    _pagePlacelist=-1;
    [self requestPlacelist];
}

-(void) reloadData
{
    [table reloadData];
    
    if(bg1)
    {
        [bg1 removeFromSuperview];
        bg1=nil;
    }
    
    if(bg2)
    {
        [bg2 removeFromSuperview];
        bg2=nil;
    }
    
    if([table numberOfSections]==0)
        return;
    
    CGRect rect=CGRectZero;
    
    if([table numberOfRowsInSection:0]>0)
    {
        rect=[table rectForSection:0];
        
        if([table numberOfSections]>1)
        {
            rect.origin.y+=[table rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].size.height;
            rect.size.height-=[table rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].size.height;
        }
        
//        rect.size.height-=4;
        
        SearchShopBGView *bg=[[SearchShopBGView alloc] initWithFrame:rect];

        [table insertSubview:bg atIndex:0];
        
        bg1=bg;
    }
    
    if([table numberOfSections]>=2)
    {
        if([table numberOfRowsInSection:1]>0)
        {
            rect=[table rectForSection:1];
            
            rect.origin.y+=[table rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].size.height;
            rect.size.height-=[table rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].size.height;
            
//            rect.size.height-=4;
            
            SearchShopBGView *bg=[[SearchShopBGView alloc] initWithFrame:rect];

            [table insertSubview:bg atIndex:0];
            
            bg2=bg;
        }
    }
}

-(void) requestPlacelist
{
    if(_operationPlacelistGetList)
    {
        [_operationPlacelistGetList cancel];
        _operationPlacelistGetList=nil;
    }
    
    _operationPlacelistGetList = [[ASIOperationPlacelistGetList alloc] initWithUserLat:userLat() userLng:userLng() page:_pagePlacelist+1];
    _operationPlacelistGetList.delegatePost=self;
    
    [_operationPlacelistGetList startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationPlacelistGetList class]])
    {
        ASIOperationPlacelistGetList *ope=(ASIOperationPlacelistGetList*) operation;
        
        [_placeLists addObjectsFromArray:ope.placeLists];
        _pagePlacelist++;
        
        _canLoadMorePlaceList=ope.placeLists.count==10;
        _isLoadingMore=false;
        
        _operationPlacelistGetList=nil;
        
        
        [self reloadData];
    }
    else if([operation isKindOfClass:[ASIOperationShopUser class]])
    {
        [self.view removeLoading];
        
        ASIOperationShopUser *ope=(ASIOperationShopUser*) operation;
        
        if(ope.shop)
            [[GUIManager shareInstance] presentShopUserWithShopUser:ope.shop];
        
        _operationShopUser=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationPlacelistGetList class]])
    {
        _operationPlacelistGetList=nil;
    }
    else if([operation isKindOfClass:[ASIOperationShopUser class]])
    {
        [self.view removeLoading];
        
        _operationShopUser=nil;
    }
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationSearchAutocomplete class]])
    {
        OperationSearchAutocomplete *ope=(OperationSearchAutocomplete*) operation;
        
        [_autocomplete setObject:@[ope.shops,ope.placelists] forKey:ope.keyword];
        [_searchInQuery removeObject:ope.keyword];
        
        if([[txt.text lowercaseString] isEqualToString:[ope.keyword lowercaseString]])
            [self reloadData];
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) btnBackTouchUpInside:(id)sender
{
    [self.delegate searchShopControllerTouchedBack:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_searchKey.length>0)
    {
        _searchDisplayKey=[_searchKey copy];
        return ([self shopsForKeyword:_searchKey].count+[self placelistsForKeyword:_searchKey].count)>0?2:0;
    }
    
    _searchDisplayKey=@"";
    
    return _placeLists.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_searchDisplayKey.length>0)
    {
        int count=0;
        switch (section) {
            case 0:
                count=[self shopsForKeyword:_searchDisplayKey].count;
                return count==0?0:count+1;
                
            case 1:
                count=[self placelistsForKeyword:_searchDisplayKey].count;
                return count==0?0:count+1;
                
            default:
                break;
        }
        
        return 0;
    }
    
    return _placeLists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_searchDisplayKey.length>0)
    {
        switch (indexPath.section) {
            case 0:
            {
                if(indexPath.row==0)
                {
                    SearchShopHeaderCell *cell=[table dequeueReusableCellWithIdentifier:[SearchShopHeaderCell reuseIdentifier]];
                    
                    [cell setHeaderText:@"Cửa hàng"];
                    
                    return cell;
                }
                
                SearchShopCell *cell=[tableView dequeueReusableCellWithIdentifier:[SearchShopCell reuseIdentifier]];
                
                [cell loadWithDataAutocompleteShop:[self shopsForKeyword:_searchDisplayKey][indexPath.row-1]];
                [cell setIsLastCell:indexPath.row==[table numberOfRowsInSection:indexPath.section]-1];
                
                return cell;
            }
                
            case 1:
            {
                if(indexPath.row==0)
                {
                    SearchShopHeaderCell *cell=[table dequeueReusableCellWithIdentifier:[SearchShopHeaderCell reuseIdentifier]];
                    
                    [cell setHeaderText:@"Placelist"];
                    
                    return cell;
                }
                
                SearchShopCell *cell=[tableView dequeueReusableCellWithIdentifier:[SearchShopCell reuseIdentifier]];
                
                [cell loadWithDataAutocompletePlace:[self placelistsForKeyword:_searchDisplayKey][indexPath.row-1]];
                [cell setIsLastCell:indexPath.row==[table numberOfRowsInSection:indexPath.section]-1];
                
                return cell;
            }
                
            default:
                return [UITableViewCell new];
        }
    }
    
    SearchShopCell *cell=[tableView dequeueReusableCellWithIdentifier:[SearchShopCell reuseIdentifier]];
    
    [cell loadWithPlace:_placeLists[indexPath.row]];
    [cell setIsLastCell:indexPath.row==[table numberOfRowsInSection:indexPath.section]-1];
    
    if(indexPath.row==_placeLists.count-1)
    {
        if(_canLoadMorePlaceList)
        {
            if(!_isLoadingMore)
            {
                //[self requestPlacelist];
                _isLoadingMore=true;
            }
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_searchDisplayKey.length>0)
    {
        if(indexPath.row==0)
            return [SearchShopHeaderCell height];
    }
    
    return [SearchShopCell height];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:true];
    
    if(_searchDisplayKey.length>0)
    {
        if(indexPath.row==0)
            return;
    }
    
    SearchShopCell *cell=(SearchShopCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if([cell.value isKindOfClass:[AutocompletePlacelist class]])
    {
        
    }
    else if([cell.value isKindOfClass:[AutocompleteShop class]])
    {
        [self.view showLoading];
        
        AutocompleteShop *shop=cell.value;
        _operationShopUser=[[ASIOperationShopUser alloc] initWithIDShop:shop.idShop userLat:userLat() userLng:userLng()];
        _operationShopUser.delegatePost=self;
        
        [_operationShopUser startAsynchronous];
    }
    else if([cell.value isKindOfClass:[Placelist class]])
    {
        [self.delegate searchShopControllerTouchPlaceList:self placeList:cell.value];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //[self.view endEditing:true];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    return true;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.delegate searchShopControllerSearch:self keyword:textField.text];
    
    return true;
}

-(void) textFieldDidChangedText:(UITextField*) textField
{
    _searchKey=[textField.text lowercaseString];
    NSData *data=[_searchKey dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:true];
    
    if(data)
    {
        _searchKey=[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    }
    
    if(textField.text.length==0)
    {
        [self reloadData];
        return;
    }
    
    if(_autocomplete[_searchKey])
    {
        [self reloadData];
        return;
    }
    else
    {
        if([_searchInQuery containsObject:_searchKey])
            return;
        
        [_searchInQuery addObject:_searchKey];
        
        [self callAutocomplete:_searchKey];
    }
}

-(void) callAutocomplete:(NSString*) keyword
{
    NSLog(@"callAutocomplete %@",keyword);
    
    OperationSearchAutocomplete *ope=[[OperationSearchAutocomplete alloc] initWithKeyword:keyword];
    ope.delegate=self;
    
    [ope start];
}

-(void) keyboardWillShow:(NSNotification*) notification
{
    float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    float height=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:duration animations:^{
        [table l_v_setH:self.view.l_v_h-topView.l_v_h-height];
    }];
}

-(void) keyboardWillHide:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        [table l_v_setH:self.view.l_v_h-topView.l_v_h];
    }];
}

-(void)dealloc
{
    if(_operationPlacelistGetList)
    {
        [_operationPlacelistGetList cancel];
        _operationPlacelistGetList=nil;
    }
}

-(NSArray*) dataForKeyword:(NSString*) keyword
{
    return _autocomplete[[keyword lowercaseString]];
}

-(NSArray*) shopsForKeyword:(NSString*) keyword
{
    NSArray *array=[self dataForKeyword:keyword];
    
    if(array)
        return array[0];
    
    return [NSArray array];
}

-(NSArray*) placelistsForKeyword:(NSString*) keyword
{
    NSArray *array=[self dataForKeyword:keyword];
    
    if(array)
        return array[1];
    
    return [NSArray array];
}

@end

@implementation SearchShopBGView

-(void)drawRect:(CGRect)rect
{
    if(!imgMid)
    {
        imgTop=[UIImage imageNamed:@"bg_feed_head_home.png"];
        imgMid=[UIImage imageNamed:@"bg_feed_mid_home.png"];
        imgBottom=[UIImage imageNamed:@"bg_feed_bottom_home.png"];
    }
    
    [imgTop drawInRect:CGRectMake(0, 0, imgTop.size.width, imgTop.size.height)];
    [imgBottom drawAtPoint:CGPointMake(0, rect.size.height-imgTop.size.height)];
    
    rect.origin.y=imgTop.size.height;
    rect.origin.x=0;
    rect.size.height-=(imgTop.size.height+imgBottom.size.height-1);
    
    [imgMid drawAsPatternInRect:rect];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    [self commonInit];
    
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    [self commonInit];
    
    return self;
}

-(void) commonInit
{
    self.backgroundColor=[UIColor clearColor];
    self.contentMode=UIViewContentModeRedraw;
}

@end