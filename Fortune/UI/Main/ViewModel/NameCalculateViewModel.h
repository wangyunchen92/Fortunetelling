//
//  NameCalculateViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewModel.h"
#import "ResultNameModel.h"

@interface NameCalculateViewModel : BaseViewModel

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)ResultNameModel *model;

@end
