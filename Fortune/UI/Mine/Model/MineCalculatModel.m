//
//  MineCalculatModel.m
//  Fortune
//
//  Created by Sj03 on 2018/4/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MineCalculatModel.h"

@implementation MineCalculatModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _personName = @"";
        _programName = @"";
        _date = @"";
        _programId = @"1";
    }
    return self;
}

- (void)getDataForServer:(NSDictionary *)dic {
    self.personName = [dic stringForKey:@"name"];
    self.programName = [dic stringForKey:@"project_name"];
    
    if ([dic stringForKey:@"create_time"].length > 10) {
        self.date = [[dic stringForKey:@"create_time"] substringToIndex:10];
    } else {
        self.date = [dic stringForKey:@"create_time"];
    }

    self.programId = [dic stringForKey:@"id"];
}

@end
