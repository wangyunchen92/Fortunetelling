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


@end


@implementation MineCalculateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
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

@end
