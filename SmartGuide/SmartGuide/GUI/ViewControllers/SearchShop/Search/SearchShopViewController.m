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
#import "SearchShopPlacelistCell.h"
#import "LoadingMoreCell.h"
#import "CityViewController.h"
#import "CityManager.h"

#define SEARCH_SHOP_NUMBER_OF_HIGHLIGHT_PLACE_LIST 3

@interface SearchShopViewController ()<CityControllerDelegate>
{
    SearchShopBGView *bg1;
    SearchShopBGView *bg2;
}

@end

@implementation SearchShopViewController
@synthesize delegate,searchController;

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

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
    
    _tableFrame=table.frame;
    
    [table registerNib:[UINib nibWithNibName:[SearchShopCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SearchShopCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[SearchShopHeaderCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SearchShopHeaderCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[SearchShopPlacelistCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[SearchShopPlacelistCell reuseIdentifier]];
    [table registerLoadingMoreCell];
    
    _autocomplete=[[NSMutableDictionary alloc] init];
    
    txt.text=_keyword;
    [txt addTarget:self action:@selector(textFieldDidChangedText:) forControlEvents:UIControlEventEditingChanged];
    
    if(txt.text.length>0)
    {
        txt.placeholder=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
    }
    
    _placeLists=[NSMutableArray array];
    
    _pagePlacelist=-1;
    [self requestPlacelist];
    
    if([CityManager shareInstance].idCitySearch)
        _idCity=[[CityManager shareInstance].idCitySearch integerValue];
    else
        _idCity=currentUser().idCity.integerValue;
    [self setCityName:CITY_NAME(_idCity)];
    [bgCity addShadow:1];
}

-(void) setCityName:(NSString*) cityName
{
    NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
    paraStyle.alignment=NSTextAlignmentCenter;
    
    NSAttributedString *attStr=APPLY_QUOTATION_MARK(cityName, @{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Roman" size:13],NSForegroundColorAttributeName:[UIColor darkGrayColor],NSParagraphStyleAttributeName:paraStyle}, @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor darkGrayColor],NSParagraphStyleAttributeName:paraStyle});
    
    [btnCity setAttributedTitle:attStr forState:UIControlStateNormal];
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_USER_CHANGED_CITY_SEARCH,NOTIFICATION_USER_CHANGED_CITY];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_USER_CHANGED_CITY_SEARCH])
    {
        int idCity=[CityManager shareInstance].idCitySearch.integerValue;
        [self changeCity:idCity name:CITY_NAME(idCity)];
    }
    else if([notification.name isEqualToString:NOTIFICATION_USER_CHANGED_CITY])
    {
        int idCity=currentUser().idCity.integerValue;
        [self changeCity:idCity name:CITY_NAME(idCity)];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [txt becomeFirstResponder];
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
    {
        [btnSearch setTitle:[NSString stringWithFormat:@"Tìm kiếm với \"%@\"",txt.text] forState:UIControlStateNormal];
        btnSearch.hidden=false;
        
        return;
    }
    
    btnSearch.hidden=true;
    
    CGRect rect=CGRectZero;
    
    switch ([self viewMode]) {
        case SEARCH_SHOP_VIEW_AUTOCOMPLETE:
        {
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
                    
                    SearchShopBGView *bg=[[SearchShopBGView alloc] initWithFrame:rect];
                    
                    [table insertSubview:bg atIndex:0];
                    
                    bg2=bg;
                }
            }
        }
            break;

        case SEARCH_SHOP_VIEW_PLACELIST:
        {
            rect=[table rectForSection:1];

            SearchShopBGView *bg=[[SearchShopBGView alloc] initWithFrame:rect];
            
            [table insertSubview:bg atIndex:0];
            
            bg1=bg;

        }
            break;
    }
    
    }

-(void) requestPlacelist
{
    if(_operationPlacelistGetList)
    {
        [_operationPlacelistGetList clearDelegatesAndCancel];
        _operationPlacelistGetList=nil;
    }
    
    _operationPlacelistGetList = [[ASIOperationPlacelistGetList alloc] initWithUserLat:userLat() userLng:userLng() page:_pagePlacelist+1];
    _operationPlacelistGetList.delegate=self;
    
    [_operationPlacelistGetList addToQueue];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationPlacelistGetList class]])
    {
        ASIOperationPlacelistGetList *ope=(ASIOperationPlacelistGetList*) operation;
        
        [_placeLists addObjectsFromArray:ope.placeLists];
        _pagePlacelist++;
        
        _canLoadMorePlaceList=ope.placeLists.count>=10;
        _isLoadingMore=false;
        
        _operationPlacelistGetList=nil;
        
        
        [self reloadData];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationPlacelistGetList class]])
    {
        _operationPlacelistGetList=nil;
    }
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationSearchAutocomplete class]])
    {
        OperationSearchAutocomplete *ope=(OperationSearchAutocomplete*) operation;
        
        [_autocomplete setObject:@[ope.shops,ope.placelists] forKey:ope.keyword];
        [_searchInQuery removeObject:ope.keyword];

        if([_operationsAutocompleted objectForKey:ope.keyword])
            [_operationsAutocompleted removeObjectForKey:ope.keyword];
        
        if([[txt.text lowercaseString] isEqualToString:[ope.keyword lowercaseString]])
            [self reloadData];
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationSearchAutocomplete class]])
    {
        OperationSearchAutocomplete *ope=(OperationSearchAutocomplete*) operation;
        
        [_autocomplete setObject:@[ope.shops,ope.placelists] forKey:ope.keyword];
        [_searchInQuery removeObject:ope.keyword];
        
        if([_operationsAutocompleted objectForKey:ope.keyword])
            [_operationsAutocompleted removeObjectForKey:ope.keyword];
        
        if([[txt.text lowercaseString] isEqualToString:[ope.keyword lowercaseString]])
            [self reloadData];
    }
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
    
    return _placeLists.count==0?0:2;
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
    else
    {
        if(_placeLists.count>SEARCH_SHOP_NUMBER_OF_HIGHLIGHT_PLACE_LIST)
        {
            if(section==0)
                return SEARCH_SHOP_NUMBER_OF_HIGHLIGHT_PLACE_LIST;
            else
                return _placeLists.count-SEARCH_SHOP_NUMBER_OF_HIGHLIGHT_PLACE_LIST+(_canLoadMorePlaceList?1:0);
        }
        else
        {
            if(section==0)
                return _placeLists.count+(_canLoadMorePlaceList?1:0);
            else
                return 0;
        }
    }
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
                    
                    [cell setHeaderText:@"Địa điểm"];
                    
                    return cell;
                }
                
                SearchShopCell *cell=[tableView dequeueReusableCellWithIdentifier:[SearchShopCell reuseIdentifier]];
                
                [cell loadWithDataAutocompleteShop:[self shopsForKeyword:_searchDisplayKey][indexPath.row-1]];
                
                if(indexPath.row==1)
                    [cell setCellType:SEARCH_SHOP_CELL_FIRST];
                else if(indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
                    [cell setCellType:SEARCH_SHOP_CELL_LAST];
                else
                    [cell setCellType:SEARCH_SHOP_CELL_MID];
                
                return cell;
            }
                
            case 1:
            {
                if(indexPath.row==0)
                {
                    SearchShopHeaderCell *cell=[table dequeueReusableCellWithIdentifier:[SearchShopHeaderCell reuseIdentifier]];
                    
                    [cell setHeaderText:@"Danh sách địa điểm"];
                    
                    return cell;
                }
                
                SearchShopCell *cell=[tableView dequeueReusableCellWithIdentifier:[SearchShopCell reuseIdentifier]];
                
                [cell loadWithDataAutocompletePlace:[self placelistsForKeyword:_searchDisplayKey][indexPath.row-1]];
                
                if(indexPath.row==1)
                    [cell setCellType:SEARCH_SHOP_CELL_FIRST];
                else if(indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
                    [cell setCellType:SEARCH_SHOP_CELL_LAST];
                else
                    [cell setCellType:SEARCH_SHOP_CELL_MID];
                
                return cell;
            }
                
            default:
                return [UITableViewCell new];
        }
    }
    else
    {
        if(indexPath.section==0)
        {
            SearchShopPlacelistCell *cell=[tableView dequeueReusableCellWithIdentifier:[SearchShopPlacelistCell reuseIdentifier]];
            
            [cell loadWithPlace:_placeLists[indexPath.row]];
            [cell setIsLastCell:indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1];
            
            return cell;
        }
        else
        {
            if(_canLoadMorePlaceList && indexPath.row==_placeLists.count-SEARCH_SHOP_NUMBER_OF_HIGHLIGHT_PLACE_LIST)
            {
                if(!_isLoadingMore)
                {
                    _isLoadingMore=true;
                    
                    [self requestPlacelist];
                }
                
                return [table loadingMoreCell];
            }
            
            SearchShopCell *cell=[tableView dequeueReusableCellWithIdentifier:[SearchShopCell reuseIdentifier]];
            
            [cell loadWithPlace:_placeLists[indexPath.row+SEARCH_SHOP_NUMBER_OF_HIGHLIGHT_PLACE_LIST]];
            
            if(indexPath.row==0)
                [cell setCellType:SEARCH_SHOP_CELL_FIRST];
            else if(indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
                [cell setCellType:SEARCH_SHOP_CELL_LAST];
            else
                [cell setCellType:SEARCH_SHOP_CELL_MID];
            
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
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([self viewMode]) {
        case SEARCH_SHOP_VIEW_AUTOCOMPLETE:
        {
            switch (indexPath.section) {
                case 0:
                {
                    if(indexPath.row==0)
                        return [SearchShopHeaderCell height];
                    
                    return [SearchShopCell heightWithDataAutocompleteShop:[self shopsForKeyword:_searchDisplayKey][indexPath.row-1]];
                }
                    
                case 1:
                    if(indexPath.row==0)
                        return [SearchShopHeaderCell height];
                    
                    return [SearchShopCell heightWithDataAutocompletePlace:[self placelistsForKeyword:_searchDisplayKey][indexPath.row-1]];
                    
                default:
                    return 0;
            }
        }
            break;
         
        case SEARCH_SHOP_VIEW_PLACELIST:
            if(indexPath.section==0)
                return [SearchShopPlacelistCell heightWithPlace:_placeLists[indexPath.row]];
            else
                if(_canLoadMorePlaceList && indexPath.row==_placeLists.count-SEARCH_SHOP_NUMBER_OF_HIGHLIGHT_PLACE_LIST)
                    return 36;
            
                return [SearchShopCell heightWithPlace:_placeLists[indexPath.row+SEARCH_SHOP_NUMBER_OF_HIGHLIGHT_PLACE_LIST]];
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(bg1)
        [tableView sendSubviewToBack:bg1];
    if(bg2)
        [tableView sendSubviewToBack:bg2];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:true];
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if([cell isKindOfClass:[SearchShopCell class]])
    {
        SearchShopCell *sCell=(SearchShopCell*)cell;
        
        if([sCell.value isKindOfClass:[AutocompletePlacelist class]])
        {
            AutocompletePlacelist *place=sCell.value;
            
            [SGData shareInstance].fScreen=SCREEN_CODE_SUGGEST;
            [[SGData shareInstance].fData setObject:txt.text forKey:@"enterKeywords"];
            [[SGData shareInstance].fData setObject:place.content forKey:@"chosenKeywords"];
            [[SGData shareInstance].fData setObject:@(0) forKey:@"type"];
            
            [self.delegate searchShopControllerTouchedIDPlacelist:self idPlacelist:[place.idPlacelist integerValue]];
        }
        else if([sCell.value isKindOfClass:[AutocompleteShop class]])
        {
            AutocompleteShop *shop=sCell.value;
            
            [SGData shareInstance].fScreen=SCREEN_CODE_SUGGEST;
            [[SGData shareInstance].fData setObject:txt.text forKey:@"enterKeywords"];
            [[SGData shareInstance].fData setObject:shop.content forKey:@"chosenKeywords"];
            [[SGData shareInstance].fData setObject:@(3) forKey:@"type"];
            
            [[GUIManager shareInstance].rootViewController presentShopUserWithIDShop:[shop.idShop integerValue]];
        }
        else if([sCell.value isKindOfClass:[Placelist class]])
        {
            [SGData shareInstance].fScreen=SCREEN_CODE_RECOMMENDATION;
            
            [self.delegate searchShopControllerTouchPlaceList:self placeList:sCell.value];
        }
    }
    else if([cell isKindOfClass:[SearchShopPlacelistCell class]])
    {
        [SGData shareInstance].fScreen=SCREEN_CODE_RECOMMENDATION;
        
        SearchShopPlacelistCell *pCell=(SearchShopPlacelistCell*)cell;
        [self.delegate searchShopControllerTouchPlaceList:self placeList:pCell.place];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [txt resignFirstResponder];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    return true;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [SGData shareInstance].fScreen=[self screenCode];
    
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
    
    OperationSearchAutocomplete *ope=[[OperationSearchAutocomplete alloc] initWithKeyword:keyword idCity:_idCity];
    ope.delegate=self;
    
    [ope start];
    
    if(!_operationsAutocompleted)
        _operationsAutocompleted=[NSMutableDictionary new];
    
    if(![_operationsAutocompleted objectForKey:keyword])
        [_operationsAutocompleted setObject:ope forKey:keyword];
}

-(void) keyboardWillShow:(NSNotification*) notification
{
//    float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    float height=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
//    [UIView animateWithDuration:duration animations:^{
//        [table l_v_setH:_tableFrame.size.height-height];
//    }];
}

-(void) keyboardWillHide:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
 
//    NSLog(@"XXX");
//    [UIView animateWithDuration:duration animations:^{
//        [table l_v_setH:_tableFrame.size.height];
//    }];
}

-(void)dealloc
{
    if(_operationsAutocompleted && _operationsAutocompleted.allValues.count>0)
    {
        while (_operationsAutocompleted.allKeys.count>0) {
            NSString *key=_operationsAutocompleted.allKeys[0];
            OperationURL *ope=[_operationsAutocompleted objectForKey:key];
            ope.delegate=nil;
            [ope cancel];
            
            [_operationsAutocompleted removeObjectForKey:key];
        }
    }
    
    if(_operationPlacelistGetList)
    {
        [_operationPlacelistGetList clearDelegatesAndCancel];
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

-(enum SEARCH_SHOP_VIEW_MODE) viewMode
{
    if(_searchDisplayKey.length==0)
        return SEARCH_SHOP_VIEW_PLACELIST;
    
    return SEARCH_SHOP_VIEW_AUTOCOMPLETE;
}

- (IBAction)btnSearchTouchUpInside:(id)sender {
    [SGData shareInstance].fScreen=[self screenCode];
    [self.delegate searchShopControllerSearch:self keyword:txt.text];
}

-(NSString *)screenCode
{
    if(txt.text.length==0)
        return SCREEN_CODE_RECOMMENDATION;
    else
        return SCREEN_CODE_SUGGEST;
}

- (IBAction)btnCityTouchUpInside:(id)sender {
    [self showCityController];
}

-(void) showCityController
{
    CityViewController *vc=[[CityViewController alloc] initWithSelectedIDCity:_idCity];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)cityControllerDidTouchedCity:(CityViewController *)controller idCity:(int)idCity name:(NSString *)name
{
    [[CityManager shareInstance] setIdCitySearch:@(idCity)];
    [self changeCity:idCity name:name];
}

-(void) changeCity:(int) idCity name:(NSString*) name
{
    if(_idCity==idCity)
        return;
    
    _idCity=idCity;
    [self setCityName:name];
    
    for(OperationSearchAutocomplete *ope in _operationsAutocompleted)
    {
        ope.delegate=nil;
        [ope cancel];
    }

    _keyword=@"";
    _searchDisplayKey=@"";
    _searchKey=@"";
    [_autocomplete removeAllObjects];
    [_searchInQuery removeAllObjects];
    txt.text=@"";
    
    [self textFieldDidChangedText:txt];
}

@end

@implementation SearchShopBGView

-(void)drawRect:(CGRect)rect
{
    if(!imgMid)
    {
        imgTop=[UIImage imageNamed:@"bg_top_search.png"];
        imgMid=[UIImage imageNamed:@"bg_mid_search.png"];
        imgBottom=[UIImage imageNamed:@"bg_bottom_search.png"];
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