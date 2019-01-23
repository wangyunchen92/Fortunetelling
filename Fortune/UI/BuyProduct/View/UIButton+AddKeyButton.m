//
//  UIButton+AddKeyButton.m
//  Fortune
//
//  Created by Sj03 on 2018/6/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "UIButton+AddKeyButton.h"
#import <objc/message.h>

static const char *keys = "keys";
@implementation UIButton (AddKeyButton)
- (void)setKey:(NSString *)key {
    
    objc_setAssociatedObject(self, keys, key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)key {
    
    return objc_getAssociatedObject(self, keys);
}
@end
