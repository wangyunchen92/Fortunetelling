//
//  ProductPayViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/6/29.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductPayViewController.h"
#import "ProductPayViewModel.h"
#import "DXLAddressPickView.h"
#import "AliPayObject.h"
#import "WXApi.h"
#import "weixingmanage.h"
#import "PayResultViewController.h"

@interface ProductPayViewController ()
@property (nonatomic, strong)ProductPayViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIButton *subButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *priceMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *weichatView;
@property (weak, nonatomic) IBOutlet UIView *zhifubaoView;
@property (weak, nonatomic) IBOutlet UITextView *noteView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextView *nodeTextView;
@property (nonatomic, strong)DXLAddressPickView *addressPickerView;
@property (weak, nonatomic) IBOutlet UILabel *choseLabel;
@property (nonatomic, copy)NSString *chonseAddressId;
@property (nonatomic, copy)NSString *chonseAddressName;


@end

@implementation ProductPayViewController

- (instancetype)initWithModel:(ProductPayViewModel *)model {
    self = [super init];
    if (self) {
        self.viewModel = model;
        self.viewModel.productID = model.model.idkey;
    }
    return self;
}

- (void)loadUIData {
    self.buyMoneyLabel.text = [NSString stringWithFormat:@"￥ %ld",[self.viewModel.model.prefer_price integerValue]];
    self.nameLabel.text = self.viewModel.model.name;
    self.priceMoneyLabel.text = [NSString stringWithFormat:@"￥ %ld",[self.viewModel.model.prefer_price integerValue]];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.model.main_pic]];
    
    [self.nameTextField.rac_textSignal subscribeNext:^(NSString *x) {
        if (x.length == 0) {
            self.viewModel.name = @"";
        } else {
            self.viewModel.name = x;
        }
    }];
    
    [self.phoneTextField.rac_textSignal subscribeNext:^(NSString *x) {
        if (x.length == 0) {
            self.viewModel.phone = @"";
        } else {
            self.viewModel.phone = x;
        }
    }];
    
    [self.addressTextField.rac_textSignal  subscribeNext:^(NSString *x) {
        if (x.length == 0) {
            self.viewModel.address = @"";
        } else {
            self.viewModel.address = x;
        }
    }];
    
    [self.nodeTextView.rac_textSignal subscribeNext:^(NSString *x) {
        if (x.length == 0) {
            self.viewModel.note = @"";
        } else {
            self.viewModel.note = x;
        }
    }];
    
    self.nameTextField.text = [UserDefaultsTool getStringWithKey:@"productName"];
    self.viewModel.name = [UserDefaultsTool getStringWithKey:@"productName"];
    self.phoneTextField.text = [UserDefaultsTool getStringWithKey:@"productPhone"];
    self.viewModel.phone = [UserDefaultsTool getStringWithKey:@"productPhone"];
    self.addressTextField.text = [UserDefaultsTool getStringWithKey:@"productAddress"];
    self.viewModel.address = [UserDefaultsTool getStringWithKey:@"productAddress"];
    
    if ([[UserDefaultsTool getStringWithKey:@"chonseAddressName"] isEqualToString:@""]) {
        self.choseLabel.text = @"请选择省、市、区 ";
    } else {
        self.choseLabel.text = [UserDefaultsTool getStringWithKey:@"chonseAddressName"];
        self.viewModel.choseAddress = [UserDefaultsTool getStringWithKey:@"chonseAddressName"];
        self.chonseAddressId = [UserDefaultsTool getStringWithKey:@"chonseAddressId"];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle: @"支付页面" leftImage: @"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
    self.addButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.addButton.layer.borderWidth = 1;
    self.subButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.subButton.layer.borderWidth = 1;
    
    self.numLabel.layer.borderWidth = 1;
    self.numLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.numLabel.text = @"1";
    
    self.weichatView.layer.borderWidth = 1;
    self.weichatView.layer.borderColor = [UIColor grayColor].CGColor;
    self.zhifubaoView.layer.borderWidth = 1;
    self.zhifubaoView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.noteView.layer.borderWidth = 1;
    self.noteView.layer.borderColor = [UIColor grayColor].CGColor;
}

