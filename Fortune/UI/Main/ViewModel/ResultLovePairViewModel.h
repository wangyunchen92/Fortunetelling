//
//  ResultLovePairViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/5/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultLovePairModel.h"

@interface ResultLovePairViewModel : BaseViewModel
@property (nonatomic, assign)BOOL isgetDate;
@property (nonatomic, copy)NSString *programId;
@property (nonatomic, strong)ResultLovePairModel *topModel;
@property (nonatomic, strong)NSMutableArray *boardArray;

@end
