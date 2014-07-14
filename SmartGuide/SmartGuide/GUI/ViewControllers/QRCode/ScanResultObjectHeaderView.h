//
//  ScanResultObjectHeaderView.h
//  Infory
//
//  Created by XXX on 7/14/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanCodeRelatedContain;

@interface ScanResultObjectHeaderView : UIView
{
    __weak IBOutlet UILabel *lblTitle;
    
    __weak ScanCodeRelatedContain *_obj;
}

-(void) loadWithObject:(ScanCodeRelatedContain*) obj;
-(ScanCodeRelatedContain*) object;
+(float) height;

@end
