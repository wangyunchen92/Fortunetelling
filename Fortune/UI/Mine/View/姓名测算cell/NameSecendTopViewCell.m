//
//  NameSecendTopViewCell.m
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NameSecendTopViewCell.h"

@interface NameSecendTopViewCell ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *firstLineLabelArray;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *secendLineLabelArray;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *threeLineLabelArray;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *fourLineLabelArray;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *fiveLineLabelArray;
@end

@implementation NameSecendTopViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDateForModel:(ResultNameModel *)model {
    [self.firstLineLabelArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.lifeArray.count > 0) {
            NSArray *arr = model.lifeArray[0];
            obj.text = arr[idx];
        }
    }];
    
    [self.secendLineLabelArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.lifeArray.count > 1) {
            NSArray *arr = model.lifeArray[1];
            obj.text = arr[idx];
        }
    }];
    
    [self.threeLineLabelArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.lifeArray.count > 2) {
            NSArray *arr = model.lifeArray[2];
            obj.text = arr[idx];
        }
    }];
    
    [self.fourLineLabelArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.lifeArray.count > 3) {
            NSArray *arr = model.lifeArray[3];
            obj.text = arr[idx];
        }
    }];
    
    [self.fiveLineLabelArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.lifeArray.count > 4) {
            NSArray *arr = model.lifeArray[4];
            obj.text = arr[idx];
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
