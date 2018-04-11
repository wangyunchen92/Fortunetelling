//
//  PersonDetailViewController.h
//  Fortune
//
//  Created by Sj03 on 2018/4/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewController.h"
#import "PersonDetailViewModel.h"

@interface PersonDetailViewController : BaseViewController
- (instancetype)initWithViewModel:(PersonDetailViewModel *)viewModel;
@end
