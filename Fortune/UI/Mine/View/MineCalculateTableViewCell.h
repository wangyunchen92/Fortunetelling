//
//  MineCalculateTableViewCell.h
//  Fortune
//
//  Created by Sj03 on 2018/4/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineCalculatModel.h"

@interface MineCalculateTableViewCell : UITableViewCell
@property (nonatomic, copy)void (^block_detailButtonClick)(NSString *programId,CeSuanType);
-(void)getDataForModel:(MineCalculatModel *)model;
@end
