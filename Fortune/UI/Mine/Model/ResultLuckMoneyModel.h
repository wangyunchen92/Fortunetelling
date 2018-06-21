//
//  ResultLuckMoneyModel.h
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultLuckMoneyInfo : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;

@end

@interface ResultLuckMoneyModel : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSArray <ResultLuckMoneyInfo *>*array;
-(void)getModelForServer:(NSDictionary *)dic;
@end
