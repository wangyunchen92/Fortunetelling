//
//  ProductListSecend.h
//  Fortune
//
//  Created by Sj03 on 2018/6/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

@interface ProductListSecend : UIView

- (void)getdateForModel:(ProductModel *)model;

@property (nonatomic, strong)void(^block_sureClick)(NSString *key);
@end
