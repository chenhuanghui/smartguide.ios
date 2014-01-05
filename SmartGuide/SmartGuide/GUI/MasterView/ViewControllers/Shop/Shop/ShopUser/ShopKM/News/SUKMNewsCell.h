//
//  SUKMNewsCell.h
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromotionNews.h"
#import "LabelTopText.h"

@interface SUKMNewsCell : UITableViewCell
{
    __weak IBOutlet UIView *containView;
    __weak IBOutlet UIImageView *cover;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet LabelTopText *lblContent;
}

-(void) loadWithPromotionNews:(PromotionNews*) news;

+(NSString *)reuseIdentifier;
+(float) heightWithPromotionNews:(PromotionNews*) news;

@end