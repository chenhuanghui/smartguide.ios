//
//  SUKM1Cell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopKM1Cell.h"

@interface SUKM1Cell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIView *bgStatusView;
    NSArray *data;
}

-(void) loadWithKM:(NSArray*) array;

+(NSString *)reuseIdentifier;
+(float) heightWithKM:(NSArray*) array;

@end

@interface PromotionDetailView : UIView
{
    UIImage *img;
}

@end