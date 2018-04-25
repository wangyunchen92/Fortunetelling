//
//  YMWebViewController.m
//  CloudPush
//
//  Created by YouMeng on 2017/3/7.
//  Copyright © 2017年 YouMeng. All rights reserved.
//

#import "YMWebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@interface YMWebViewController ()<WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate>
//@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong)WKWebView *webView;
@property(nonatomic,strong)YMWebProgressLayer *progressLayer; ///< 网页加载进度条
@property(nonatomic,strong)MBProgressHUD* hub;
@property (nonatomic, strong) dispatch_source_t timer;
@property (assign, nonatomic)BOOL isloadJS;
@property (nonatomic, assign)NSInteger loadtag;
@end

@implementation YMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:self.titleStr leftImage:@"Whiteback" rightImage:nil superView:nil];
    [self createNavWithTitle:self.titleStr leftText:@"" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    //加载界面
    self.webView = [[WKWebView alloc] init];
    self.webView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    [self.view addSubview:self.webView];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.userInteractionEnabled = YES;
    [RACObserve(self, urlStr) subscribeNext:^(id x) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: [NSURL URLWithString:self.urlStr]];
        NSLog(@"urls ==- %@",self.urlStr);
        [self.webView loadRequest:request];
    }];
    self.loadtag = 0;
}

// navBar 回调
- (void)navBarButtonAction:(UIButton *)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(YMWebProgressLayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [YMWebProgressLayer new];
        _progressLayer.frame = CGRectMake(0, 62, kScreenWidth, 2);
        _progressLayer.hidden = NO;
        [self.theSimpleNavigationBar.layer addSublayer:_progressLayer];
        // [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    }
    _progressLayer.hidden = NO;
    return _progressLayer;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.webView removeFromSuperview];
    self.webView = nil;
}

- (void)dealloc {
    [self.progressLayer closeTimer];
    [self.progressLayer removeFromSuperlayer];
    self.progressLayer = nil;
    self.webView = nil;
    NSLog(@"i am dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
     webView.alpha = 0;
    self.isloadJS = YES;
     [self.progressLayer startLoad];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

    if (self.isloadJS) {
        NSString *hideId = @"function hideId(str){\
        var oDiv =  document.getElementsByTagName('div');\
        for(var i=0; i<oDiv.length; i++)\
        {\
        if(oDiv[i].id){\
        if( oDiv[i].id.indexOf(str) >= 0 ){\
        oDiv[i].parentNode.style.display='none';\
        }\
        }\
        }\
        };\
        function getHeader(parent,sClass){\
        var aEle2=parent.getElementsByTagName('header');  \
        var aResult2=[];\
        var k=0;\
        for(k<0;k<aEle2.length;k++) {  \
        if(aEle2[k].className==sClass) { \
        aResult2.push(aEle2[k]);  \
        }  \
        };  \
        return aResult2;  \
        }\
        function getClass(parent,sClass) {  \
        var aEle=parent.getElementsByTagName('div');  \
        var aResult=[];  \
        var i=0;  \
        for(i<0;i<aEle.length;i++) {  \
        if(aEle[i].className==sClass) { \
        aResult.push(aEle[i]);  \
        }  \
        };  \
        return aResult;  \
        }\
        function removeTags(tagName,tagClass){\
        var tagElements = document.getElementsByTagName( 'a' );\
        for( var m = 0 ; m < tagElements.length ; m++ ){\
        if( tagElements[m].className == '_hb-box _hb-ani' ){\
        tagElements[m].parentNode.removeChild( tagElements[m] );\
        }\
        }\
        }\
        function hideOther() { \
        if(getHeader(document,'header-2').length>0){ \
        getHeader(document,'header-2')[0].style.display='none'; \
        } \
        if(getClass(document,'appStore').length>0){ \
        getClass(document,'appStore')[0].children[0].style.display='none'; \
        } \
        if(getClass(document,'mod').length>0){ \
        for (var i =0;i<getClass(document,'mod').length;i++){ \
        getClass(document,'mod')[i].style.display='none'; \
        } \
        } \
        if(getClass(document,'keywords clearfix').length>0){ \
        getClass(document,'keywords clearfix')[0].style.display='none'; \
        } \
        if(getClass(document,'mod-tsimg-wrapper').length>0){ \
        getClass(document,'mod-tsimg-wrapper')[0].style.display='none'; \
        } \
        if(getClass(document,'fly-fixed').length>0){ \
        getClass(document,'fly-fixed')[0].style.display='none'; \
        } \
        if(getClass(document,'share-btns').length>0){ \
        getClass(document,'share-btns')[0].style.display='none'; \
        } \
        if(getClass(document,'art-mod mod-yindao part').length>0){ \
        getClass(document,'art-mod mod-yindao part')[0].style.display='none'; \
        } \
        if(getClass(document,'mod-yindao ').length>0){ \
        getClass(document,'mod-yindao ')[0].style.display='none'; \
        } \
        if(getClass(document,'mod anti-t').length>0){ \
        getClass(document,'mod anti-t')[0].style.display='none'; \
        } \
        if(getClass(document,'detail-gg').length>0){ \
        getClass(document,'detail-gg')[0].style.display='none'; \
        } \
        if(getClass(document,'detail-gg').length>0){ \
        getClass(document,'detail-gg')[0].style.display='none'; \
        } \
        if(getClass(document,'baidu-bn').length>0){ \
        for (var j =0;j<getClass(document,'baidu-bn').length>0;j++){\
        getClass(document,'baidu-bn')[j].id='none'; \
        getClass(document,'baidu-bn')[j].style.display='none'; \
        } \
        } \
        removeTags('a','nofollow');\
        }";
        self.webfile  = [UserDefaultsTool getStringWithKey:@"webFile"];
        if ([self.webfile isEqualToString:@""] || !self.webfile) {
            self.webfile = hideId;
        }
        
        [webView evaluateJavaScript:self.webfile completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            
        }];
        
        [webView evaluateJavaScript:@"hideOther()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            [self.progressLayer finishedLoad];
            [BasePopoverView hideHUDForWindow:YES];
            self.isloadJS = NO;
            webView.alpha = 1;
        }];
    }
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"开始加载数据 request == %@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
@end
