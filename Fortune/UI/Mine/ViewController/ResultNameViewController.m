//
//  ResultNameViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ResultNameViewController.h"
#import "NameTopTableViewCell.h"
#import "NameSecendTopViewCell.h"
#import "NameBoardCell.h"

@interface ResultNameViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;

@end

@implementation ResultNameViewController

- (instancetype)initWithViewModel:(ResultNameViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}
- (void)initData {
    self.viewModel = [[ResultNameViewModel alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNavWithTitle:@"当前算命者信息" leftImage:@"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = RGB(209, 89, 82);
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NameTopTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NameTopTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NameSecendTopViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NameSecendTopViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NameBoardCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NameBoardCell class])];
    @weakify(self);
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        [self.tableView reloadData];
    };
    self.viewTopConstraint.constant = iPhoneX ? 88 : 64;
}

-(void)viewWillAppear:(BOOL)animated {
    if (self.viewModel.isgetDate) {
        [self.viewModel.subject_getDate sendNext:@YES];
    } else {
        [self.tableView reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 + self.viewModel.model.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        NameTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NameTopTableViewCell class]) forIndexPath:indexPath];
        [cell getDateForModel:self.viewModel.model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 1) {
        NameSecendTopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NameSecendTopViewCell class]) forIndexPath:indexPath];
        [cell getDateForModel:self.viewModel.model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        NameBoardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NameBoardCell class]) forIndexPath:indexPath];
        [cell getDateForModel:self.viewModel.model.infoArray[indexPath.row - 2]];
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
