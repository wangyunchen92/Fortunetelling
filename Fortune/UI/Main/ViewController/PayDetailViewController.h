//
//  PayDetailViewController.h
//  Fortune
//
//  Created by Sj03 on 2018/4/12.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewController.h"
#import "PayViewModel.h"

@interface PayDetailViewController : BaseViewController
@property (nonatomic, copy)void (^block_payResult)(BOOL );
- (instancetype)initWithViewModel:(PayViewModel *)viewModel;

@end
