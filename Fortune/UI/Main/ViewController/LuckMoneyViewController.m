//
//  LuckMoneyViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "LuckMoneyViewController.h"
#import "LuckMoneyViewModel.h"
#import "WSDatePickerView.h"
#import "ResultLuckMoneyViewController.h"

@interface LuckMoneyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong)LuckMoneyViewModel *viewModel;

@end

@implementation LuckMoneyViewController

- (void)initData {
    self.viewModel = [[LuckMoneyViewModel alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"三生运势" leftImage: @"Whiteback"  rightText:@""];
    
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    
    [[self.nameTextField.rac_textSignal filter:^BOOL(NSString * str) {
        return str.length > 0;
    }] subscribeNext:^(id x) {
        self.viewModel.name = x;
    }];
    
    self.viewModel.block_reloadDate = ^{
         ResultLuckMoneyViewController *RVC = [[ResultLuckMoneyViewController alloc] init];
        RVC.viewModel.model = self.viewModel.model;
        RVC.viewModel.isgetDate = NO;
        [self.navigationController pushViewController:RVC animated:YES];
    };
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)choseDateAction:(id)sender {
    [self.view endEditing:YES];
    
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:self.viewModel.selDate CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy年MM月dd日 HH时"];
        [self.viewModel getselDate:selectDate];
        self.dateLabel.text = dateString;
    }];
    
    datepicker.dateLabelColor = defaultColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = defaultColor;//确定按钮的颜色
    [datepicker show];
}

- (IBAction)applyAction:(id)sender {
        [self.viewModel.subject_getDate sendNext:@YES];
}

- (IBAction)radioButtonClick:(RadioButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
    self.viewModel.sex = sender.titleLabel.text;
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
