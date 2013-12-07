//
//  SUUserGalleryCell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SUUserGalleryCell;

@protocol UserGalleryDelegate <NSObject>

-(void) userGalleryTouchedMakePicture:(SUUserGalleryCell*) cell;

@end

@interface SUUserGalleryCell : UITableViewCell

+(float) height;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<UserGalleryDelegate> delegate;

@end
