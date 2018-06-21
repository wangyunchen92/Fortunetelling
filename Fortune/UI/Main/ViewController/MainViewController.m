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
#import "NameCalculateViewController.h"
#import "LuckMoneyViewController.h"
#import "MainCellModel.h"
#import "MainBigBannerCell.h"
#import "MainSmallBannerCell.h"

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
@property (strong, nonatomic) IBOutletCollection(MainBigBannerCell) NSArray *bigBannerView;
@property (strong, nonatomic) IBOutletCollection(MainSmallBannerCell) NSArray *smallBannerView;
@property (strong, nonatomic) IBOutletCollection(MainSmallBannerCell) NSArray *smallBannerView1;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[MainViewModel alloc] init];
    [self createNavWithTitle:@"八字算命解梦" leftText:@"" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    @weakify(self);
    self.viewModel.block_getServerData = ^{
        @strongify(self);
        [self.bigBannerView enumerateObjectsUsingBlock:^(MainBigBannerCell *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj getDateForModel:self.viewModel.bigBannerArray[idx]];
        }];
        
        [self.smallBannerView enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj getDateForModel:self.viewModel.smallBannerArray[idx]];
        }];
        
        [self.smallBannerView1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj getDateForModel:self.viewModel.smallBannerArray[idx+4]];
        }];
        
        [self.pageView reloadData];
    };
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        [UserDefaultsTool setString:self.viewModel.webfile withKey:@"webFile"];
    };
    
    self.yiLabel.text = [[ToolUtil stringForYi] componentsJoinedByString:@" "];
    self.jiLabel.text = [[ToolUtil stringForJi] componentsJoinedByString:@" "];
    if (iPhone5) {
        self.yiLabel.font = [UIFont systemFontOfSize:13];
        self.jiLabel.font = [UIFont systemFontOfSize:13];
    }
    [self.viewModel.subject_getDate sendNext:@YES];
    [self.viewModel.subject_getServerData sendNext:@YES];
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
    return self.viewModel.bannerArray.count;
}

- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex {
    FortuneDetailViewController *FVC = [[FortuneDetailViewController alloc] init];
    FVC.isshowNavback = YES;
    switch (subIndex) {
        case 0:
            [ReportStatisticsTool reportStatisticSerialNumber:main_home_banner jsonDataString:@"十年大运"];
            FVC.title = @"十年大运";
            break;
        case 1:
            [ReportStatisticsTool reportStatisticSerialNumber:main_home_banner jsonDataString:@"流年运势"];
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
    if (self.viewModel.bannerArray.count > 0) {
        [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[self.viewModel.bannerArray objectAtIndex:index].mainPic]];
    } else {
        [bannerView.mainImageView setImage:IMAGE_NAME(@"Banner1")];
    }
//    [bannerView.mainImageView setImage:IMAGE_NAME([self.viewModel.bannerArray objectAtIndex:index].mainPic)];
    return bannerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offY = scrollView.contentOffset.y;
    
    if (offY < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

- (IBAction)firstFortuneClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"八字测算"];
//    FortuneDetailViewController *FVC = [[FortuneDetailViewController alloc] init];
//    FVC.isshowNavback = YES;
//    [self.navigationController pushViewController:FVC animated:YES];
    [self pushNextView:self.viewModel.bigBannerArray[0]];
}
- (IBAction)TopSecendClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"流年运势"];
//    FortuneDetailViewController *FVC = [[FortuneDetailViewController alloc] init];
//    FVC.isshowNavback = YES;
//    FVC.title = @"流年运势";
//    [self.navigationController pushViewController:FVC animated:YES];
    [self pushNextView:self.viewModel.bigBannerArray[1]];
}

- (IBAction)TopThreeClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"周公解梦"];
//    YMWebViewController *WVC = [[YMWebViewController alloc] init];
//    WVC.urlStr = @"https://tools.2345.com/m/zhgjm.htm?from=calendar";
//    WVC.titleStr = @"周公解梦";
//    [self.navigationController pushViewController:WVC animated:YES];
    [self pushNextView:self.viewModel.bigBannerArray[2]];
}
- (IBAction)TopFourClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"十年大运"];
//    FortuneDetailViewController *FVC = [[FortuneDetailViewController alloc] init];
//    FVC.isshowNavback = YES;
//    FVC.title = @"十年大运";
//    [self.navigationController pushViewController:FVC animated:YES];
    [self pushNextView:self.viewModel.bigBannerArray[3]];
}

- (IBAction)topFirstClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"手相解密"];
//    YMWebViewController *WVC = [[YMWebViewController alloc] init];
//    WVC.urlStr = @"https://tools.2345.com/m/shouxiang/?mrili&from=calendar";
//    WVC.titleStr = @"手相解密";
//    [self.navigationController pushViewController:WVC animated:YES];
    [self pushNextView:self.viewModel.smallBannerArray[0]];
}
- (IBAction)boardSecendClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"指纹算命"];
//    YMWebViewController *WVC = [[YMWebViewController alloc] init];
//    WVC.urlStr = @"https://tools.2345.com/m/suanming_zw.htm?mrili&from=calendar";
//    WVC.titleStr = @"指纹算命";
//    [self.navigationController pushViewController:WVC animated:YES];
    [self pushNextView:self.viewModel.smallBannerArray[1]];
}
- (IBAction)boardThreeClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"抽签占卜"];
//    YMWebViewController *WVC = [[YMWebViewController alloc] init];
//    WVC.urlStr = @"https://tools.2345.com/m/zhanbu/guanyin/?from=calendar";
//    WVC.titleStr = @"抽签占卜";
//    [self.navigationController pushViewController:WVC animated:YES];
    [self pushNextView:self.viewModel.smallBannerArray[2]];
}
- (IBAction)boardFourClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"恋爱配对"];
//    YMWebViewController *WVC = [[YMWebViewController alloc] init];
//    WVC.urlStr = @"https://tools.2345.com/m/peidui/xingming/?qq-pf-to=pcqq.c2c";
//    WVC.titleStr = @"恋爱配对";
//    [self.navigationController pushViewController:WVC animated:YES];
    [self pushNextView:self.viewModel.smallBannerArray[3]];
}
- (IBAction)bottomFirstClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"婚姻测算"];
//    LuckMoneyViewController *LVC = [[LuckMoneyViewController alloc] init];
//    [self.navigationController pushViewController:LVC animated:YES];
    [self pushNextView:self.viewModel.smallBannerArray[4]];
}

