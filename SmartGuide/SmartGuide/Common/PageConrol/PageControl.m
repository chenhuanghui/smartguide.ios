//
//  PageControl.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PageControl.h"
#import "Utility.h"

// Tweak these or make them dynamic.
#define kDotDiameter 7.0
#define kDotSpacer 7.0

@implementation PageControl

@synthesize dotColorCurrentPage;
@synthesize dotColorOtherPage;
@synthesize currentPage;
@synthesize numberOfPages;
@synthesize delegate;

- (void)setCurrentPage:(NSInteger)page
{
    currentPage = MIN(MAX(0, page), self.numberOfPages-1);
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)pages
{
    numberOfPages = MAX(0, pages);
    currentPage = MIN(MAX(0, self.currentPage), numberOfPages-1);
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // Default colors.
        self.backgroundColor = [UIColor clearColor];
        self.dotColorCurrentPage = [UIColor blackColor];
        self.dotColorOtherPage = [UIColor lightGrayColor];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.dotColorCurrentPage = [UIColor blackColor];
        self.dotColorOtherPage = [UIColor lightGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, true);
    
    CGRect currentBounds = self.bounds;
    CGFloat dotsWidth = self.numberOfPages*kDotDiameter + MAX(0, self.numberOfPages-1)*kDotSpacer;
    CGFloat x = CGRectGetMidX(currentBounds)-dotsWidth/2;
    CGFloat y = CGRectGetMidY(currentBounds)-kDotDiameter/2;
    for (int i=0; i<self.numberOfPages; i++)
    {
        CGRect circleRect = CGRectMake(x, y, kDotDiameter, kDotDiameter);
        if (i == self.currentPage)
        {
            CGContextSetFillColorWithColor(context, self.dotColorCurrentPage.CGColor);
        }
        else
        {
            CGContextSetFillColorWithColor(context, self.dotColorOtherPage.CGColor);
        }
        CGContextFillEllipseInRect(context, circleRect);
        x += kDotDiameter + kDotSpacer;
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.delegate) return;
    
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];
    
    CGFloat dotSpanX = self.numberOfPages*(kDotDiameter + kDotSpacer);
    CGFloat dotSpanY = kDotDiameter + kDotSpacer;
    
    CGRect currentBounds = self.bounds;
    CGFloat x = touchPoint.x + dotSpanX/2 - CGRectGetMidX(currentBounds);
    CGFloat y = touchPoint.y + dotSpanY/2 - CGRectGetMidY(currentBounds);
    
    if ((x<0) || (x>dotSpanX) || (y<0) || (y>dotSpanY)) return;
    
    int page=floor(x/(kDotDiameter+kDotSpacer));
    
    if(self.currentPage!=page)
    {
        self.currentPage=page;
        if ([self.delegate respondsToSelector:@selector(pageControlPageDidChange:)])
        {
            [self.delegate pageControlPageDidChange:self];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView isHorizontal:(bool)isHorizontal
{
    if(isHorizontal)
    {
        self.currentPage=[scrollView currentPageForHoriTable];
    }
}

@end

@implementation PageControlNext

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, true);
    
    int numOfPage=self.numberOfPages;
    
    if(numOfPage>5)
        numOfPage=5;
    
    CGRect currentBounds = self.bounds;
    CGFloat dotsWidth = numOfPage*kDotDiameter + MAX(0, numOfPage-1)*kDotSpacer;
    CGFloat x = CGRectGetMidX(currentBounds)-dotsWidth/2;
    CGFloat y = CGRectGetMidY(currentBounds)-kDotDiameter/2;
    
    if(self.numberOfPages>5)
    {
        rect=CGRectMake(x, y, kDotDiameter, kDotDiameter);
        
        if(self.currentPage>=4)
            [self drawLeftArrow:rect];
        else
            [self drawPage:context rect:rect page:0];
        
        rect.origin.x += kDotDiameter + kDotSpacer;
        [self drawPage:context rect:rect page:1];
        rect.origin.x += kDotDiameter + kDotSpacer;
        [self drawPage:context rect:rect page:2];
        rect.origin.x += kDotDiameter + kDotSpacer;
        
        if(self.currentPage==self.numberOfPages-1)
            [self drawOtherPage:context rect:rect];
        else if(self.currentPage>=4)
            [self drawCurrentPage:context rect:rect];
        else
            [self drawPage:context rect:rect page:3];
        
        rect.origin.x += kDotDiameter + kDotSpacer;
        
        if(self.currentPage==self.numberOfPages-1)
            [self drawCurrentPage:context rect:rect];
        else
            [self drawRightArrow:rect];
        
        return;
    }
    
    for (int i=0; i<numOfPage; i++)
    {
        CGRect circleRect = CGRectMake(x, y, kDotDiameter, kDotDiameter);
        
        if (i == self.currentPage)
        {
            CGContextSetFillColorWithColor(context, self.dotColorCurrentPage.CGColor);
        }
        else
        {
            CGContextSetFillColorWithColor(context, self.dotColorOtherPage.CGColor);
        }
        CGContextFillEllipseInRect(context, circleRect);
        x += kDotDiameter + kDotSpacer;
    }
}

