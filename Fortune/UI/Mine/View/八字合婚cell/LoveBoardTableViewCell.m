//
//  LoveBoardTableViewCell.m
//  Fortune
//
//  Created by Sj03 on 2018/5/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "LoveBoardTableViewCell.h"

@interface LoveBoardTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *secendtitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstraint;


@end

@implementation LoveBoardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getdateForModel:(ResultInfo *)model isshowSecendTitle:(BOOL)isshowSecendTitle  andsecendTitle:(NSString *)secendtitle{
    if (isshowSecendTitle) {
        self.secendtitleLabel.hidden = NO;
        self.titleTopConstraint.constant = 50;
        self.secendtitleLabel.text = secendtitle;
    } else {
        self.secendtitleLabel.hidden = YES;
        self.titleTopConstraint.constant = 15;
    }
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
