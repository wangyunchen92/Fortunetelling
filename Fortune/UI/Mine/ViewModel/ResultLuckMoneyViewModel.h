//
//  ResultLuckMoneyViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewModel.h"
#import "ResultLuckMoneyModel.h"

@interface ResultLuckMoneyViewModel : BaseViewModel
@property (nonatomic, strong)ResultLuckMoneyModel *model;
@property (nonatomic, assign)BOOL isgetDate;
@property (nonatomic, strong)NSMutableArray *boardArray;
@property (nonatomic, copy)NSString *programId;

@end
