//
//  ResultNameViewController.h
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewController.h"
#import "ResultNameViewModel.h"

@interface ResultNameViewController : BaseViewController
@property (nonatomic, strong)ResultNameViewModel *viewModel;
- (instancetype)initWithViewModel:(ResultNameViewModel *)viewModel;

@end
