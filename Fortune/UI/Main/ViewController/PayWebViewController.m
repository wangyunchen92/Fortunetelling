//
//  PayWebViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/4/24.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PayWebViewController.h"
#import <WebKit/WebKit.h>
#import "YMWebProgressLayer.h"

@interface PayWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong)YMWebProgressLayer *progressLayer; ///< 网页加载进度条
@property(nonatomic,strong)MBProgressHUD* hub;
@end

@implementation PayWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"八字测算" leftImage:@"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.webView.delegate = self;
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: [NSURL URLWithString:self.payurl]];
    NSLog(@"urls ==- %@",self.payurl);
    [self.webView loadRequest:request];
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"开始加载数据 request == %@",request);
    [self.progressLayer startLoad];
    if ([[request.URL absoluteString] containsString:@"detail"]) {
        if (self.block_payResult) {
            self.block_payResult(YES);
        }
    }
    //    [content evaluateScript:@"hideOther()"];
    return YES;
}

- (void)navBarButtonAction:(UIButton *)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.progressLayer startLoad];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.progressLayer finishedLoad];
    [BasePopoverView hideHUDForWindow:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
