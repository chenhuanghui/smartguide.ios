//
//  UserCollectionViewController.h
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "ASIOperationUserCollection.h"
#import "TableTemplate.h"

@interface UserCollectionViewController : ViewController<ASIOperationPostDelegate,TableTemplateDelegate>
{
    __weak IBOutlet UILabel *lblPoint;
    __weak IBOutlet UIButton *btnPoint;
    __weak IBOutlet UIImageView *avatar;
    __weak IBOutlet UITableView *table;
    ASIOperationUserCollection *_operation;
    int _page;
    TableTemplate *templateTable;
    NSMutableArray *_userCollection;
    __weak IBOutlet UIView *blurTop;
    __weak IBOutlet UIView *blurBottom;
}

-(void) loadUserCollection;

@end

@interface UserCollectionView : UIView

@end