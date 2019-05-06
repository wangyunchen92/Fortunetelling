//
//  FortuneDetailViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/4/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "FortuneDetailViewController.h"
#import "FortuneDetailViewModel.h"
#import "WSDatePickerView.h"
#import "PersonDetailViewController.h"
#import "YMWebViewController.h"
#import "UIScrollView+UITouch.h"

#import "PayDetailViewController.h"

#import "PayWebViewController.h"

@interface FortuneDetailViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)FortuneDetailViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong)WSDatePickerView *picView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;

@end

@implementation FortuneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.title isEqualToString:@"流年运势"]) {
        self.bannerImage.image = IMAGE_NAME(@"测算页banner");
    } else if ([self.title isEqualToString:@"十年大运"]) {
        self.bannerImage.image = IMAGE_NAME(@"Banner1");
    } else {
        self.bannerImage.image = IMAGE_NAME(@"Banner2");
    }
    [self createNavWithTitle:self.title? self.title : @"八字算命" leftImage:self.isshowNavback? @"Whiteback" :nil  rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    self.viewModel = [[FortuneDetailViewModel alloc] init];
    @weakify(self);
    self.viewModel.block_personDetail = ^(PersonDetailViewModel *pVCViewModel) {
        @strongify(self);
        pVCViewModel.isgetDate = NO;
        PersonDetailViewController *pVC = [[PersonDetailViewController alloc] initWithViewModel:pVCViewModel];
        [self.navigationController pushViewController:pVC animated:YES];
    };
    
    self.viewModel.block_isNoTest = ^(NSString *programId ,PersonDetailViewModel *pVCViewModel ) {
        @strongify(self);
        PayViewModel *viewModel = [[PayViewModel alloc] init];
        viewModel.programId = programId;
        PayDetailViewController *PayVC = [[PayDetailViewController alloc] initWithViewModel:viewModel];
        PayVC.block_payResult = ^(BOOL ispaysuccess) {
            if (ispaysuccess) {
                pVCViewModel.isgetDate = NO;
                PersonDetailViewController *pVC = [[PersonDetailViewController alloc] initWithViewModel:pVCViewModel];
                [self.navigationController pushViewController:pVC animated:YES];
            } else {
                [BasePopoverView showFailHUDToWindow:@"支付失败..."];
            }

        };
        [self.navigationController pushViewController:PayVC animated:YES];
    };
    self.viewModel.block_isWebTest = ^(NSString *programId, NSString *key, NSString *uUid, PersonDetailViewModel *model) {
        [ReportStatisticsTool reportStatisticSerialNumber:pay_View jsonDataString:@"进入web支付"];
        @strongify(self);
        NSString *requestUrl = [NSString stringWithFormat:@"https://shenxingnet.com/Wap/Pay/pay.html?source=ios&key=%@&uUid=%@",key,uUid];
        PayWebViewController *webview = [[PayWebViewController alloc] init];
        webview.payurl = requestUrl;
        webview.block_payResult = ^(BOOL ispaysuccess) {
            if (ispaysuccess) {
                [ReportStatisticsTool reportStatisticSerialNumber:bazi_cesuan jsonDataString:@"支付成功_进入结果页面"];
                model.isgetDate = NO;
                PersonDetailViewController *pVC = [[PersonDetailViewController alloc] initWithViewModel:model];
                [self.navigationController pushViewController:pVC animated:YES];
            } else {
                [ReportStatisticsTool reportStatisticSerialNumber:bazi_cesuan jsonDataString:@"支付失败..."];
                [BasePopoverView showFailHUDToWindow:@"支付失败..."];
            }
        };
        [self.navigationController pushViewController:webview animated:YES];
    };

    // Do any additional setup after loading the view.
}

- (void)loadUIData {
    [[self.firstNameTextField.rac_textSignal filter:^BOOL(NSString * str) {
        return str.length > 0;
    }] subscribeNext:^(id x) {
        self.viewModel.firstName = x;
    }];
    
    [[self.lastNameTextField.rac_textSignal filter:^BOOL(NSString * str) {
        return str.length > 0;
    }] subscribeNext:^(id x) {
        self.viewModel.lastName = x;
    }];
    self.viewTopConstraint.constant = iPhoneX ? 88 : 64;
    
}

- (IBAction)showPicView:(id)sender {
   [self.view endEditing:YES];
    
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:self.viewModel.seledate CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy年MM月dd日 HH时"];
        [self.viewModel getNowday:selectDate];
        self.dateLabel.text = dateString;
    }];
    
    datepicker.dateLabelColor = defaultColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = defaultColor;//确定按钮的颜色
    [datepicker show];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)radioButtonClick:(RadioButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
    self.viewModel.sex = sender.titleLabel.text;
}


- (IBAction)sureButtonClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:bazi_cesuan jsonDataString:@"八字测算按钮点击"];
    [self.viewModel.subject_getDate sendNext:@YES];
}

- (IBAction)firstClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"http://tools.2345.com/m/shouxiang/?mrili&from=calendar";
    WVC.titleStr = @"手相解密";
    [self.navigationController pushViewController:WVC animated:YES];
}
- (IBAction)secendClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"http://tools.2345.com/m/suanming_zw.htm?mrili&from=calendar";
    WVC.titleStr = @"指纹算命";
    [self.navigationController pushViewController:WVC animated:YES];
    
}
- (IBAction)threeClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"http://tools.2345.com/m/zhanbu/guanyin/?from=calendar";
    WVC.titleStr = @"抽签占卜";
    [self.navigationController pushViewController:WVC animated:YES];
}

- (IBAction)fourClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"https://tools.2345.com/m/zhgjm.htm?from=calendar";
    WVC.titleStr = @"周公解梦";
    [self.navigationController pushViewController:WVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offY = scrollView.contentOffset.y;
    
    if (offY < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

//    
//    if ([string containsString:@"-"] || [string containsString:@"+"]) {
//        // 禁止粘贴"-"和"+"
//        return NO;
//    }
//    
    NSMutableString *mutableString = [NSMutableString stringWithString:textField.text];
    if ([string isEqualToString:@""]) {
        //删除
        [mutableString deleteCharactersInRange:range];
    }else{
        [mutableString replaceCharactersInRange:range withString:string];
    }
    if ([self filterCharactor:string withRegex:@"[^\u4E00-\u9FA5]"]) {
        return NO;
    }
    
    if (mutableString.length > 3 ) {
        return NO;
    } else {
            return YES;
    }
}

//根据正则，过滤特殊字符
- (BOOL)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
       return [predicate evaluateWithObject:string];
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
