//
//  EmptyDataCell.h
//  SmartGuide
//
//  Created by MacMini on 20/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyDataCell : UITableViewCell
{
    
}

+(NSString *)reuseIdentifier;

@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@end

@interface UITableView(EmptyData)

-(void) registerEmptyDataCell;
-(EmptyDataCell*) emptyDataCell;
-(EmptyDataCell*) emptyDataCellWithDesc:(NSString*) desc;

@end