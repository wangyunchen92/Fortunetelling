//
//  PersonDetailViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/4/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonTopDetailModel.h"

@interface PersonDetailViewModel : BaseViewModel
@property (nonatomic, assign)BOOL isgetDate;
@property (nonatomic, copy)NSString *programId;
@property (nonatomic, strong)PersonTopDetailModel *topModel;
@property (nonatomic, strong)NSMutableArray *boardArray;


@end
