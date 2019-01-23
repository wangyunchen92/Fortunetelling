//
//  ProductListViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/6/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductListFirstView.h"
#import "ProductListViewModel.h"
#import "ProductListSecend.h"
#import "ProductDetailViewController.h"
#import "ProductDetailViewModel.h"


@interface ProductListViewController ()
@property (weak, nonatomic) IBOutlet UIView *firstTitleView;
@property (weak, nonatomic) IBOutlet UIView *firstListView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;

@property (weak, nonatomic) IBOutlet UIView *secendListView;

@property (nonatomic, strong)ProductListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstTitleViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstListViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secendListViewHeight;


@end

@implementation ProductListViewController

- (void)initData {
    self.viewModel = [[ProductListViewModel alloc] init];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle: @"商品列表" leftImage: @"" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    
    [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://luck.youmeng.com/Public/Xcx/img/banner.png"]];
    // Do any additional setup after loading the view from its nib.
    @weakify(self);
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
       __block CGFloat top;
        [self.viewModel.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            top = idx *181 + self.firstTitleViewHeight.constant;
            ProductListFirstView *view = [[ProductListFirstView alloc] initWithFrame:CGRectMake(0, top, self.firstListView.frame.size.width, self.firstListView.frame.size.height)];
            [self.firstListView addSubview:view];

            view.block_sureClick = ^(NSString *key) {
                ProductDetailViewModel *viewModel = [[ProductDetailViewModel alloc] init];
                viewModel.key = key;
                ProductDetailViewController *PVC = [[ProductDetailViewController alloc] initWithViewModel:viewModel];
                [self.navigationController pushViewController:PVC animated:YES];
            };
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(top);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(180);
            }];
            
            UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-30, 1)];
            [self.firstListView addSubview:lineview];
            [UIUtil addline:lineview];
            [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.equalTo(view.mas_bottom).offset(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(10);
            }];
            [view getdateForModel:obj];
        }];
        
        self.firstListViewHeight.constant = top + 180;
        
        __block CGFloat secendTop = 0;
        
        [self.viewModel.secendListArray enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 30, 100)];
            [self.secendListView addSubview:view];
            UILabel *label = [[UILabel alloc] init];
            label.text = self.viewModel.titleArray[idx];
            label.textColor = RGB(209, 89, 82);
            label.font = [UIFont systemFontOfSize:28];
            [view addSubview:label];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(secendTop);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(70);
            }];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(view.mas_centerX).offset(0);
                make.centerY.equalTo(view.mas_centerY).offset(0);
            }];
            secendTop = secendTop + 70;
            
            [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx % 2 == 0) {
                    ProductListSecend *firstview = [[ProductListSecend alloc] init];
                    [self.secendListView addSubview:firstview];
                    [firstview mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(secendTop);
                        make.left.equalTo(self.secendListView.mas_left).offset(0);
                        make.width.equalTo(self.view.mas_width).multipliedBy(0.5).offset(-15);
                        make.height.mas_equalTo(250);
                    }];
                    secendTop = secendTop + 260;
                    firstview.block_sureClick = ^(NSString *key) {
                        ProductDetailViewModel *viewModel = [[ProductDetailViewModel alloc] init];
                        viewModel.key = key;
                        ProductDetailViewController *PVC = [[ProductDetailViewController alloc] initWithViewModel:viewModel];
                        [self.navigationController pushViewController:PVC animated:YES];
                    };
                    [firstview getdateForModel:obj];
                } else {
                    ProductListSecend *secendView = [[ProductListSecend alloc] init];
                    [self.secendListView addSubview:secendView];
                    secendView.block_sureClick = ^(NSString *key) {
                        ProductDetailViewModel *viewModel = [[ProductDetailViewModel alloc] init];
                        viewModel.key = key;
                        ProductDetailViewController *PVC = [[ProductDetailViewController alloc] initWithViewModel:viewModel];
                        [self.navigationController pushViewController:PVC animated:YES];
                    };
                    [secendView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(secendTop - 260);
                        make.left.equalTo(self.secendListView.mas_centerX).offset(5);
                        make.width.equalTo(self.secendListView.mas_width).multipliedBy(0.5).offset(-15);
                        make.height.mas_equalTo(250);
                    }];
                    [secendView getdateForModel:obj];
                }
            }];
            
        }];
        
        self.secendListViewHeight.constant = secendTop;

    };
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self.viewModel.subject_getDate sendNext:@YES];
    
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
