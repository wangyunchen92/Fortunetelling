//
//  EveryDayTableViewCell.m
//  Fortune
//
//  Created by Sj03 on 2018/4/16.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "EveryDayTableViewCell.h"


@interface EveryDayTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;


@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *yiLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiLabel;

@end
@implementation EveryDayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getdateForModel:(YiJiModel *)model {
    self.leftImage.image = IMAGE_NAME(model.showTitle);
    self.dateLabel.text = model.chongsha;
    self.yiLabel.text = model.yi;
    self.jiLabel.text = model.ji;
    self.leftLabel.text = model.datetitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
