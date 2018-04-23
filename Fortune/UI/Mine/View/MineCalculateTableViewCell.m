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


@end


@implementation MineCalculateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.maskView.layer.borderWidth = 1;
    self.maskView.layer.borderColor = RGB(198, 187, 172).CGColor;
    [self addline:self.boardFirstView];
//    [self addline:self.boardFourView];
//    [self addline:self.boardThreeView];
//    [self addline:self.boardView];
    // Initialization code
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
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    
    //设置路径
    border.path = path.CGPath;
    
    border.frame = view.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    view.layer.masksToBounds = YES;
    
    [view.layer addSublayer:border];
}

@end
