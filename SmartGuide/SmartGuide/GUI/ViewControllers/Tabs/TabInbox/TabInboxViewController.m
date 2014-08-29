//
//  TabInboxViewController.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabInboxViewController.h"
#import "OperationMessageSender.h"
#import "TabInboxTableCell.h"
#import "MessageSender.h"
#import "TabInboxSectionView.h"
#import "TableTemplates.h"
#import "TabInboxListViewController.h"

enum INBOX_SECTION_TYPE
{
    INBOX_SECTION_TYPE_UNREAD=0,
    INBOX_SECTION_TYPE_READ=1,
};

@interface TabInboxViewController ()<ASIOperationPostDelegate, TableAPIDataSource, UITableViewDelegate>
{
    OperationMessageSender *_opeMessageSender;
    
    int _page;
    bool _loadingMore;
    bool _canLoadMore;
}

@property (nonatomic, strong) NSMutableArray *message;
@property (nonatomic, strong) NSArray *messageUnread;
@property (nonatomic, strong) NSArray *messageRead;

@end

@implementation TabInboxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [table registerTabInboxTableCell];
    
    self.message=[NSMutableArray new];
    
    _canLoadMore=false;
    _loadingMore=false;
    _page=0;
    table.canLoadMore=false;
    
    [self requestMessages];
    
    [table showLoading];
}

-(void) requestMessages
{
    _opeMessageSender=[[OperationMessageSender alloc] initWithPage:_page type:MESSAGE_SENDER_TYPE_ALL userLat:userLat() userLng:userLng()];
    _opeMessageSender.delegate=self;
    
    [_opeMessageSender addToQueue];
}

-(void)tableLoadMore:(TableAPI *)tableAPI
{
    if(_loadingMore)
        return;
    
    _loadingMore=true;
    
    [self requestMessages];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==INBOX_SECTION_TYPE_UNREAD)
        return self.messageUnread.count;
    else
        return self.messageRead.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==INBOX_SECTION_TYPE_UNREAD)
        return self.messageUnread.count==0?0:[TabInboxSectionView height];
    else
        return self.messageRead.count==0?0:[TabInboxSectionView height];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==INBOX_SECTION_TYPE_UNREAD)
    {
        TabInboxSectionView *view=[[TabInboxSectionView alloc] initWithFrame:CGRectMake(0, 0, tableView.SW, [TabInboxSectionView height])];
        
        view.lbl.text=@"Tin chưa đọc";
        
        return view;
    }
    else
    {
        TabInboxSectionView *view=[[TabInboxSectionView alloc] initWithFrame:CGRectMake(0, 0, tableView.SW, [TabInboxSectionView height])];
        
        view.lbl.text=@"Tin đã đọc";
        
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==INBOX_SECTION_TYPE_UNREAD)
        return [[tableView tabInboxTablePrototypeCell] calculatorHeight:_messageUnread[indexPath.row]];
    else
        return [[tableView tabInboxTablePrototypeCell] calculatorHeight:_messageRead[indexPath.row]];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabInboxTableCell *cell=[tableView tabInboxTableCell];
    
    if(indexPath.section==INBOX_SECTION_TYPE_UNREAD)
        [cell loadWithMessageSender:_messageUnread[indexPath.row]];
    else
        [cell loadWithMessageSender:_messageRead[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabInboxTableCell *cell=(id)[tableView cellForRowAtIndexPath:indexPath];
    MessageSender *sender=cell.object;
    
    TabInboxListViewController *vc=[[TabInboxListViewController alloc] initWithSender:sender];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationMessageSender class]])
    {
        [table removeLoading];
        
        OperationMessageSender *ope=(id) operation;
        
        _loadingMore=false;
        _canLoadMore=ope.messages.count>=10;
        _page++;
        
        [self.message addObjectsFromArray:ope.messages];
        [self buildMessages];
        
        table.canLoadMore=_canLoadMore;
        [table reloadData];
        
        _opeMessageSender=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    _opeMessageSender=nil;
}

-(void) buildMessages
{
    self.messageUnread=[self.message filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%i", MessageSender_HighlightUnread, true]];
    self.messageRead=[self.message filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%i", MessageSender_HighlightUnread, false]];
}

-(void)dealloc
{
    if(_opeMessageSender)
    {
        [_opeMessageSender clearDelegatesAndCancel];
        _opeMessageSender=nil;
    }
}

@end
