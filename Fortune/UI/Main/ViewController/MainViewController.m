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
#import "YMWebViewController.h"
#import "LovePairViewController.h"

@interface MainViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong)NewPagedFlowView *pageView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)MainViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *topMaskView;
@property (weak, nonatomic) IBOutlet UILabel *yiLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateDayLabel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[MainViewModel alloc] init];
    [self createNavWithTitle:@"八字算命解梦" leftText:@"" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    self.viewModel.block_reloadDate = ^{
        [self.pageView reloadData];
        [UserDefaultsTool setString:self.viewModel.webfile withKey:@"webFile"];
    };
    self.yiLabel.text = [[ToolUtil stringForYi] componentsJoinedByString:@" "];
    self.jiLabel.text = [[ToolUtil stringForJi] componentsJoinedByString:@" "];
    if (iPhone5) {
        self.yiLabel.font = [UIFont systemFontOfSize:13];
        self.jiLabel.font = [UIFont systemFontOfSize:13];
    }
    [self.viewModel.subject_getDate sendNext:@YES];
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

    [self setDateForLabel];

}

- (void)setDateForLabel {
    NSDate *date = [NSDate date];
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy年MM月"];
        self.dateYearLabel.text = [dateFormatter stringFromDate:date];
    }
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"dd"];
        self.dateNumLabel.text = [dateFormatter stringFromDate:date];
    }
    {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitWeekday;
        comps = [calendar components:unitFlags fromDate:date];
        NSString *day;
        switch ([comps weekday]) {
            case 1:
                day = @"日";
                break;
            case 2:
                day = @"一";
                break;
            case 3:
                day = @"二";
                break;
            case 4:
                day = @"三";
                break;
            case 5:
                day = @"四";
                break;
            case 6:
                day = @"五";
                break;
            case 7:
                day = @"六";
            default:
                break;
        }
        self.dateDayLabel.text = [NSString stringWithFormat:@"星期%@",day];
    }
    
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(kScreenWidth , 115);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.viewModel.bannerArray.count ? self.viewModel.bannerArray.count : 1;
}

- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex {
    FortuneDetailViewController *FVC = [[FortuneDetailViewController alloc] init];
    FVC.isshowNavback = YES;
    switch (subIndex) {
        case 0:
            FVC.title = @"十年大运";
            break;
        case 1:
            FVC.title = @"流年运势";
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:FVC animated:YES];
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
    FVC.isshowNavback = YES;
    [self.navigationController pushViewController:FVC animated:YES];
}
- (IBAction)TopSecendClick:(id)sender {
    FortuneDetailViewController *FVC = [[FortuneDetailViewController alloc] init];
    FVC.isshowNavback = YES;
    FVC.title = @"流年运势";
    [self.navigationController pushViewController:FVC animated:YES];
}

- (IBAction)TopThreeClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"https://tools.2345.com/m/zhgjm.htm?from=calendar";
    WVC.isloadweb = 1;
    WVC.titleStr = @"周公解梦";
    [self.navigationController pushViewController:WVC animated:YES];
}
- (IBAction)TopFourClick:(id)sender {
    FortuneDetailViewController *FVC = [[FortuneDetailViewController alloc] init];
    FVC.isshowNavback = YES;
    FVC.title = @"十年大运";
    [self.navigationController pushViewController:FVC animated:YES];
}

- (IBAction)topFirstClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"https://tools.2345.com/m/shouxiang/?mrili&from=calendar";
    WVC.isloadweb = 1;
    WVC.titleStr = @"手相解密";
    [self.navigationController pushViewController:WVC animated:YES];
}
- (IBAction)boardSecendClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"https://tools.2345.com/m/suanming_zw.htm?mrili&from=calendar";
    WVC.isloadweb = 1;
    WVC.titleStr = @"指纹算命";
    [self.navigationController pushViewController:WVC animated:YES];
}
- (IBAction)boardThreeClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"https://tools.2345.com/m/zhanbu/guanyin/?from=calendar";
    WVC.isloadweb = 1;
    WVC.titleStr = @"抽签占卜";
    [self.navigationController pushViewController:WVC animated:YES];
}
- (IBAction)boardFourClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"https://tools.2345.com/m/peidui/xingming/?qq-pf-to=pcqq.c2c";
    WVC.isloadweb = 2;
    WVC.titleStr = @"恋爱配对";
    [self.navigationController pushViewController:WVC animated:YES];
}
- (IBAction)bottomFirstClick:(id)sender {
    LovePairViewController *LVC = [[LovePairViewController alloc] init];
//    WVC.urlStr = @"https://tools.2345.com/m/peidui/xingzuo/";
//     WVC.isloadweb = 2;
//    WVC.titleStr = @"婚姻测算";
    [self.navigationController pushViewController:LVC animated:YES];
    
}

- (IBAction)bottomSecendClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"https://tools.2345.com/m/shengxiao/";
     WVC.isloadweb = 2;
    WVC.titleStr = @"流年运势";
    [self.navigationController pushViewController:WVC animated:YES];
}

- (IBAction)bottomThreeClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"https://tools.2345.com/m/zhanbu/zhuge.htm";
     WVC.isloadweb = 2;
    WVC.titleStr = @"桃花运势";
    [self.navigationController pushViewController:WVC animated:YES];
}

- (IBAction)bottomFourClick:(id)sender {
    YMWebViewController *WVC = [[YMWebViewController alloc] init];
    WVC.urlStr = @"https://tools.2345.com/m/zhanbu/tianhou/";
     WVC.isloadweb = 2;
    WVC.titleStr = @"财运分析";
    [self.navigationController pushViewController:WVC animated:YES];
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
