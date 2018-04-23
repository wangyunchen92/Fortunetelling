//
//  MineCalculateListViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/4/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MineCalculateListViewController.h"
#import "MineCalculateViewModel.h"
#import "MineCalculateTableViewCell.h"
#import "PersonDetailViewController.h"
#import "FortuneDetailViewController.h"

@interface MineCalculateListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)MineCalculateViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *noNumberView;

@end

@implementation MineCalculateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"我的测算" leftText:@"" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MineCalculateTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MineCalculateTableViewCell class])];
    self.viewModel = [[MineCalculateViewModel alloc] init];
    @weakify(self);
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        if ((self.viewModel.dataArray.count > 0)) {
            self.tableView.hidden  = YES;
            self.noNumberView.hidden = NO;
        } else {
            self.tableView.hidden  = NO;
            self.noNumberView.hidden = YES;
          [self.tableView reloadData];
        }
        
    };
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel.subject_getDate sendNext:@YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineCalculateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineCalculateTableViewCell class]) forIndexPath:indexPath];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [cell getDataForModel:self.viewModel.dataArray[indexPath.row]];
//    cell.block_detailButtonClick = ^(NSString *programId) {
//        PersonDetailViewModel *VCviewModel = [[PersonDetailViewModel alloc] init];
//        VCviewModel.programId = programId;
//        PersonDetailViewController *VC = [[PersonDetailViewController alloc] initWithViewModel:VCviewModel];
//        [self.navigationController pushViewController:VC animated:YES];
//    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushNexView:(id)sender {
    FortuneDetailViewController *FVC = [[FortuneDetailViewController alloc] init];
    FVC.isshowNavback = YES;
    [self.navigationController pushViewController:FVC animated:YES];
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
