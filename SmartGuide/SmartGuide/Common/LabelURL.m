//
//  LabelURL.m
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LabelURL.h"
#import "Utility.h"

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
            FTCoreTextView *textView=[[FTCoreTextView alloc] initWithFrame:CGRectMake(0, 0, self.l_v_w, self.l_v_h)];
            
            [textView l_v_addX:5];
            [textView l_v_addW:-10];
            
            textView.delegate=self;
            textView.backgroundColor=self.backgroundColor;
            textView.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
            
            FTCoreTextStyle *style=[textView styleForName:FTCoreTextTagLink];
            
            style.font=self.font;
            style.underlined=true;
            style.textAlignment=FTCoreTextAlignementLeft;
            
            _textView=textView;
            
            [self addSubview:textView];
        }
        
        [_textView setText:[[NSString stringWithFormat:@"%@|%@",text,text] stringByAppendingTagName:FTCoreTextTagLink]];
        
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
    NSURL *url=[data objectForKey:FTCoreTextDataURL];
    
    if(url)
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(lableURLWillOpenURL:url:)])
        {
            if(![self.delegate lableURLWillOpenURL:self url:url])
                return;
        }
        
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
