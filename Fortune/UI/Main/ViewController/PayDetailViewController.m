//
//  PayDetailViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/4/12.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PayDetailViewController.h"
#import "AliPayObject.h"

@interface PayDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *alPayView;
@property (weak, nonatomic) IBOutlet UIView *weiPayView;
@property(nonatomic, strong)PayViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *payMoneyButton;

@end

@implementation PayDetailViewController
- (instancetype)initWithViewModel:(PayViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"八字测算" leftText:@"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = RGB(225, 75, 76);
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
    self.alPayView.layer.borderWidth = 0.5;
    self.alPayView.layer.borderColor = RGB(209, 89, 82).CGColor;
    self.weiPayView.layer.borderWidth = 0.5;
    self.weiPayView.layer.borderColor = RGB(209, 89, 82).CGColor;
}
- (IBAction)alPayAction:(id)sender {
    
    [self.viewModel.subject_getPaySigin sendNext:@YES];
    @weakify(self);
    self.viewModel.block_canPay = ^(NSString *sigin) {
        NSString *appScheme = @"com.Fortune.youmeng";
        [AliPayObject CreateAliPayWithSigin:sigin appScheme:appScheme andScallback:^(id obj) {
            {
                NSDictionary *payInfo = obj;
                 @strongify(self);
                if([payInfo[@"resultStatus"] isEqualToString:@"9000"]) {
                    //支付成功
                    if (self.block_payResult) {
                        self.block_payResult(YES);
                    }
                }else if([payInfo[@"resultStatus"] isEqualToString:@"8000"]) {
                    //正在处理
                    
                }else if([payInfo[@"resultStatus"] isEqualToString:@"4000"]) {
                    //订单支付失败
                    if (self.block_payResult) {
                        self.block_payResult(NO);
                    }
                }else if([payInfo[@"resultStatus"] isEqualToString:@"6001"]) {
                    //用户中途取消
                    if (self.block_payResult) {
                        self.block_payResult(NO);
                    }

                }else if([payInfo[@"resultStatus"] isEqualToString:@"6002"]) {
                    //网络连接出错
                    if (self.block_payResult) {
                        self.block_payResult(NO);
                    }
                }
            }
        }];
        //订单ID 商品名称 商品详情 商品价格 商家信息 scheme 回调url
//        [AliPayObject CreateALiPayWithOrderID:@"8888" orderName:@"测试" orderDescription:@"测试内容" orderPrice:@"0.01" andpartner:partner seller:seller privateKey:privateKey appScheme:appScheme backurl:backurl andScallback:^(id obj) {
//            NSDictionary *payInfo = obj;
//
//            if([payInfo[@"resultStatus"] isEqualToString:@"9000"]) {
//                //支付成功
//
//            }else if([payInfo[@"resultStatus"] isEqualToString:@"8000"]) {
//                //正在处理
//
//            }else if([payInfo[@"resultStatus"] isEqualToString:@"4000"]) {
//                //订单支付失败
//            }else if([payInfo[@"resultStatus"] isEqualToString:@"6001"]) {
//                //用户中途取消
//            }else if([payInfo[@"resultStatus"] isEqualToString:@"6002"]) {
//                //网络连接出错
//
//            }
//
//
//        }];
    };
    
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
