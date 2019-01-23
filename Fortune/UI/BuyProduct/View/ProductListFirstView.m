//
//  ProductListFirstView.m
//  Fortune
//
//  Created by Sj03 on 2018/6/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductListFirstView.h"
#import "UIButton+AddKeyButton.h"
@interface ProductListFirstView ()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ProductListFirstView

- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        self.view.frame = self.bounds;
        [self addSubview:self.view];
        [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)sureAction:(UIButton *)sender {
    DLog(@"%@",self.sureButton.key);
    if (self.block_sureClick) {
        self.block_sureClick(sender.key);
    }
}

- (void)getdateForModel:(ProductModel *)model {
    self.title.text = model.name;
    self.subLabel.text = model.subhead;
    self.sureButton.key = model.key;
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
