//
//  EveryDayViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/4/16.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewModel.h"
#import "EveryDayModel.h"
@interface EveryDayViewModel : BaseViewModel
@property (nonatomic, strong)NSDate *date;
@property (nonatomic, strong)EveryDayModel *model;

@end
