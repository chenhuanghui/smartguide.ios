//
//  TabInboxListViewController.m
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabInboxListViewController.h"
#import "OperationMessageList.h"
#import "MessageList.h"
#import "MessageAction.h"
#import "MessageSender.h"
#import "TableTemplates.h"
#import "NavigationView.h"
#import "TabInboxListTableCell.h"

@interface TabInboxListViewController ()<ASIOperationPostDelegate, TableAPIDataSource, UITableViewDelegate>
{
    bool _canLoadMore;
    int _page;
    bool _loadingMore;
    
    OperationMessageList *_opeMsgList;
}

@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) NSMutableArray *msgFull;

@end

@implementation TabInboxListViewController

-(TabInboxListViewController *)initWithSender:(MessageSender *)sender
{
    self=[super init];
    
    _sender=sender;
    
    return self;
}

-(void) requestInboxList
{
    _opeMsgList=[[OperationMessageList alloc] initWithIDSender:_sender.idSender.integerValue page:_page userLat:userLat() userLng:userLng()];
    _opeMsgList.delegate=self;
    
    [_opeMsgList addToQueue];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    table.contentEdgeInsets=UIEdgeInsetsMake(15, 0, 0, 0);
    [table registerTabInboxListTableCell];
    
    self.messages=[NSMutableArray array];
    self.msgFull=[NSMutableArray array];
    
    if(_sender.messageNewest)
    {
        [self.messages addObject:_sender.messageNewest];
        [self.msgFull addObject:_sender.messageNewest];
    }
    
    _page=0;
    _canLoadMore=false;
    _loadingMore=false;
    
    table.canLoadMore=false;
    
    [self requestInboxList];
    
    [table showLoading];
}

#pragma mark UITableView DataSource

-(void)tableLoadMore:(TableAPI *)tableAPI
{
    if(_loadingMore)
        return;
    
    _loadingMore=true;
    
    [self requestInboxList];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MIN(_messages.count, 1);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messages.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageList *obj=_messages[indexPath.row];
    enum TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE displayType=TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE_SMALL;
    
    if([_msgFull containsObject:obj])
        displayType=TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE_FULL;
    
    return [tableView.tabInboxListTablePrototypeCell calculatorHeight:obj displayType:displayType];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabInboxListTableCell *cell=[tableView tabInboxListTableCell];
    MessageList *obj=_messages[indexPath.row];
    enum TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE displayType=TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE_SMALL;
    
    if([_msgFull containsObject:obj])
        displayType=TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE_FULL;
    
    [cell loadWithMessageList:obj displayType:displayType];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabInboxListTableCell *cell=(id)[tableView cellForRowAtIndexPath:indexPath];
    MessageList *obj=cell.obj;
    
    if([_msgFull containsObject:obj])
        return;
    
    NSMutableArray *array=[NSMutableArray array];

    for(id obj in _msgFull)
        [array addObject:[NSIndexPath indexPathForRow:[_messages indexOfObject:obj] inSection:0]];
    
    [_msgFull removeAllObjects];
    [_msgFull addObject:obj];
    
    [array addObject:indexPath];

    [table reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
    
    CGRect rect=[table rectForRowAtIndexPath:indexPath];
    
    [table setContentOffset:rect.origin animated:true];
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationMessageList class]])
    {
        [table removeLoading];
        
        OperationMessageList *ope=(id)operation;
        
        for(MessageList *obj in ope.messages)
        {
            if(_sender.messageNewest)
            {
                if(_sender.messageNewest.idMessage.integerValue==obj.idMessage.integerValue)
                    continue;
            }
            
            [_sender addMessagesObject:obj];
            [_messages addObject:obj];
        }
        
        [[DataManager shareInstance] save];
        
        _canLoadMore=ope.messages.count>=10;
        _loadingMore=false;
        _page++;
        
        table.canLoadMore=_canLoadMore;
        
        [table reloadData];
        
        _opeMsgList=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationMessageList class]])
    {
        _opeMsgList=nil;
    }
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

-(void)dealloc
{
    OperationRelease(_opeMsgList);
}

@end