-(void) drawPage:(CGContextRef) context rect:(CGRect) rect page:(int) page
{
    if(self.currentPage==page)
        [self drawCurrentPage:context rect:rect];
    else
        [self drawOtherPage:context rect:rect];
}

-(void) drawCurrentPage:(CGContextRef) context rect:(CGRect) rect
{
    CGContextSetFillColorWithColor(context, self.dotColorCurrentPage.CGColor);
    CGContextFillEllipseInRect(context, rect);
}

-(void) drawOtherPage:(CGContextRef) context rect:(CGRect) rect
{
    CGContextSetFillColorWithColor(context, self.dotColorOtherPage.CGColor);
    CGContextFillEllipseInRect(context, rect);
}

-(void) drawLeftArrow:(CGRect) rect
{
    UIImage *img=[UIImage imageNamed:@"button_arrow.png"];
    
    rect.origin.y=(self.l_v_h-img.size.height)/2;
    
    UIImage *imgLeft =[[UIImage alloc] initWithCGImage:img.CGImage scale:2 orientation:UIImageOrientationDown];
    
    [imgLeft drawAtPoint:rect.origin];
}

-(void) drawRightArrow:(CGRect) rect
{
    UIImage *img=[UIImage imageNamed:@"button_arrow.png"];
    rect.origin.y=(self.l_v_h-img.size.height)/2;
    
    [img drawAtPoint:rect.origin];
}

-(void) btn:(UIButton*) sender
{
    [self.delegate pageControlTouchedNext:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.delegate) return;
    
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];
    
    int numOfPage=self.numberOfPages>0?self.numberOfPages+1:0;
    
    CGFloat dotSpanX = numOfPage*(kDotDiameter + kDotSpacer);
    CGFloat dotSpanY = kDotDiameter + kDotSpacer;
    
    CGRect currentBounds = self.bounds;
    CGFloat x = touchPoint.x + dotSpanX/2 - CGRectGetMidX(currentBounds);
    CGFloat y = touchPoint.y + dotSpanY/2 - CGRectGetMidY(currentBounds);
    
    if ((x<0) || (x>dotSpanX) || (y<0) || (y>dotSpanY)) return;
    
    int page=floor(x/(kDotDiameter+kDotSpacer));
    
    if(page==numOfPage-1)
    {
        [self.delegate pageControlTouchedNext:self];
        return;
    }
    
    if(self.currentPage!=page)
    {
        self.currentPage=page;
        if ([self.delegate respondsToSelector:@selector(pageControlPageDidChange:)])
        {
            [self.delegate pageControlPageDidChange:self];
        }
    }
}

@end