//
//  PersonDetailTopTableViewCell.m
//  Fortune
//
//  Created by Sj03 on 2018/4/11.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PersonDetailTopTableViewCell.h"

@interface PersonDetailTopTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secendLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *fiveLabel;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secendView;
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet UIView *fourView;
@property (weak, nonatomic) IBOutlet UIView *fiveView;
@property (weak, nonatomic) IBOutlet UIView *sixView;
@property (weak, nonatomic) IBOutlet UIView *sevenView;
@property (weak, nonatomic) IBOutlet UIView *eightView;
@property (weak, nonatomic) IBOutlet UIView *nineView;
@property (nonatomic, assign)BOOL isfirstLoad;

@end
@implementation PersonDetailTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.maskView.layer.borderWidth = 1;
    self.maskView.layer.borderColor = RGB(198, 187, 172).CGColor;
    // Initialization code
    self.isfirstLoad = YES;
}

- (void)getdateForModel:(PersonTopDetailModel *)model {
    self.firstLabel.text = model.brithDateY;
    self.secendLabel.text = model.brithDateG;
    self.threeLabel.text = model.bazi;
    self.fourLabel.text = model.wuxing;
    self.fiveLabel.text = model.nayin;
    self.titleLabel.text = model.title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 不加这下面两句，获得的尺寸会是xib里的未完成autolayout适配时的尺寸，storyboard同理（把这两句写在viewDidLoad:方法中，将contentView换成控制器的view）
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    if (self.isfirstLoad) {
        [ToolUtil addline:self.firstView];
        [ToolUtil addline:self.fourView];
        [ToolUtil addline:self.sixView];
        [ToolUtil addline:self.eightView];
        [self addsecendline:self.secendView];
        [self addsecendline:self.threeView];
        [self addsecendline:self.fiveView];
        [self addsecendline:self.sevenView];
        [self addsecendline:self.nineView];
        self.isfirstLoad = NO;
    }
}


- (void)addsecendline:(UIView *)view {
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = RGB(198, 187, 172).CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(view.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(view.frame.size.width, view.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, view.frame.size.height)];
    //设置路径
    border.path = path.CGPath;
    
    border.frame = view.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    //    view.layer.masksToBounds = YES;
    
    [view.layer addSublayer:border];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
