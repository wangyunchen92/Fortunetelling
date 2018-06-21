//
//  ResultLuckMoneyViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ResultLuckMoneyViewController.h"
#import "ResultLuckMoneyViewModel.h"
#import "LuckMoneyTopCell.h"
#import "LuckMoneyBoardCell.h"


@interface ResultLuckMoneyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ResultLuckMoneyViewController
- (instancetype)initWithViewModel:(ResultLuckMoneyViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)initData {
    self.viewModel = [[ResultLuckMoneyViewModel alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createNavWithTitle:@"当前算命者信息" leftImage:@"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = RGB(209, 89, 82);
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LuckMoneyTopCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LuckMoneyTopCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LuckMoneyBoardCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LuckMoneyBoardCell class])];
    @weakify(self);
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        [self.tableView reloadData];
    };
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

-(void)viewWillAppear:(BOOL)animated {
    if (self.viewModel.isgetDate) {
        [self.viewModel.subject_getDate sendNext:@YES];
    } else {
        [self.tableView reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.viewModel.model.array.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        LuckMoneyTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LuckMoneyTopCell class]) forIndexPath:indexPath];
        [cell getDateForModel:self.viewModel.model.title];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        LuckMoneyBoardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LuckMoneyBoardCell class]) forIndexPath:indexPath];
        [cell getDateForModel:self.viewModel.model.array[indexPath.row - 1]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
