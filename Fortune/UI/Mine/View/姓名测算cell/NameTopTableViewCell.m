//
//  NameTopTableViewCell.m
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NameTopTableViewCell.h"


@interface NameTopTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *name_fantView;
@property (weak, nonatomic) IBOutlet UIView *pingyingView;
@property (weak, nonatomic) IBOutlet UIView *bihuaView;
@property (weak, nonatomic) IBOutlet UIView *wuxingView;
@property (weak, nonatomic) IBOutlet UIView *jixiongView;


@end

@implementation NameTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)getDateForModel:(ResultNameModel *)model {
    [self labelGetText:model.nameArray andSuperView:self.nameView];
    [self labelGetText:model.fonnameArray andSuperView:self.name_fantView];
    [self labelGetText:model.spellArray andSuperView:self.pingyingView];
    [self labelGetText:model.strokesArray andSuperView:self.bihuaView];
    [self labelGetText:model.wuxingArray andSuperView:self.wuxingView];
    [self labelGetText:model.jixiongArray andSuperView:self.jixiongView];
}

- (void)labelGetText:(NSArray *)array andSuperView:(UIView *)view{
    CGFloat line = (kScreenWidth - 75)/array.count;
    for (int i =0; i<array.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.equalTo(view.mas_left).offset(75+ line *i);
        }];
        label.text = array[i];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
