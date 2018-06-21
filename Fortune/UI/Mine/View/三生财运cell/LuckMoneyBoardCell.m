//
//  LuckMoneyBoardTableViewCell.m
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "LuckMoneyBoardCell.h"
#import "ResultLuckMoneyModel.h"
@interface LuckMoneyBoardCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation LuckMoneyBoardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDateForModel:(ResultLuckMoneyInfo *)model {
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
