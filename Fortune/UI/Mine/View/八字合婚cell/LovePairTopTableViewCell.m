//
//  LovePairTopTableViewCell.m
//  Fortune
//
//  Created by Sj03 on 2018/5/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "LovePairTopTableViewCell.h"


@interface LovePairTopTableViewCell ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *emptyLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *godLabel;
@property (weak, nonatomic) IBOutlet UILabel *ismanLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *shuLabel;
@property (weak, nonatomic) IBOutlet UILabel *palaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstbirthLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation LovePairTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDateForServer:(ResultLovePairModel *)model isman:(BOOL )isman {
    if (isman) {
        self.ismanLabel.text = @"男命解析";
        self.nameLabel.text = model.manName;
        self.dateLabel.text = model.manBirth;
        self.shuLabel.text = model.manZodiac;
        self.palaceLabel.text = model.manPalace;
        self.firstbirthLabel.text = model.manFirstborn;
        self.infoLabel.text = model.manInfo;
        [self.emptyLabel enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.manEmptyArray.count > idx) {
                obj.text = model.manEmptyArray[idx];
            }
        }];
        [self.godLabel enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.manGodArray.count > idx) {
                obj.text = model.manGodArray[idx];
            }
        }];
    } else {
        self.ismanLabel.text = @"女命解析";
        self.nameLabel.text = model.womeanName;
        self.dateLabel.text = model.womanBirth;
        self.shuLabel.text = model.womanZodiac;
        self.palaceLabel.text = model.womanPalace;
        self.firstbirthLabel.text = model.womanFirstborn;
        self.infoLabel.text = model.womanInfo;
        [self.emptyLabel enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.womanEmptyArray.count > idx) {
                obj.text = model.manEmptyArray[idx];
            }
        }];
        [self.godLabel enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.womanGodArray.count > idx) {
                obj.text = model.manGodArray[idx];
            }
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
