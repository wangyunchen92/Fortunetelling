//
//  PersonDetailViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/4/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "PersonDetailViewModel.h"
#import "PersonDetailTopTableViewCell.h"
#import "PersonDetailBoardTableViewCell.h"
#import "PersonBottomTableViewCell.h"

@interface PersonDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)PersonDetailViewModel *viewModel;

@end

@implementation PersonDetailViewController
- (instancetype)initWithViewModel:(PersonDetailViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"当前算命者信息" leftText:@"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = RGB(209, 89, 82);
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PersonDetailTopTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PersonDetailTopTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PersonDetailBoardTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PersonDetailBoardTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PersonBottomTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PersonBottomTableViewCell class])];
    @weakify(self);
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        [self.tableView reloadData];
    };
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.viewModel.isgetDate) {
        [self.viewModel.subject_getDate sendNext:@YES];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.boardArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        PersonDetailTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonDetailTopTableViewCell class]) forIndexPath:indexPath];
        [cell getdateForModel:self.viewModel.topModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    } else  {
        NSDictionary *dic = self.viewModel.boardArray[indexPath.row-1];
        if (![[dic stringForKey:@"type"]isEqualToString:@"2"]) {
            PersonDetailBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonDetailBoardTableViewCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell getdateForDic:self.viewModel.boardArray[indexPath.row-1]];
            return cell;
        } else {
            PersonBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonBottomTableViewCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell getdateForDic:self.viewModel.boardArray[indexPath.row-1]];
            return cell;
        }
    }
    return nil;
}

- (void)navBarButtonAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
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
