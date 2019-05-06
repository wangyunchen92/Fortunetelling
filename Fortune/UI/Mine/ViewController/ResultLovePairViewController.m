//
//  ResultLovePairViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/5/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ResultLovePairViewController.h"
#import "LoveBoardTableViewCell.h"
#import "LovePairTopTableViewCell.h"


@interface ResultLovePairViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;

@end

@implementation ResultLovePairViewController

- (instancetype)initWithViewModel:(ResultLovePairViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}
- (void)initData {
    self.viewModel = [[ResultLovePairViewModel alloc] init];
    

}

- (void)viewWillAppear:(BOOL)animated {
    if (self.viewModel.isgetDate) {
        [self.viewModel.subject_getDate sendNext:@YES];
    } else {
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"当前算命者信息" leftImage:@"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = RGB(209, 89, 82);
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LoveBoardTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LoveBoardTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LovePairTopTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LovePairTopTableViewCell class])];
    // Do any additional setup after loading the view from its nib.
    @weakify(self)
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        [self.tableView reloadData];
    };
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.viewTopConstraint.constant = iPhoneX ? 88 : 64;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.viewModel.topModel ? 2 : 0;
    } else if (section == 1) {
        return self.viewModel.topModel ? self.viewModel.topModel.infoArray.count : 0;
    } else if (section == 2) {
        return self.viewModel.topModel ? self.viewModel.topModel.manFateArray.count : 0;
    } else {
        return self.viewModel.topModel ? self.viewModel.topModel.womanFateArray.count : 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
        LovePairTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LovePairTopTableViewCell class]) forIndexPath:indexPath];
        [cell getDateForServer:self.viewModel.topModel isman:indexPath.row == 0 ? YES : NO ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }  else if (indexPath.section == 1) {
        LoveBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LoveBoardTableViewCell class]) forIndexPath:indexPath];
        [cell getdateForModel:self.viewModel.topModel.infoArray[indexPath.row] isshowSecendTitle:indexPath.row == 0 ? YES : NO andsecendTitle:@"八字合婚结果如下"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        LoveBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LoveBoardTableViewCell class]) forIndexPath:indexPath];
        [cell getdateForModel:self.viewModel.topModel.manFateArray[indexPath.row]isshowSecendTitle:indexPath.row == 0 ? YES : NO andsecendTitle:@"男命：六十甲子论命"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 3) {
        LoveBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LoveBoardTableViewCell class]) forIndexPath:indexPath];
        [cell getdateForModel:self.viewModel.topModel.womanFateArray[indexPath.row]isshowSecendTitle:indexPath.row == 0 ? YES : NO andsecendTitle:@"女命：六十甲子论命"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
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
