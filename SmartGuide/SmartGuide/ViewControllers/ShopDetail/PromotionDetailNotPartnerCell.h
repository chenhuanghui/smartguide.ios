//
//  PromotionDetailNotPartnerCell.h
//  SmartGuide
//
//  Created by MacMini on 11/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLabel;

@interface PromotionDetailNotPartnerCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet LLabel *txtContent;
    __weak IBOutlet UILabel *lblLine;
}

-(void) loadWithTitle:(NSString*) title content:(NSString*) content;
-(void) setLineVisible:(bool) visible;
+(float) heightWithContent:(NSString*) content;
+(NSString *)reuseIdentifier;

@end

@interface LLabel : UILabel

@end