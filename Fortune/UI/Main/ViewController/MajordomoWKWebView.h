//
//  MajordomoWKWebView.h
//  ColorfulFund
//
//  Created by Madis on 2016/11/2.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
typedef void (^block_decisionHandler)(WKNavigationActionPolicy *);
@class MajordomoWKWebView;
@protocol MajordomoWKWebViewDelegate <NSObject>

- (void)majordomoWKWebView:(MajordomoWKWebView *)webView webViewContentHeightChanged:(CGFloat )contentHeight;

@end
@interface MajordomoWKWebView : UIView
@property (nonatomic, weak) IBOutlet id<MajordomoWKWebViewDelegate> delegate;
- (void)loadRequestWithURLString:(NSString *)urlString;
- (void)startload:(void (^)(WKWebView *webView,WKNavigation *navigation))startload;
- (void)didCommit:(void (^)(WKWebView *webView,WKNavigation *navigation))didCommit;
- (void)didFinish:(void (^)(WKWebView *webView,WKNavigation *navigation))didFinish;
- (void)didError:(void (^)(WKWebView *webView,WKNavigation *navigation,NSError *error))didError;

- (void)decidePolicyForNavigationResponse:(void (^)(WKWebView * webView, WKNavigationResponse *navigationResponse,block_decisionHandler *decisionHandler))decidePolicy;

@end
