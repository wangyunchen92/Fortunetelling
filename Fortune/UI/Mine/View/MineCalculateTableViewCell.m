//
//  MineCalculateTableViewCell.m
//  Fortune
//
//  Created by Sj03 on 2018/4/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MineCalculateTableViewCell.h"

@interface MineCalculateTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *programLabel;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, copy)NSString *programId;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *boardView;
@property (weak, nonatomic) IBOutlet UIView *boardFirstView;
@property (weak, nonatomic) IBOutlet UIView *boardSecendView;
@property (weak, nonatomic) IBOutlet UIView *boardThreeView;
@property (weak, nonatomic) IBOutlet UIView *boardFourView;
@property (nonatomic, assign)BOOL isfirstLoad;


@end


@implementation MineCalculateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.maskView.layer.borderWidth = 1;
    self.maskView.layer.borderColor = RGB(198, 187, 172).CGColor;
    // Initialization code
    self.isfirstLoad = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
    [self.boardFourView addGestureRecognizer:tapGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 不加这下面两句，获得的尺寸会是xib里的未完成autolayout适配时的尺寸，storyboard同理（把这两句写在viewDidLoad:方法中，将contentView换成控制器的view）
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    if (self.isfirstLoad) {
        [self addline:self.boardFirstView];
        [self addsecendStyleline:self.boardSecendView];
        [self addline:self.boardThreeView];
        [self addthreeStyleline:self.boardFourView];
        self.isfirstLoad = NO;
    }
}

- (IBAction)cellClick:(id)sender {
    if (self.block_detailButtonClick) {
        self.block_detailButtonClick(self.programId);
    }
}

-(void)getDataForModel:(MineCalculatModel *)model {
    self.programLabel.text = model.programName;
    self.personNameLabel.text = model.personName;
    self.dateLabel.text = model.date;
    self.programId = model.programId;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClick:(id)sender {
    if (self.block_detailButtonClick) {
        self.block_detailButtonClick(self.programId);
    }
}

- (void)addline:(UIView *)view {
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = RGB(198, 187, 172).CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
    
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

- (void)addsecendStyleline:(UIView *)view {
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = RGB(198, 187, 172).CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, view.frame.size.height)];
    //设置路径
    [path moveToPoint:CGPointMake(view.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(view.frame.size.width, view.frame.size.height)];
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

- (void)addthreeStyleline:(UIView *)view {
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = RGB(198, 187, 172).CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(view.frame.size.width, 0)];
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

@end
