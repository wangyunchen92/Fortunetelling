//
//  MainSmallBannerCell.m
//  Fortune
//
//  Created by Sj03 on 2018/6/20.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MainSmallBannerCell.h"

@interface MainSmallBannerCell ()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MainSmallBannerCell


-(void)awakeFromNib {
    [super awakeFromNib];
    [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
}

- (void)getDateForModel:(MainCellModel *)model {
    self.titleLabel.text = model.title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.mainPic]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
