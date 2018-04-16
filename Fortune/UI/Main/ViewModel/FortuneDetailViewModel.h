//
//  FortuneDetailViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/4/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewModel.h"
#import "PersonDetailViewModel.h"

@interface FortuneDetailViewModel : BaseViewModel
@property (nonatomic, copy)NSString *sex;
@property (nonatomic, copy)NSString *year;
@property (nonatomic, copy)NSString *month;
@property (nonatomic, copy)NSString *day;
@property (nonatomic, copy)NSString *hour;
@property (nonatomic, copy)NSString *min;
@property (nonatomic, copy)NSString *firstName;
@property (nonatomic, copy)NSString *lastName;
@property (nonatomic, copy)void (^block_personDetail)(PersonDetailViewModel *);
@property (nonatomic, copy)void (^block_isNoTest)(NSString *programId,PersonDetailViewModel * ); // 非审核跳转支付
- (void)getNowday:(NSDate *)selectDate;
@end
