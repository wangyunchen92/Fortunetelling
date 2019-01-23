//
//  ProductDetailRecord.m
//  Fortune
//
//  Created by Sj03 on 2018/6/28.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductDetailRecord.h"

@implementation ProductDetailRecord

- (void)creatViewWithServer:(NSArray *)arr {
    {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.top.mas_offset(0);
            make.right.mas_offset(0);
            make.height.mas_offset(44);
        }];
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.textColor = RGB(162, 87, 65);
        leftLabel.text = @"有缘人";
        leftLabel.font = [UIFont systemFontOfSize:15];
        [view addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(5);
        }];
        
        UILabel *minLabel = [[UILabel alloc] init];
        minLabel.textColor = RGB(162, 87, 65);
        minLabel.text = @"请购数量";
        minLabel.font = [UIFont systemFontOfSize:15];
        [view addSubview:minLabel];
        [minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.top.mas_offset(5);
        }];
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.textColor = RGB(162, 87, 65);
        rightLabel.text = @"有缘人";
        rightLabel.font = [UIFont systemFontOfSize:15];
        [view addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.top.mas_offset(5);
        }];
    }
    
    [arr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.top.mas_offset(44 * idx + 44);
            make.right.mas_offset(0);
            make.height.mas_offset(44);
        }];
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.text = [obj stringForKey:@"record_name"];
        leftLabel.font = [UIFont systemFontOfSize:15];
        [view addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(5);
        }];
        
        UILabel *minLabel = [[UILabel alloc] init];
        minLabel.text = [obj stringForKey:@"record_num"];
        minLabel.font = [UIFont systemFontOfSize:15];
        [view addSubview:minLabel];
        [minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.top.mas_offset(5);
        }];
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.text = [obj stringForKey:@"record_time"];
        rightLabel.font = [UIFont systemFontOfSize:15];
        [view addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.top.mas_offset(5);
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
