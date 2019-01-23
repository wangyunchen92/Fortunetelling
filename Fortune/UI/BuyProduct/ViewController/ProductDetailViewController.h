//
//  ProductDetailViewController.h
//  Fortune
//
//  Created by Sj03 on 2018/6/27.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductDetailViewModel.h"

@interface ProductDetailViewController : BaseViewController
- (instancetype)initWithViewModel:(ProductDetailViewModel *)viewModel;

@end
