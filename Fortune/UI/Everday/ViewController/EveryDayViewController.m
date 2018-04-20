//
//  EveryDayViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/4/16.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "EveryDayViewController.h"
#import "EveryDayViewModel.h"
#import "EveryDayDetailViewController.h"
#import "WSDatePickerView.h"

@interface EveryDayViewController ()
@property (nonatomic, strong)EveryDayViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *topConterntLabel;

@property (weak, nonatomic) IBOutlet UILabel *topFirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *topSecendLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *boardLabelArray;
@property (weak, nonatomic) IBOutlet UILabel *boardSecendLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *boardSecendLabelArray;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation EveryDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[EveryDayViewModel alloc] init];
    [self createNavWithTitle:[ToolUtil stringFromDate:self.viewModel.date format:@"yyyy年MM月dd日"]  leftImage:@"" rightImage:@"图层"];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    @weakify(self);
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        self.topTitleLabel.text = self.viewModel.model.topDate;
        self.topConterntLabel.text = self.viewModel.model.topContent;
        self.topFirstLabel.text = self.viewModel.model.boardYi;
        self.topSecendLabel.text = self.viewModel.model.boardJi;
        [self.boardLabelArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YiJiModel *model = self.viewModel.model.boardtopArray[idx];
            obj.text = model.showTitle;
        }];
        self.boardSecendLabel.text = self.viewModel.model.baizujinji;
        [self.boardSecendLabelArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.text = self.viewModel.model.boardbottomArray[idx];
        }];
        self.bottomLabel.text = self.viewModel.model.bottom;
    };
    self.topTitleLabel.userInteractionEnabled = YES;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)pushDetailView:(id)sender {
    EveryDayDetailViewController *EVC = [[EveryDayDetailViewController alloc] init];
    EVC.dateArray = self.viewModel.model.boardtopArray;
    [self.navigationController pushViewController:EVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.viewModel.subject_getDate sendNext:@YES];
    
}
- (IBAction)leftClick:(id)sender {
    self.viewModel.date = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:self.viewModel.date];
    [self.viewModel.subject_getDate sendNext:@YES];
}

- (IBAction)rightClick:(id)sender {
        self.viewModel.date = [NSDate dateWithTimeInterval:24*60*60 sinceDate:self.viewModel.date];
    [self.viewModel.subject_getDate sendNext:@YES];
}
- (IBAction)changeDateClick:(id)sender {

    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:self.viewModel.date CompleteBlock:^(NSDate *selectDate) {
        self.viewModel.date = selectDate;
        [self.viewModel.subject_getDate sendNext:@YES];
    }];
    datepicker.dateLabelColor = defaultColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = defaultColor;//确定按钮的颜色
    [datepicker show];
}

- (void)navBarButtonAction:(UIButton *)sender {
    switch (sender.tag) {
        case NBButtonLeft:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case NBButtonRight:
        {
             self.viewModel.date = [NSDate date];
            [self.viewModel.subject_getDate sendNext:@YES];
        }
            break;
        default:
            break;
    }
            
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
