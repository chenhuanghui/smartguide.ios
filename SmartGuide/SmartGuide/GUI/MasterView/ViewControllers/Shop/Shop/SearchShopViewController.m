//
//  SearchShopViewController.m
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SearchShopViewController.h"

@interface SearchShopViewController ()

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

-(SearchShopViewController *)initWithPlacelist:(Placelist *)place
{
    self = [super initWithNibName:@"SearchShopViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _placelist=place;
    }
    return self;
}

-(void)setKeyword:(NSString *)keyword
{
    _keyword=keyword;
}

-(void)setPlacelist:(Placelist *)place
{
    _placelist=place;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

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
    
    [table showLoading];
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
        [table removeLoading];
        
        ASIOperationPlacelistGetList *ope=(ASIOperationPlacelistGetList*) operation;
        
        [_placeLists addObjectsFromArray:ope.placeLists];
        _pagePlacelist++;
        
        _canLoadMorePlaceList=ope.placeLists.count==10;
        _isLoadingMore=false;
        
        _operationPlacelistGetList=nil;

        
        [table reloadData];
    }
    else if([operation isKindOfClass:[ASIOperationSearchAutocomplete class]])
    {
        ASIOperationSearchAutocomplete *ope=(ASIOperationSearchAutocomplete*) operation;
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        
        [dict setObject:ope.shops forKey:@"shop"];
        [dict setObject:ope.placelists forKey:@"placelist"];
        
        [_autocomplete setObject:dict forKey:ope.keyword];
        
        if([txt.text isEqualToString:ope.keyword])
            [table reloadData];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationPlacelistGetList class]])
    {
        [table removeLoading];
        
        
        _operationPlacelistGetList=nil;
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
    if(txt.text.length>0)
    {
        return ([self shopsForKeyword:txt.text].count+[self placelistsForKeyword:txt.text].count)>0?2:0;
    }
    
    return _placeLists.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(txt.text.length>0)
    {
        switch (section) {
            case 0:
                return [self shopsForKeyword:txt.text].count;
                
            case 1:
                return [self placelistsForKeyword:txt.text].count;
                
            default:
                return 0;
        }
    }
    
    return _placeLists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(txt.text.length>0)
    {
        switch (indexPath.section) {
            case 0:
            {
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"auto_shop"];
                
                if(!cell)
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"auto_shop"];
                
                cell.imageView.image=[UIImage imageNamed:@"ava.png"];
                cell.textLabel.text=[self shopsForKeyword:txt.text][indexPath.row][AUTOCOMPLETE_KEY];
                
                return cell;
            }
                
            case 1:
            {
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"auto_place"];
                
                if(!cell)
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"auto_place"];
                
                cell.imageView.image=[UIImage imageNamed:@"ava.png"];
                cell.textLabel.text=[self placelistsForKeyword:txt.text][indexPath.row][AUTOCOMPLETE_KEY];
                
                return cell;
            }
                
            default:
                return [UITableViewCell new];
        }
    }
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"placelist"];
    
    if(!cell)
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"placelist"];
    
    cell.textLabel.text=[_placeLists[indexPath.row] title];
    
    if(indexPath.row==_placeLists.count-1)
    {
        if(_canLoadMorePlaceList)
        {
            if(!_isLoadingMore)
            {
                [self requestPlacelist];
                _isLoadingMore=true;
            }
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:true];
    
    [self.delegate searchShopControllerTouchPlaceList:self placeList:_placeLists[indexPath.row]];
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
    if(textField.text.length==0)
        return;
    
    if(_autocomplete[textField.text])
    {
        [table  reloadData];
        return;
    }
    else
    {
        ASIOperationSearchAutocomplete *ope=[[ASIOperationSearchAutocomplete alloc] initWithKeyword:textField.text userLat:userLat() userLng:userLng()];
        ope.delegatePost=self;
        
        [ope startAsynchronous];
    }
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

-(NSDictionary*) dataForKeyword:(NSString*) keyword
{
    return _autocomplete[keyword];
}

-(NSArray*) shopsForKeyword:(NSString*) keyword
{
    NSDictionary *dict=[self dataForKeyword:keyword];
    
    if(dict)
        return dict[@"shop"];
    
    return [NSArray array];
}

-(NSArray*) placelistsForKeyword:(NSString*) keyword
{
    NSDictionary *dict=[self dataForKeyword:keyword];
    
    if(dict)
        return dict[@"placelist"];
    
    return [NSArray array];
}

@end
