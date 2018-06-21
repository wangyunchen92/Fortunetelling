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

@end
@implementation PersonDetailTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)getdateForModel:(PersonTopDetailModel *)model {
    self.firstLabel.text = model.brithDateY;
    self.secendLabel.text = model.brithDateG;
    self.threeLabel.text = model.bazi;
    self.fourLabel.text = model.wuxing;
    self.fiveLabel.text = model.nayin;
    self.titleLabel.text = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
