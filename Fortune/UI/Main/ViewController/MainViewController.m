//
//  MainViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/4/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MainViewController.h"
#import "NewPagedFlowView.h"
#import "MainViewModel.h"
#import "FortuneDetailViewController.h"

@interface MainViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong)NewPagedFlowView *pageView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)MainViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *topMaskView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[MainViewModel alloc] init];
    [self createNavWithTitle:@"八字算命解梦" leftText:@"" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = RGB(225, 75, 76);
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    self.viewModel.block_reloadDate = ^{
        [self.pageView reloadData];
    };
    // Do any additional setup after loading the view from its nib.
}

- (void)loadUIData {
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,115)];
    pageFlowView.backgroundColor = RGB(233, 233, 233);
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0;
    pageFlowView.isCarousel = YES;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = YES;
    self.pageView = pageFlowView;
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 32, kScreenWidth, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    self.pageControl = pageControl;
    [self.topMaskView addSubview:pageFlowView];


}

- (void)viewWillAppear:(BOOL)animated {
    [self.viewModel.subject_getDate sendNext:@YES];
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(kScreenWidth , 115);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.viewModel.bannerArray.count ? self.viewModel.bannerArray.count : 1;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        //        bannerView.layer.cornerRadius = 4;
        //        bannerView.layer.masksToBounds = YES;
    }
    [bannerView.mainImageView setImage:IMAGE_NAME([self.viewModel.bannerArray objectAtIndex:index])];
    

    return bannerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offY = scrollView.contentOffset.y;
    
    if (offY < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

- (IBAction)firstFortuneClick:(id)sender {
    FortuneDetailViewController *FVC = [[FortuneDetailViewController alloc] init];
    [self.navigationController pushViewController:FVC animated:YES];
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
