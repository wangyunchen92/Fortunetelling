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


@interface FortuneDetailViewController ()
@property (nonatomic, strong)FortuneDetailViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong)WSDatePickerView *picView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@end

@implementation FortuneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"八字算命" leftText:@"" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = RGB(225, 75, 76);
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
    
}

- (IBAction)showPicView:(id)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        
        NSString *dateString = [selectDate stringWithFormat:@"yyyy年MM月dd日 HH时mm分"];
        [self.viewModel getNowday:selectDate];
        self.dateLabel.text = dateString;
    }];
    datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
    
}

- (IBAction)radioButtonClick:(RadioButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
}


- (IBAction)sureButtonClick:(id)sender {
    [self.viewModel.subject_getDate sendNext:@YES];
}
- (void)viewDidAppear:(BOOL)animated {

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
