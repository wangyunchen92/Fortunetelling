//
//  PayDetailViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/4/12.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PayDetailViewController.h"

@interface PayDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *alPayView;
@property (weak, nonatomic) IBOutlet UIView *weiPayView;
@property(nonatomic, strong)PayViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *payMoneyButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (nonatomic, strong)UIWebView *webview;

@end

@implementation PayDetailViewController
- (instancetype)initWithViewModel:(PayViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.size.height-64)];
        self.webview.hidden = YES;
        self.webview.delegate = self;
        [self.view addSubview:self.webview];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"八字测算" leftImage:@"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    @weakify(self);
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        self.moneyLabel.text = self.viewModel.money;
        [self.payMoneyButton setTitle:self.viewModel.payMoney forState:UIControlStateNormal];
    };
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel.subject_getDate sendNext:@YES];
}

- (void)loadUIData {
    self.alPayView.layer.borderWidth = 1;
    self.alPayView.layer.borderColor = RGB(209, 89, 82).CGColor;
    self.weiPayView.layer.borderWidth = 1;
    self.weiPayView.layer.borderColor = RGB(209, 89, 82).CGColor;
}

- (IBAction)alPayAction:(id)sender {
    
    [self.viewModel.subject_getPaySigin sendNext:@YES];
    @weakify(self);
    
    self.viewModel.block_canPay = ^(NSString *sigin) {
                @strongify(self);

        self.webview.hidden = NO;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.viewModel.webPayRequestUrl]];
        NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
        //Cookies数组转换为requestHeaderFields
        NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
        //设置请求头
        request.allHTTPHeaderFields = requestHeaderFields;
        [self.webview loadRequest:request];

        
        //        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.viewModel.webPayRequestUrl]];
//
//        [self.webview loadRequest:req];

//        NSString *appScheme = @"com.Fortune.youmeng";
//        [AliPayObject CreateAliPayWithSigin:sigin appScheme:appScheme andScallback:^(id obj) {
//            {
//                NSDictionary *payInfo = obj;
//                @strongify(self);
//                if([payInfo[@"resultStatus"] isEqualToString:@"9000"]) {
//                    //支付成功
//                    if (self.block_payResult) {
//                        self.block_payResult(YES);
//                    }
//                }else if([payInfo[@"resultStatus"] isEqualToString:@"8000"]) {
//                    //正在处理
//
//                }else if([payInfo[@"resultStatus"] isEqualToString:@"4000"]) {
//                    //订单支付失败
//                    if (self.block_payResult) {
//                        self.block_payResult(NO);
//                    }
//                }else if([payInfo[@"resultStatus"] isEqualToString:@"6001"]) {
//                    //用户中途取消
//                    if (self.block_payResult) {
//                        self.block_payResult(NO);
//                    }
//
//                }else if([payInfo[@"resultStatus"] isEqualToString:@"6002"]) {
//                    //网络连接出错
//                    if (self.block_payResult) {
//                        self.block_payResult(NO);
//                    }
//                }
//            }
//        }];
    };
//        订单ID 商品名称 商品详情 商品价格 商家信息 scheme 回调url
//    NSString *partner = @"2088612301888269";
//    NSString *seller = @"butterfly02@shanggong.sh.cn";
//    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMTyLdYdgafOQ1M9\nnCHSbstTBakA4598jgR8PYk8MxNRhLHblpvXo98JXSPgigAvOSwfCmwNldO8fku0\nLfmxWHv2JYHmSMz+HpdU7UhUJeIEj+z5+NEz22p/l6NNtSZD8vxi/+n+K8Ap2/2g\nWYpjZjhkIgFzz5JJaS3ikAJwzDXXAgMBAAECgYA1y2TDwGmC2W9AVGrKPj1vIi1A\nnXKPRKlSBlGUo7Hby/9vyWgZB0zGhjs/qnxnUn7OU2g4XXmYTTs+GGgadNuS/dUg\nPEJ08JmPlU7R8W6ceuBSA2jaEJ0zf3iOhe22v1WEmnhvn8Oum2i33JaoQhoNhKzs\n8LbwJIJLJBE9hlUeUQJBAOXcKGdhcAxgQymkN0hMj6DCwyfLXKuyjQzQpQPWR+a6\nm8Oy+JHQxwhKElI8xB7fLwZbZ8jW6LuWV62s/99NUE8CQQDbV86K+mUJrQz7L5CF\nTF+ncopQGUUW1e7B0UaWO98xYl2ehxp2wxQHn6E8iyL0gnc6wsmUuI20LBuahIQC\n/hf5AkBdo4RqKQ2GXSi/LADBWT8hlHYAHh5Qa9p+H/k5SO/dlKOj46LTdCPAwrwX\n+F1E3lK/2ji7XqFM2gA55kIOa+aNAkEA1X/XhEGL/Woa+5hltMoNRWDhLmwaasrb\ntn5slak7a8dSVw8sfDMQGQeRGuxXnuYrBeA59G/bRme0iqe4E22eiQJBAM1gnVKG\nE568ImvBNn1fvl//0Slh0E7xbyjSGvQebLr7LiD+Cl6lgQfZcDWrohYnPvzB7p2o\nDiQBiU+lzfJ7COM=";
//    NSString *appScheme = @"zhifubaodemo";//应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *backurl =@"http://1.szmytravel.sinaapp.com/home/index/DoPayDemo";//回调url
//    //订单ID 商品名称 商品详情 商品价格 商家信息 scheme 回调url
//    [AliPayObject CreateALiPayWithOrderID:@"8888" orderName:@"测试" orderDescription:@"测试内容" orderPrice:@"0.01" andpartner:partner seller:seller privateKey:privateKey appScheme:appScheme backurl:backurl andScallback:^(id obj) {
//        NSDictionary *payInfo = obj;
//
//        if([payInfo[@"resultStatus"] isEqualToString:@"9000"]) {
//            //支付成功
//
//        }else if([payInfo[@"resultStatus"] isEqualToString:@"8000"]) {
//            //正在处理
//
//        }else if([payInfo[@"resultStatus"] isEqualToString:@"4000"]) {
//            //订单支付失败
//        }else if([payInfo[@"resultStatus"] isEqualToString:@"6001"]) {
//            //用户中途取消
//        }else if([payInfo[@"resultStatus"] isEqualToString:@"6002"]) {
//            //网络连接出错
//
//        }
//    }];
//
}
- (IBAction)goBackTop:(UITapGestureRecognizer *)sender {
    [self.scrollerView setContentOffset:CGPointMake(0, 0) animated:YES];
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"开始加载数据 request == %@",request);
    
    if ([[webView.request.URL absoluteString] containsString:@"detail"]) {
        if (self.block_payResult) {
            self.block_payResult(YES);
        }
    }
    //    [content evaluateScript:@"hideOther()"];
    return YES;
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
