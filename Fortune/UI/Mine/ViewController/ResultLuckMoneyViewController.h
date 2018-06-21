//
//  ResultLuckMoneyViewController.h
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewController.h"
#import "ResultLuckMoneyViewModel.h"

@interface ResultLuckMoneyViewController : BaseViewController
@property (nonatomic, strong)ResultLuckMoneyViewModel *viewModel;
- (instancetype)initWithViewModel:(ResultLuckMoneyViewModel *)viewModel;

@end
