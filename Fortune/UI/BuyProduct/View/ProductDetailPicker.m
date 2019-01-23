//
//  ProductDetailPicker.m
//  Fortune
//
//  Created by Sj03 on 2018/6/27.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductDetailPicker.h"
@interface ProductDetailPicker ()
@property (nonatomic,assign)CGFloat viewHeight;
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation ProductDetailPicker

- (void)creatViewWithServer:(NSArray *)arr {
    self.viewHeight = 0;
    
    [RACObserve(self, viewHeight) subscribeNext:^(id x) {
        CGRect rec = self.frame;
        rec.size.height = self.viewHeight ;
        self.frame = rec;
        if (self.block_changeHeight) {
            self.block_changeHeight(self.viewHeight);
        }
    }];
    
    [arr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            UIImageView *iView = [[UIImageView alloc] init];
            [iView sd_setImageWithURL:[NSURL URLWithString:obj] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                self.viewHeight = self.viewHeight + image.size.height;
            }];
            [self addSubview:iView];
            [iView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(0);
                make.right.equalTo(self.mas_right).offset(0);
                make.top.equalTo(self.mas_top).offset(0);
            }];
            self.imageView = iView;
        } else {
            UIImageView *iView = [[UIImageView alloc] init];
            [iView sd_setImageWithURL:[NSURL URLWithString:obj]completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                self.viewHeight = self.viewHeight + image.size.height;
            }];
            [self addSubview:iView];
            [iView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(0);
                make.right.equalTo(self.mas_right).offset(0);
                make.top.equalTo(self.imageView.mas_bottom).offset(0);
            }];
            self.imageView = iView;
        }
    }];
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
