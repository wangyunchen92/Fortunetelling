//
//  MajordomoWKWebView.m
//  ColorfulFund
//
//  Created by Madis on 2016/11/2.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "MajordomoWKWebView.h"


@interface MajordomoWKWebView()
<
WKNavigationDelegate
>
typedef void(^block_webState)(WKWebView *webView,WKNavigation *navigation);

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) WKWebView *webView;
@property (nonatomic, copy)block_webState startload;
@property (nonatomic, copy)block_webState didCommit;
@property (nonatomic, copy)block_webState didFinish;
@property (nonatomic, copy)void(^didError)(WKWebView *webView,WKNavigation *navigation,NSError *error);

@end

@implementation MajordomoWKWebView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self createUI];
}

- (void)createUI {
    [[NSBundle mainBundle] loadNibNamed:@"MajordomoWKWebView" owner:self options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:[WKWebViewConfiguration new]];
    webView.navigationDelegate = self;
    webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:webView];
    @weakify(self);
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
    self.webView = webView;
}

- (void)startload:(void (^)(WKWebView *webView,WKNavigation *navigation))startload {
    self.startload = startload;
}
- (void)didCommit:(void (^)(WKWebView *webView,WKNavigation *navigation))didCommit {
    self.didCommit = didCommit;
}

- (void)didFinish:(void (^)(WKWebView *webView,WKNavigation *navigation))didFinish {
    self.didFinish = didFinish;
}
- (void)didError:(void (^)(WKWebView *webView,WKNavigation *navigation,NSError *error))didError {
    self.didError =  didError;
}

#pragma mark - WKWebViewDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    if (self.startload) {
        self.startload(webView, navigation);
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    if (self.didCommit) {
        self.didCommit(webView, navigation);
    }
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    MSLog(@"当前加载的webView地址:\n%@",webView.URL.absoluteString);
    //获取WKWebView的contentHeight
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id Result, NSError * error) {
        CGFloat contentHeight = [Result floatValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(majordomoWKWebView:webViewContentHeightChanged:)]) {
                [self.delegate majordomoWKWebView:self webViewContentHeightChanged:contentHeight];
            }
        });
    }];
    
    if (self.didFinish) {
        self.didFinish(webView, navigation);
    }
}

//跳转失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (self.didError) {
        self.didError(webView, navigation, error);
    }
}

//请求之前，决定是否要跳转:用户点击网页上的链接，需要打开新页面时，将先调用这个方法。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
}

//接收到相应数据后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
}

- (void)loadRequestWithURLString:(NSString *)urlString {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

@end
