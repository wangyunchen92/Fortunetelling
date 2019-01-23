//
//  ProductModel.h
//  Fortune
//
//  Created by Sj03 on 2018/6/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property (nonatomic, copy)NSString *key;
@property (nonatomic, copy)NSString *mainPic;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *subhead;
- (void)getModelForServer:(NSDictionary *)dic;
@end
