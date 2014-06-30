//
//  TutorialViewController.h
//  SmartGuide
//
//  Created by MacMini on 07/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class WebViewController;

@protocol WebViewDelegate <SGViewControllerDelegate>

-(void) webviewTouchedBack:(WebViewController*) controller;

@end

@interface WebViewController : SGViewController
{
    NSURL *_url;
}

-(WebViewController*) initWithURL:(NSURL*) url;

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, weak) id<WebViewDelegate> delegate;

@end

@interface TutorialViewController : WebViewController

@end

@interface TermsViewController : WebViewController

@end

@interface UIViewController(WebView)<WebViewDelegate>

-(void) showWebViewWithURL:(NSURL*) url onCompleted:(void(^)(WebViewController* webviewController)) completed;
-(void) dismissWebView;

@end