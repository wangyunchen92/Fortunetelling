//
//  LuckMoneyBoardTableViewCell.h
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResultLuckMoneyInfo;
@interface LuckMoneyBoardCell : UITableViewCell
- (void)getDateForModel:(ResultLuckMoneyInfo *)model;
@end
