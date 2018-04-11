//
//  PersonDetailBoardTableViewCell.m
//  Fortune
//
//  Created by Sj03 on 2018/4/11.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PersonDetailBoardTableViewCell.h"
@interface PersonDetailBoardTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *boardLabel;

@end

@implementation PersonDetailBoardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getdateForDic:(NSDictionary *)dic {
    self.titleLabel.text = [dic stringForKey:@"title"];
    self.boardLabel.text = [dic stringForKey:@"content"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
