//
//  PlacelistCreateCell.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "PlacelistCreateCell.h"
#import "AlertView.h"

@implementation PlacelistCreateCell
@synthesize delegate;

-(void)loadWithMode:(enum PLACELIST_CREATE_CELL_MODE)mode
{
    switch (mode) {
        case PLACELIST_CREATE_CELL_SMALL:
        {
            btnCreate.hidden=true;
            txtDesc.hidden=true;
        }
            break;
            
        case PLACELIST_CREATE_CELL_DETAIL:
        {
            btnCreate.alpha=0;
            txtDesc.alpha=0;
            btnCreate.hidden=false;
            txtDesc.hidden=false;
            [UIView animateWithDuration:0.2f animations:^{
                btnCreate.alpha=1;
                txtDesc.alpha=1;
            }];
        }
            break;
    }
}

+(NSString *)reuseIdentifier
{
    return @"PlacelistCreateCell";
}

+(float)heightWithMode:(enum PLACELIST_CREATE_CELL_MODE)mode
{
    switch (mode) {
        case PLACELIST_CREATE_CELL_SMALL:
            return 57;
            
        case PLACELIST_CREATE_CELL_DETAIL:
            return 178;
    }
}

- (IBAction)btnCreateTouchUpInside:(id)sender {
    
    if(txtName.text.length==0)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Nhập tên placelist" onOK:^{
            [txtName becomeFirstResponder];
        }];
        return;
    }
    
    [self.delegate placelistCreateCellTouchedCreate:self name:txtName.text desc:txtDesc.text];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    txtName.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    txtName.leftView.backgroundColor=[UIColor clearColor];
    txtName.leftViewMode=UITextFieldViewModeAlways;
    
    txtDesc.layer.cornerRadius=2;
    txtDesc.layer.masksToBounds=true;
    txtDesc.placeholder=@"Nhập mô tả";
}

-(void)focus
{
    [txtName becomeFirstResponder];
}

-(void)clear
{
    txtName.text=@"";
    txtDesc.text=@"";
}

@end
