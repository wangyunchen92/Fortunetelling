//
//  MineCalculatModel.h
//  Fortune
//
//  Created by Sj03 on 2018/4/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineCalculatModel : NSObject
@property (nonatomic, copy)NSString *programName;
@property (nonatomic, copy)NSString *personName;
@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSString *programId;
@property (nonatomic, assign)CeSuanType type;
- (void)getDataForServer:(NSDictionary *)dic;
@end
