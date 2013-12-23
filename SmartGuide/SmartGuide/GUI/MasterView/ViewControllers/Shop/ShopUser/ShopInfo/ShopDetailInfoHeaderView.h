//
//  ShopDetailInfoHeaderView.h
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailInfoHeaderView : UIView
{
    __weak IBOutlet UILabel *lbl;
}

-(ShopDetailInfoHeaderView*) initWithTitle:(NSString*) title;

-(void) setTitle:(NSString*) title;

+(float) height;
+(NSString *)reuseIdentifier;

@end
