//
//  CityViewController.m
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "CityViewController.h"
#import "CityTableViewCell.h"
#import "CityManager.h"
#import "KeyboardUtility.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CityViewController

-(CityViewController *)initWithSelectedIDCity:(int)idCity
{
    self = [super initWithNibName:@"CityViewController" bundle:nil];
    if (self) {
        _selectedIDCity=idCity;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[CityManager shareInstance] load];
    _filterCities=[CityManager shareInstance].cities;
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [bgCity addShadow:1];
    
    NSArray *array=[_filterCities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"idCity==%i",_selectedIDCity]];
    if(array.count>0)
        [btnCity setTitle:[array[0] name] forState:UIControlStateNormal];
    
    [table registerNib:[UINib nibWithNibName:[CityTableViewCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[CityTableViewCell reuseIdentifier]];
    
    txtSearch.leftViewType=TEXTFIELD_LEFTVIEW_LOCATION;
    
    [txtSearch becomeFirstResponder];
}

-(void)viewWillAppearOnce
{
    _tableFrame=table.frame;
    
    if([[KeyboardUtility shareInstance] keyboardState]==KEYBOARD_STATE_SHOWED)
    {
        [table l_v_setH:_tableFrame.size.height-[KeyboardUtility shareInstance].keyboardFrame.size.height];
    }
}

-(NSArray *)registerNotifications
{
    return @[UIKeyboardWillShowNotification, UIKeyboardWillHideNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIKeyboardWillShowNotification])
    {
        CGRect keyboardFrame=[[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        float duration=[notification.userInfo floatForKey:UIKeyboardAnimationDurationUserInfoKey];
        
        [UIView animateWithDuration:duration animations:^{
            [table l_v_setH:_tableFrame.size.height-keyboardFrame.size.height];
        }];
    }
    else if([notification.name isEqualToString:UIKeyboardWillHideNotification])
    {
        float duration=[notification.userInfo floatForKey:UIKeyboardAnimationDurationUserInfoKey];
        [UIView animateWithDuration:duration animations:^{
            table.frame=_tableFrame;
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)txtSearchTextChanged:(id)sender {
    
    NSString *keyword=[txtSearch.text lowercaseString];
    
    if(keyword.length==0)
        _filterCities=[CityManager shareInstance].cities;
    else
    {
        _filterCities=[[CityManager shareInstance].cities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name contains[cd] %@",keyword]];
    }
    
    [table reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _filterCities.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _filterCities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityTableViewCell *cell=(CityTableViewCell*) [tableView dequeueReusableCellWithIdentifier:[CityTableViewCell reuseIdentifier]];
    CityObject *obj=_filterCities[indexPath.row];
    enum CELL_POSITION cellPos=CELL_POSITION_MIDDLE;
    
    if(indexPath.row==0)
        cellPos=CELL_POSITION_TOP;
    else if(indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
        cellPos=CELL_POSITION_BOTTOM;
    
    [cell loadWithCityObject:obj marked:obj.idCity.integerValue==_selectedIDCity cellPos:cellPos];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityObject *obj=_filterCities[indexPath.row];
    
    return [CityTableViewCell heightWithCityObject:obj];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityObject *obj=_filterCities[indexPath.row];
    [self.delegate cityControllerDidTouchedCity:self idCity:obj.idCity.integerValue name:obj.name];
    [self.navigationController popViewControllerAnimated:true];
}

-(void)dealloc
{
    [[CityManager shareInstance] clean];
}

@end
