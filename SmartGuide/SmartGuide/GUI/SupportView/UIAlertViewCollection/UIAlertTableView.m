#import "UIAlertTableView.h"
#import <QuartzCore/QuartzCore.h>

#define kTablePadding 8.0f
#define TABLE_HEIGHT 250.f

@interface UIAlertTableView()

@end

@implementation UIAlertTableView

@synthesize tableAlertView;

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self alignControl];
}

-(void) alignControl
{
    NSMutableArray *buttons = [NSMutableArray array];
    
    for(id obj in self.subviews)
    {
        if([obj isKindOfClass:[UILabel class]])
        {
            UILabel *lbl = (UILabel*)obj;
            
            if(self.message)
            {
                if([lbl.text isEqualToString:self.message])
                {
                    _lableTitle=lbl;
                    continue;
                }
            }
            else
            {
                if([lbl.text isEqualToString:self.title])
                {
                    _lableTitle=lbl;
                    continue;
                }
            }
            
        }
        else if([NSStringFromClass([obj class]) isEqualToString:@"UIAlertButton"])
        {
            [buttons addObject:obj];
        }
    }
    
    int sections=[tableAlertView numberOfSections];
    float height=0;
    
    for(int section=0;section<sections;section++)
    {
        int rows=[tableAlertView numberOfRowsInSection:section];
        
        for(int row=0;row<rows;row++)
        {
            height+=[tableAlertView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]].size.height;
        }
    }
    
    float tableHeight=TABLE_HEIGHT;
    
    if(height<88)
        height=88;
    
    if(tableHeight>height)
        tableHeight=height;
    
    CGRect rect = self.frame;
    rect.origin.y-=tableHeight/2;
    rect.size.height+=tableHeight+25;
    [self setFrame:rect];
    
    if(_lableTitle)
    {
        rect.origin.x=_lableTitle.frame.origin.x;
        rect.origin.y=_lableTitle.frame.origin.y+_lableTitle.frame.size.height+15;
    }
    else
    {
        rect.origin.x=12;
        rect.origin.y=15;
    }
    
    if(buttons.count==0)
        tableHeight+=50;
    
    rect.size=CGSizeMake(260, tableHeight);
    
    tableAlertView.frame=rect;
    
    for(UIControl *btn in buttons)
    {
        rect=btn.frame;
        rect.origin.y=tableAlertView.frame.origin.y+tableAlertView.frame.size.height+5;
        [btn setFrame:rect];
    }
}

-(void)showOnOK:(void (^)())onOK onCancel:(void (^)())onCancel
{
    self.delegate=self;
    if(onOK)
        _onOK=[onOK copy];
    if(onCancel)
        _onCancel=[onCancel copy];
    
    [self show];
}

-(void)show
{
    if(!_isPrepare)
        [self prepare];
    
    [super show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        if(_onOK)
        {
            _onOK();
            _onOK=nil;
        }
    }
    else if(buttonIndex==1)
    {
        if(_onCancel)
        {
            _onCancel();
            _onCancel=nil;
        }
    }
}

- (void)prepare {
    tableAlertView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 260, 300) style:UITableViewStylePlain];
    tableAlertView.layer.cornerRadius=6;
    tableAlertView.autoresizingMask=UIViewAutoresizingNone;
    [self insertSubview:tableAlertView atIndex:0];
    
    _isPrepare=true;
}

@end