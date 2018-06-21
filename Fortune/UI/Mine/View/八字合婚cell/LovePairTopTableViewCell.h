//
//  LovePairTopTableViewCell.h
//  Fortune
//
//  Created by Sj03 on 2018/5/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultLovePairModel.h"

@interface LovePairTopTableViewCell : UITableViewCell
- (void)getDateForServer:(ResultLovePairModel *)model isman:(BOOL )isman;

@end
