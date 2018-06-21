//
//  ResultLuckMoneyModel.m
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ResultLuckMoneyModel.h"

@implementation ResultLuckMoneyInfo
- (instancetype)init {
    self = [super init];
    if (self) {
        _title = @"";
        _content = @"";
    }
    return self;
}

-(void)getModelForServer:(NSDictionary *)dic {
    self.title = [dic stringForKey:@"title"];
    NSArray *array = [dic arrayForKey:@"content"];
    __block NSString *string;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            string = obj;
        }else {
            string = [NSString stringWithFormat:@"%@\n%@",string,obj];
        }
    }];
    self.content = string;
}
@end


@implementation ResultLuckMoneyModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _title = @"";
        _array = [[NSArray alloc] init];
    }
    return self;
}

-(void)getModelForServer:(NSDictionary *)dic {
    self.title = [NSString stringWithFormat:@"%@ %@ %@ %@",[dic stringForKey:@"name"],[dic stringForKey:@"birth_date"],[dic stringForKey:@"age"],[dic stringForKey:@"zodiac"]];
    
    NSArray *arr = [dic arrayForKey:@"info"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ResultLuckMoneyInfo *model = [[ResultLuckMoneyInfo alloc] init];
        [model getModelForServer:obj];
        [array addObject:model];
    }];
    self.array = [NSArray arrayWithArray:array];
}

@end
