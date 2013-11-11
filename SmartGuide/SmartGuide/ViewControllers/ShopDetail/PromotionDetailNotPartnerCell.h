//
//  PromotionDetailNotPartnerCell.h
//  SmartGuide
//
//  Created by MacMini on 11/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromotionDetailNotPartnerCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UITextView *txtContent;
    
}

-(void) loadWithTitle:(NSString*) title content:(NSString*) content;
+(float) heightWithContent:(NSString*) content;

@end
