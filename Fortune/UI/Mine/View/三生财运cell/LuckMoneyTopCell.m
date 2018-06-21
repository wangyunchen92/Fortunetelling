//
//  LuckMoneyTopCellTableViewCell.m
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "LuckMoneyTopCell.h"

@interface LuckMoneyTopCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LuckMoneyTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDateForModel:(NSString *)model {
    self.titleLabel.text = model;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
