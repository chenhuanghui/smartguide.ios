//
//  SUInfoCell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SUInfoCell;

@protocol InfoCelLDelegate <NSObject>

-(void) infoCellTouchedMap:(SUInfoCell*) cell;

@end

@interface SUInfoCell : UITableViewCell

+(float) height;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<InfoCelLDelegate> delegate;

@end
