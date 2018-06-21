//
//  ResultNameViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultNameModel.h"

@interface ResultNameViewModel : BaseViewModel
@property (nonatomic, strong)ResultNameModel *model;
@property (nonatomic, assign)BOOL isgetDate;
@property (nonatomic, strong)NSMutableArray *boardArray;
@property (nonatomic, copy)NSString *programId;

@end
