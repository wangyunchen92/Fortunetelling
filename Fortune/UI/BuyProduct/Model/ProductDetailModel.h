//
//  ProductDetailModel.h
//  Fortune
//
//  Created by Sj03 on 2018/6/28.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailModel : NSObject

@property (nonatomic, strong)NSArray *commentInfoArray;
@property (nonatomic, strong)NSArray *detailPicArray;
@property (nonatomic, strong)NSArray *recordInfoArray;
@property (nonatomic, strong)NSArray *recommendArray;

@property (nonatomic, copy)NSString *detailPic;
@property (nonatomic, copy)NSString *evaluate;
@property (nonatomic, copy)NSString *subhead;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, copy)NSString *idkey;
@property (nonatomic, copy)NSString *main_pic;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *original_price;
@property (nonatomic, copy)NSString *prefer_price;
@property (nonatomic, assign)BOOL  isShu;
- (void)getModelForServer:(NSDictionary *)dic;
@end
