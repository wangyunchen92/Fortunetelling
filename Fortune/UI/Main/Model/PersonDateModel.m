//
//  personDateModel.m
//  Fortune
//
//  Created by Sj03 on 2018/5/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PersonDateModel.h"

@implementation PersonDateModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _year = @"";
        _month = @"";
        _day = @"";
        _hour = @"";
        _min= @"";
    }
    return self;
}


- (void)getdateForYear:(NSString *)year month:(NSString *)month day:(NSString *)day hour:(NSString *)hour min:(NSString *)min {
    self.year = year;
    self.month = month;
    self.day = day;
    self.hour = hour;
    self.min = min;
}
@end
