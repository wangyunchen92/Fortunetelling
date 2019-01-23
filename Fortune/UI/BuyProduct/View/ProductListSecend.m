//
//  ProductListSecend.m
//  Fortune
//
//  Created by Sj03 on 2018/6/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductListSecend.h"
#import "UIButton+AddKeyButton.h"


@interface ProductListSecend ()

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIButton *button;

@end

@implementation ProductListSecend

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.imageView = [[UIImageView alloc] init];
        
        [self addSubview:self.imageView];
        self.imageView.image = IMAGE_NAME(@"product");
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(140);
            make.width.mas_equalTo(120);
            make.top.mas_equalTo(15);
        }];
        
        self.label = [[UILabel alloc] init];
        _label.text = @"";
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = RGB(209, 89, 82);
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(30);
            make.top.equalTo(self.imageView.mas_bottom).offset(10);
        }];

        self.button = [[UIButton alloc] init];
        [self addSubview:self.button];
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(33);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.mas_equalTo(100);
        }];
        
        [self.button setTitle:@"立即购买" forState:0];
        self.button.backgroundColor = RGB(162, 87, 65);
        self.button.layer.masksToBounds = YES;
        self.button.layer.cornerRadius = 4;
        
        [self.button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchDown];
    
        
//        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.mas_equalTo(0);
//            make.width.mas_equalTo(0);
//            make.height.mas_equalTo(0);
//        }];
        self.backgroundColor = RGB(254, 250, 242);
    }
    return self;
}

- (void)sureAction:(UIButton *)sender {
    DLog(@"%@",self.button.key);
    if (self.block_sureClick) {
        self.block_sureClick(self.button.key);
    }

}

- (void)getdateForModel:(ProductModel *)model {
    self.label.text = model.name;
    self.button.key = model.key;
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
