//
//  Label.m
//  SmartGuide
//
//  Created by XXX on 7/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "Label.h"
#import <CoreText/CoreText.h>

@implementation Label
@synthesize characterSpacing;

- (void)drawTextInRect:(CGRect)rect
{
    if (characterSpacing>0)
    {
        // Drawing code
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSelectFont (context, [self.font.fontName cStringUsingEncoding:NSASCIIStringEncoding], self.font.pointSize, kCGEncodingMacRoman);
        CGContextSetCharacterSpacing(context, characterSpacing);
        CGContextSetFillColorWithColor(context, [self.textColor CGColor]);
        CGAffineTransform myTextTransform = CGAffineTransformScale(CGAffineTransformIdentity, 1.f, -1.f );
        CGContextSetTextMatrix (context, myTextTransform);
        
        CGGlyph glyphs[self.text.length];
        CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)self.font.fontName, self.font.pointSize, NULL);
        CTFontGetGlyphsForCharacters(fontRef, (const unichar*)[self.text cStringUsingEncoding:NSUnicodeStringEncoding], glyphs, self.text.length);
        float centeredY = (self.font.pointSize + (self.frame.size.height- self.font.pointSize)/2)-2;
        CGContextShowGlyphsAtPoint(context, rect.origin.x+rect.size.width/2-[self.text sizeWithFont:self.font constrainedToSize:self.frame.size].width/2, centeredY, (const CGGlyph *)glyphs, self.text.length);
        CFRelease(fontRef);
    }
    else
    {
        // no character spacing provided so do normal drawing
        [super drawTextInRect:rect];
    }
}

@end
