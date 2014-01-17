//
//  LabelURL.m
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LabelURL.h"
#import "Utility.h"
#import <CoreText/CoreText.h>

@interface LabelURL()<FTCoreTextViewDelegate>

@end

@implementation LabelURL
@synthesize isURL,delegate;

-(void)setText:(NSString *)text
{
    isURL=false;
    
    if(text.length>=4 && [[text substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"http"])
        isURL=true;
    
    self.userInteractionEnabled=isURL;
    
    if(isURL)
    {
        if(!_textView)
        {
            FTCoreTextView *textView=[[FTCoreTextView alloc] initWithFrame:CGRectMake(0, 8, self.l_v_w, self.l_v_h)];
            
            textView.delegate=self;
            textView.backgroundColor=self.backgroundColor;
            textView.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
            
            FTCoreTextStyle *style=[textView styleForName:FTCoreTextTagLink];
            
            style.font=self.font;
            style.underlined=true;
            style.textAlignment=FTCoreTextAlignementCenter;
            
            _textView=textView;
            
            [self addSubview:textView];
            
            _url=[NSURL URLWithString:text];
        }
        
        [_textView setText:[[NSString stringWithFormat:@"%@|%@",text,@"Liên kết"] stringByAppendingTagName:FTCoreTextTagLink]];
        
        [super setText:@""];
    }
    else
    {
        
        if(_textView)
        {
            [_textView removeFromSuperview];
            _textView=nil;
        }
        
        [super setText:text];
    }
}

-(void)coreTextView:(FTCoreTextView *)coreTextView receivedTouchOnData:(NSDictionary *)data
{
    if(_url)
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(lableURLWillOpenURL:url:)])
        {
            if(![self.delegate lableURLWillOpenURL:self url:_url])
                return;
        }
        
        [[UIApplication sharedApplication] openURL:_url];
    }
}

@end
