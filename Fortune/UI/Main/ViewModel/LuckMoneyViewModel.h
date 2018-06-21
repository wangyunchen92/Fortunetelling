//
//  LuckMoneyViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewModel.h"
#import "ResultLuckMoneyModel.h"

@interface LuckMoneyViewModel : BaseViewModel
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *sex;
@property (nonatomic, strong)NSDate *selDate;
@property (nonatomic, strong)ResultLuckMoneyModel *model;
- (void)getselDate:(NSDate *)selectDate;
@end
