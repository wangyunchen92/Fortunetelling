//
//  ProductDetailViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/6/28.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewModel.h"
#import "ProductDetailModel.h"

@interface ProductDetailViewModel : BaseViewModel

@property (nonatomic, copy)NSString *key;
@property (nonatomic, strong)ProductDetailModel *model;
@end
