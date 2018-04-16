//
//  UIScrollView+UITouch.m
//  Fortune
//
//  Created by Sj03 on 2018/4/13.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 选其一即可
    [super touchesBegan:touches withEvent:event];
    //  [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