- (IBAction)bottomSecendClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"流年运势"];
//    YMWebViewController *WVC = [[YMWebViewController alloc] init];
//    WVC.urlStr = @"https://tools.2345.com/m/shengxiao/";
//    WVC.titleStr = @"流年运势";
//    [self.navigationController pushViewController:WVC animated:YES];
    [self pushNextView:self.viewModel.smallBannerArray[5]];
}

- (IBAction)bottomThreeClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"桃花运势"];
//    YMWebViewController *WVC = [[YMWebViewController alloc] init];
//    WVC.urlStr = @"https://tools.2345.com/m/zhanbu/zhuge.htm";
//    WVC.titleStr = @"桃花运势";
//    [self.navigationController pushViewController:WVC animated:YES];
    [self pushNextView:self.viewModel.smallBannerArray[6]];
}

- (IBAction)bottomFourClick:(id)sender {
    [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"财运分析"];
//    YMWebViewController *WVC = [[YMWebViewController alloc] init];
//    WVC.urlStr = @"https://tools.2345.com/m/zhanbu/tianhou/";
//    WVC.titleStr = @"财运分析";
//    [self.navigationController pushViewController:WVC animated:YES];
    [self pushNextView:self.viewModel.smallBannerArray[7]];
}

- (void)pushNextView:(MainCellModel *)model{
    if (model.type == 1) {
        // 跳转 H5 纯展示
        YMWebViewController *WVC = [[YMWebViewController alloc] init];
        WVC.titleStr = model.title;
        WVC.urlStr = model.redirect_url;
        [self.navigationController pushViewController:WVC animated:YES];
    } else if (model.type == 2) {
        // 跳转原生页面 (也有原生的H5)
        if ([model.redirect_url isEqualToString:@"bazi_raw"]) {
            FortuneDetailViewController *FVC = [[FortuneDetailViewController alloc] init];
            FVC.isshowNavback = YES;
            [self.navigationController pushViewController:FVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"sanshi_raw"]) {
            LuckMoneyViewController *LVC = [[LuckMoneyViewController alloc] init];
            [self.navigationController pushViewController:LVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"xingming_raw"]) {
            NameCalculateViewController *NVC = [[NameCalculateViewController alloc] init];
            [self.navigationController pushViewController:NVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"hehun_raw"]) {
            LovePairViewController *LVC = [[LovePairViewController alloc] init];
            [self.navigationController pushViewController:LVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"shouxiang_h5"]) {
            YMWebViewController *WVC = [[YMWebViewController alloc] init];
            WVC.urlStr = @"http://tools.2345.com/m/shouxiang/?mrili&from=calendar";
            WVC.titleStr = model.title;
            [self.navigationController pushViewController:WVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"zhiwen_h5"]) {
            YMWebViewController *WVC = [[YMWebViewController alloc] init];
            WVC.urlStr = @"http://tools.2345.com/m/suanming_zw.htm?mrili&from=calendar";
            WVC.titleStr = model.title;
            [self.navigationController pushViewController:WVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"guanyin_h5"]) {
            YMWebViewController *WVC = [[YMWebViewController alloc] init];
            WVC.urlStr = @"http://tools.2345.com/m/zhanbu/guanyin/?from=calendar";
            WVC.titleStr = model.title;
            [self.navigationController pushViewController:WVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"xingming_h5"]) {
            YMWebViewController *WVC = [[YMWebViewController alloc] init];
            WVC.urlStr = @"http://tools.2345.com/m/peidui/xingming/?qq-pf-to=pcqq.c2c";
            WVC.titleStr = model.title;
            [self.navigationController pushViewController:WVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"xingzuo_h5"]) {
            YMWebViewController *WVC = [[YMWebViewController alloc] init];
            WVC.urlStr = @"http://tools.2345.com/m/peidui/xingzuo/";
            WVC.titleStr = model.title;
            [self.navigationController pushViewController:WVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"shengxiao_h5"]) {
            YMWebViewController *WVC = [[YMWebViewController alloc] init];
            WVC.urlStr = @"http://tools.2345.com/m/shengxiao/";
            WVC.titleStr = model.title;
            [self.navigationController pushViewController:WVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"zhuge_h5"]) {
            YMWebViewController *WVC = [[YMWebViewController alloc] init];
            WVC.urlStr = @"http://tools.2345.com/m/zhanbu/zhuge.htm";
            WVC.titleStr = model.title;
            [self.navigationController pushViewController:WVC animated:YES];
        } else if ([model.redirect_url isEqualToString:@"tianhou_h5"]) {
            YMWebViewController *WVC = [[YMWebViewController alloc] init];
            WVC.urlStr = @"http://tools.2345.com/m/zhanbu/tianhou/";
            WVC.titleStr = model.title;
            [self.navigationController pushViewController:WVC animated:YES];
        }
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
