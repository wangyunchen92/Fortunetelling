//
//  NameBoardCell.m
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NameBoardCell.h"


@interface NameBoardCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation NameBoardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)getDateForModel:(ResultNameInfo *)model {
    NSMutableAttributedString *strings = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@:",model.title,model.subhead]];
    NSRange range1=[[strings string] rangeOfString:model.subhead];
    [strings addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range1];
    [strings addAttribute:NSForegroundColorAttributeName value:RGB(94, 94, 94) range:range1];
    self.titleLabel.attributedText = strings;
    
    __block NSString *str;
    [model.contentArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            str = [NSString stringWithFormat:@"%@",obj];
        } else {
            str = [NSString stringWithFormat:@"%@\n\n%@",str,obj];
        }
    }];
    self.contentLabel.text = str;
    [self layoutIfNeeded];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
