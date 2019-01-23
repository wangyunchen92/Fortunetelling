//
//  ProductDetailViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/6/27.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDetailPicker.h"
#import "ProductDetailComment.h"
#import "ProductDetailRecord.h"
#import "ProductListSecend.h"
#import "ProductPayViewController.h"



@interface ProductDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *inforLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *informationViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *subhead;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *evaluateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *shuView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *shuButtonArray;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *detailButtonArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailLineViewLeft;
@property (weak, nonatomic) IBOutlet UIView *productDetailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productDetailViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productDetailViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productBottomViewHeight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *line1View;
@property (weak, nonatomic) IBOutlet UIView *line2View;

@property (nonatomic, strong)ProductDetailViewModel *viewModel;

@property (nonatomic, assign)NSInteger choseTag;
@property (nonatomic, assign)CGFloat PicHeight;
@property (nonatomic, assign)CGFloat ComHeight;
@property (nonatomic, assign)CGFloat THeight;

@end

@implementation ProductDetailViewController

- (instancetype)initWithViewModel:(ProductDetailViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.choseTag = 1;
    [self createNavWithTitle: @"商品详情" leftImage: @"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    
    [self.shuButtonArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [RACObserve(obj, selected) subscribeNext:^(NSNumber *x) {
            if ([x boolValue]) {
                obj.backgroundColor = RGB(167, 107, 84);
                [obj setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            } else {
                obj.backgroundColor = [UIColor whiteColor];
                [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }];
        
        if (idx == 0) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
        obj.layer.borderWidth = 1;
        obj.layer.borderColor = RGB(167, 107, 84).CGColor;
    }];
    
    
    [self.detailButtonArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [RACObserve(obj, selected) subscribeNext:^(NSNumber *x) {
            if ([x boolValue]) {
                [obj setTitleColor:RGB(167, 107, 84) forState:UIControlStateSelected];
            } else {
                [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }];
        
        if (idx == 0) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
        
    }];
    // Do any additional setup after loading the view from its nib.
    
    @weakify(self);
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.model.detailPic]];
        self.titleLabel.text = self.viewModel.model.name;
        self.subhead.text = self.viewModel.model.subhead;
        self.evaluateLabel.text = [NSString stringWithFormat:@"%@%@",self.viewModel.model.evaluate,@"%"];

        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",self.viewModel.model.original_price] attributes:attribtDic];
        self.moneyLabel.attributedText = attribtStr;
        
        self.payMoneyLabel.text = [NSString stringWithFormat:@"%@元",self.viewModel.model.prefer_price];
        
        self.inforLabel.text = self.viewModel.model.intro;
        self.informationViewHeight.constant = self.viewModel.model.isShu ? 0 : 180;
        self.shuView.hidden = self.viewModel.model.isShu;
        [self addSubControllers];
    };
    [UIUtil addline:self.line1View];
    [UIUtil addline:self.line2View];
    [self.viewModel.subject_getDate sendNext:@YES];
}


- (void)addSubControllers{
    {
        ProductDetailPicker *FV = [[ProductDetailPicker alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        FV.block_changeHeight = ^(CGFloat folat) {
            self.PicHeight = folat;
            if (self.choseTag == 1) {
                self.productDetailViewHeight.constant = self.PicHeight;
            }
        };
        FV.backgroundColor = [UIColor redColor];
        [FV creatViewWithServer:self.viewModel.model.detailPicArray];
        [self.productDetailView addSubview:FV];
    }
    {
        ProductDetailComment *view = [[ProductDetailComment alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, 100)];
        [self.productDetailView addSubview:view];
        [view creatViewWithServer:self.viewModel.model.commentInfoArray];
        self.ComHeight = self.viewModel.model.commentInfoArray.count * 100;
        if (self.choseTag == 2) {
            self.productDetailViewHeight.constant = self.ComHeight;
        }
    }
    {
        ProductDetailRecord *view = [[ProductDetailRecord alloc] initWithFrame:CGRectMake(kScreenWidth * 2, 0, kScreenWidth, 100)];
        [self.productDetailView addSubview:view];
        [view creatViewWithServer:self.viewModel.model.recordInfoArray];
        self.THeight = self.viewModel.model.recordInfoArray.count * 44 + 44;
        if (self.choseTag == 3) {
            self.productDetailViewHeight.constant = self.THeight;
        }
    }
    
    {
        __block CGFloat secendTop = 0;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 30, 100)];
        view.backgroundColor = RGB(253, 250, 243);
        [self.bottomView addSubview:view];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"相关圣物推荐";
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
        
        [self.viewModel.model.recommendArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ProductModel *model = [[ProductModel alloc] init];
            [model getModelForServer:obj];
            if (idx % 2 == 0) {
                ProductListSecend *firstview = [[ProductListSecend alloc] init];
                [self.bottomView addSubview:firstview];
                [firstview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(secendTop);
                    make.left.equalTo(self.bottomView.mas_left).offset(0);
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
                [firstview getdateForModel:model];
            } else {
                ProductListSecend *secendView = [[ProductListSecend alloc] init];
                [self.bottomView addSubview:secendView];
                secendView.block_sureClick = ^(NSString *key) {
                    ProductDetailViewModel *viewModel = [[ProductDetailViewModel alloc] init];
                    viewModel.key = key;
                    ProductDetailViewController *PVC = [[ProductDetailViewController alloc] initWithViewModel:viewModel];
                    [self.navigationController pushViewController:PVC animated:YES];
                };
                [secendView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(secendTop - 260);
                    make.left.equalTo(self.bottomView.mas_centerX).offset(5);
                    make.width.equalTo(self.bottomView.mas_width).multipliedBy(0.5).offset(-15);
                    make.height.mas_equalTo(250);
                }];
                [secendView getdateForModel:model];
            }
        }];
        self.productBottomViewHeight.constant = secendTop + 70;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shuButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)detailButtonClick:(UIButton *)sender {
    [self.detailButtonArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == sender) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
    }];
    
    self.detailLineViewLeft.constant = (sender.tag - 1) * sender.frame.size.width;
    [UIView animateWithDuration:2 animations:^{
        self.productDetailViewLeft.constant =  -(sender.tag - 1) * kScreenWidth;
        if (sender.tag == 1) {
            self.productDetailViewHeight.constant = self.PicHeight;
        } else if (sender.tag == 2) {
            self.productDetailViewHeight.constant = self.ComHeight;
        } else if (sender.tag == 3) {
            self.productDetailViewHeight.constant = self.THeight;
        }
    }];
    self.choseTag = sender.tag;
}

- (IBAction)sureButtonClick:(id)sender {
    ProductPayViewModel *viewModel = [[ProductPayViewModel alloc] init];
    viewModel.model = self.viewModel.model;
    ProductPayViewController *PVC = [[ProductPayViewController alloc] initWithModel:viewModel];
    [self.navigationController pushViewController:PVC animated:YES];
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
