//
//  LovePairViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/5/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "LovePairViewController.h"
#import "WSDatePickerView.h"
#import "LovePairViewModel.h"
#import "ResultLovePairViewController.h"
@interface LovePairViewController ()
@property (weak, nonatomic) IBOutlet UILabel *maleDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *femaleDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *maleNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *femaleNameTextField;
@property (nonatomic, strong)LovePairViewModel *viewModel;
@end

@implementation LovePairViewController

- (void)initData {
    self.viewModel = [[LovePairViewModel alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"八字合婚" leftImage:@"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    self.viewModel.block_reloadDate = ^{
        ResultLovePairViewController *RVC = [[ResultLovePairViewController alloc] init];
        RVC.viewModel.topModel = self.viewModel.model;
        RVC.viewModel.isgetDate = NO;
        [self.navigationController pushViewController:RVC animated:YES];
    };
    // Do any additional setup after loading the view from its nib.
}

- (void)loadUIData {
    [[self.maleNameTextField.rac_textSignal filter:^BOOL(NSString * str) {
        return str.length > 0;
    }] subscribeNext:^(id x) {
        self.viewModel.maleName = x;
    }];
    [[self.femaleNameTextField.rac_textSignal filter:^BOOL(NSString * str) {
        return str.length > 0;
    }] subscribeNext:^(id x) {
        self.viewModel.femaleName = x;
    }];
}

- (IBAction)getboyDateAction:(id)sender {
    [self.view endEditing:YES];
    
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:self.viewModel.selMaleDate CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy年MM月dd日 HH时"];
        [self.viewModel getmaleDateForSele:selectDate];
        self.maleDateLabel.text = dateString;
        [self.maleDateLabel setFont: [UIFont systemFontOfSize:15]];
        self.maleDateLabel.textColor = kColorHWBlack;
    }];
    
    datepicker.dateLabelColor = defaultColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = defaultColor;//确定按钮的颜色
    [datepicker show];
}
- (IBAction)getgirlDateAction:(id)sender {
    [self.view endEditing:YES];
    
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:self.viewModel.selFemaleDate CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy年MM月dd日 HH时"];
        [self.viewModel getfemaleDateForSele:selectDate];
        self.femaleDateLabel.text = dateString;
        [self.femaleDateLabel setFont: [UIFont systemFontOfSize:15]];
        self.femaleDateLabel.textColor = kColorHWBlack;
    }];
    
    datepicker.dateLabelColor = defaultColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = defaultColor;//确定按钮的颜色
    [datepicker show];
    
}

- (IBAction)applyAction:(id)sender {
    [self.viewModel.subject_getDate sendNext:@YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if ([string containsString:@"-"] || [string containsString:@"+"]) {
        // 禁止粘贴"-"和"+"
        return NO;
    }
    
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
    
    if (mutableString.length > 5 ) {
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
