//
//  PersonTopDetailModel.m
//  Fortune
//
//  Created by Sj03 on 2018/4/11.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PersonTopDetailModel.h"

@implementation PersonTopDetailModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _title = @"";
        _brithDateG = @"";
        _nayin = @"";
        _wuxing = @"";
        _bazi = @"";
        _brithDateY = @"";
        _projectName = @"";
    }
    return self;
}

- (void)getdateForServer:(NSDictionary *)dic {
    self.title =  [dic stringForKey:@"title"];
    self.brithDateG = [dic stringForKey:@"birth_date_g"];
    self.nayin = [dic stringForKey:@"nayin"];
    self.wuxing = [dic stringForKey:@"wuxing"];
    self.bazi = [dic stringForKey:@"bazi"];
    self.projectName = [dic stringForKey:@"project_name"];
    self.brithDateY = [dic stringForKey:@"birth_date_y"];
}

@end
