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
    
    
    self.programName = [dic stringForKey:@"project_name"];
    if ([self.programName isEqualToString:@"八字合婚"]) {
        self.personName =[NSString stringWithFormat:@"%@,%@",[dic stringForKey:@"man_name"],[dic stringForKey:@"woman_name"]];
        self.type = marry_CeSuanType;
    } else if ([self.programName isEqualToString:@"八字测算"]) {
        self.type = fortune_CeSuanType;
        self.personName = [dic stringForKey:@"name"];
    } else if ([self.programName isEqualToString:@"姓名测算"]){
        self.type = name_CeSuanType;
        self.personName = [dic stringForKey:@"name"];
    }
    
    if ([dic stringForKey:@"create_date"].length > 10) {
        self.date = [[dic stringForKey:@"create_date"] substringToIndex:10];
    } else {
        self.date = [dic stringForKey:@"create_date"];
    }

    self.programId = [dic stringForKey:@"id"];
}

@end
