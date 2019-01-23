//
//  ProductDetailComment.m
//  Fortune
//
//  Created by Sj03 on 2018/6/28.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductDetailComment.h"

@implementation ProductDetailComment

- (void)creatViewWithServer:(NSArray *)arr {
    
    [arr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, idx *100, self.frame.size.width, 100)];
        [self addSubview:view];
        view.backgroundColor  = self.backgroundColor;
        UILabel *nameLabel = [[UILabel alloc] init];
        [view addSubview:nameLabel];
        nameLabel.text = [obj stringForKey:@"comment_name"];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(15);
        }];
        
        UILabel *dataLabel = [[UILabel alloc] init];
        [view addSubview:dataLabel];
        dataLabel.textColor = [UIColor grayColor];
        dataLabel.text = [obj stringForKey:@"comment_time"];
        [dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.top.mas_offset(15);
        }];
        
        UILabel *contentLabel = [[UILabel alloc] init];
        [view addSubview:contentLabel];
        contentLabel.text = [obj stringForKey:@"comment_info"];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:14];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.equalTo(nameLabel.mas_bottom).offset(15);
            make.right.mas_offset(-10);
        }];
        UIView *lineView = [[UIView alloc] init];
        [view addSubview:lineView];
        lineView.backgroundColor = RGB(204,204,204);
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(1);
            make.bottom.mas_offset(1);
        }];
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
