//
//  LovePairViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/5/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultLovePairModel.h"
#import "ResultLovePairModel.h"
@interface LovePairViewModel : BaseViewModel
@property (nonatomic, strong)NSDate *selMaleDate;
@property (nonatomic, strong)NSDate *selFemaleDate;
@property (nonatomic, strong)NSString *maleName;
@property (nonatomic, strong)NSString *femaleName;
@property (nonatomic, strong)ResultLovePairModel *model;

- (void)getmaleDateForSele:(NSDate *)selectDate;
- (void)getfemaleDateForSele:(NSDate *)selectDate;

@end