- (IBAction)subButtonClick:(id)sender {
    NSInteger num = [self.numLabel.text integerValue];
    num--;
    if (num <= 0) {
        num = 1;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld",num];
    self.buyMoneyLabel.text = [NSString stringWithFormat:@"￥ %ld",[self.viewModel.model.prefer_price integerValue] * num];
}

- (IBAction)addButtonClick:(id)sender {
    NSInteger num = [self.numLabel.text integerValue];
    num++;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",num];
    self.buyMoneyLabel.text = [NSString stringWithFormat:@"￥ %ld",[self.viewModel.model.prefer_price integerValue] * num];
}

- (IBAction)weiViewClick:(id)sender {
    self.weichatView.layer.borderColor = [UIColor redColor].CGColor;
    self.zhifubaoView.layer.borderColor = [UIColor grayColor].CGColor;
    self.viewModel.payState = 1;
}

- (IBAction)zhiViewClick:(id)sender {
    self.zhifubaoView.layer.borderColor = [UIColor redColor].CGColor;
    self.weichatView.layer.borderColor = [UIColor grayColor].CGColor;
    self.viewModel.payState = 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choseAddressViewClick:(id)sender {
    [self.addressPickerView show];
    [self.addressPickerView cacheRow:[UserDefaultsTool getStringWithKey:@"choseAddressID"]];
    @weakify(self);
    self.addressPickerView.determineBtnBlock = ^(NSString *shengId, NSString *shiId, NSString *xianId, NSString *shengName, NSString *shiName, NSString *xianName, NSString *postCode,NSString *cache) {
        DLog(@"%@",[NSString stringWithFormat:@"%@ %@ %@",shengName,shiName,xianName]);
        @strongify(self);
        self.choseLabel.text = [NSString stringWithFormat:@"%@ %@ %@",shengName,shiName,xianName];
        self.viewModel.choseAddress = [NSString stringWithFormat:@"%@ %@ %@",shengName,shiName,xianName];
        self.chonseAddressId = cache;
        self.chonseAddressName = [NSString stringWithFormat:@"%@ %@ %@",shengName,shiName,xianName];
    };
}

- (IBAction)sureButtonClick:(id)sender {
    if ([self.viewModel.name isEqualToString:@""]) {
        [BasePopoverView showFailHUDToWindow:@"请填写姓名"];
        return;
    }
    if ([self.viewModel.phone isEqualToString:@""]) {
        [BasePopoverView showFailHUDToWindow:@"请填写手机号"];
        return;
    }
    if ([self.viewModel.choseAddress isEqualToString:@""]) {
        [BasePopoverView showFailHUDToWindow:@"请填选择地址"];
        return;
    }
    if ([self.viewModel.address isEqualToString:@""]) {
        [BasePopoverView showFailHUDToWindow:@"请填写详细地址"];
        return;
    }
    
    if (!self.viewModel.payState) {
        [BasePopoverView showFailHUDToWindow:@"请选择支付方式"];
        return;
    }
    
    self.viewModel.num = [self.numLabel.text integerValue];
    
    [UserDefaultsTool setString:self.viewModel.name withKey:@"productName"];
    [UserDefaultsTool setString:self.viewModel.phone withKey:@"productPhone"];
    [UserDefaultsTool setString:self.viewModel.address withKey:@"productAddress"];
    [UserDefaultsTool setString:self.chonseAddressId withKey:@"choseAddressID"];
    [UserDefaultsTool setString:self.chonseAddressName withKey:@"chonseAddressName"];
    
    @weakify(self);
    self.viewModel.block_alipay = ^(NSString *sigin) {
        [AliPayObject CreateAliPayWithSigin:sigin appScheme:@"Fortune" andScallback:^(NSDictionary *resultDic) {
            DLog(@"result = %@",resultDic);
            NSString * returnStr;
            NSInteger code = resultDic[@"resultStatus"];
            if (code == 9000) {
                PayResultViewController *PVC = [[PayResultViewController alloc] init];
                @strongify(self);
                [self.navigationController pushViewController:PVC animated:YES];
            } else {
                switch (code) {
                    case 8000:
                        returnStr=@"订单正在处理中";
                        break;
                    case 4000:
                        returnStr=@"订单支付失败";
                        break;
                    case 6001:
                        returnStr=@"订单取消";
                        break;
                    case 6002:
                        returnStr=@"网络连接出错";
                        break;
                    default:
                        break;
                }
                [BasePopoverView showFailHUDToWindow:returnStr];
            }
        }];
    };
    
    self.viewModel.block_weixinpay = ^(NSDictionary *str) {
        [[weixingmanage sharedWixing] paystarForDic:str];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        PayResp* response;
        @strongify(self);
        [center addObserver:self selector:@selector(onToIphone:) name:@"paySuceessToOrder" object:response];
    };
    
//    [self.viewModel.subject_pay sendNext:@YES];
}

- (DXLAddressPickView *)addressPickerView {
    if (!_addressPickerView) {
        _addressPickerView = [[DXLAddressPickView alloc] init];
    }
    return _addressPickerView;
}

-(void)onToIphone:(NSNotification *)dic {
    PayResp *notify = dic.object;
    if ([notify isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)notify;
        BOOL ispush = NO;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                DLog(@"支付成功");
                ispush = YES;
                break;
            default:
                DLog(@"支付失败，retcode=%d",notify.errCode);
                ispush = NO;
                [BasePopoverView showFailHUDToWindow:@"支付失败"];
                break;
        }
        if (ispush) {
            PayResultViewController *PVC = [[PayResultViewController alloc] init];
            [self.navigationController pushViewController:PVC animated:YES];
        }
    }
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
