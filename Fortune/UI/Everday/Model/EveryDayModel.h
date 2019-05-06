//
//  EveryDayModel.h
//  Fortune
//
//  Created by Sj03 on 2018/4/16.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YiJiModel : NSObject

@property (nonatomic, copy)NSString *yi;
@property (nonatomic, copy)NSString *ji;
@property (nonatomic, copy)NSString *showTitle;
@property (nonatomic, copy)NSString *chongsha;
@property (nonatomic, copy)NSString *datetitle;
- (void)getModelForServer:(NSString *)str andtag:(NSInteger )tag;
@end

@interface EveryDayModel : NSObject

@property (nonatomic, copy)NSString *topDate;
@property (nonatomic, copy)NSString *topContent;
@property (nonatomic, copy)NSString *boardYi;
@property (nonatomic, copy)NSString *boardJi;
@property (nonatomic, strong)NSMutableArray *boardtopArray; // 小时宜忌
@property (nonatomic, copy)NSString *baizujinji;
@property (nonatomic, strong)NSMutableArray *boardbottomArray;
@property (nonatomic, strong)NSString *bottom;
- (void)getModelForServer:(NSDictionary *)dic;
@end
