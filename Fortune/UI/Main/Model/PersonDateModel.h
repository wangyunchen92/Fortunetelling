//
//  personDateModel.h
//  Fortune
//
//  Created by Sj03 on 2018/5/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonDateModel : NSObject
@property (nonatomic, copy)NSString *year;
@property (nonatomic, copy)NSString *month;
@property (nonatomic, copy)NSString *day;
@property (nonatomic, copy)NSString *hour;
@property (nonatomic, copy)NSString *min;
- (void)getdateForYear:(NSString *)year month:(NSString *)month day:(NSString *)day hour:(NSString *)hour min:(NSString *)min;
@end
