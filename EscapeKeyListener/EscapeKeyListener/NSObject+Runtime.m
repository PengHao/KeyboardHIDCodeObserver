//
//  NSObject+Runtime.m
//  KeyboardTest
//
//  Created by peng hao on 2017/3/17.
//  Copyright © 2017年 peng hao. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>
@implementation NSObject (Runtime)

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)aftSel {
    
    Method originMethod = class_getInstanceMethod(self, origSel);
    Method newMethod = class_getInstanceMethod(self, aftSel);
    
    if(originMethod && newMethod) {//必须两个Method都要拿到
        if(class_addMethod(self, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            //实现成功添加后
            class_replaceMethod(self, aftSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        } else {
            IMP imp = class_replaceMethod(self, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
            class_replaceMethod(self, aftSel, imp, method_getTypeEncoding(originMethod));
        }
        return YES;
    }
    return NO;
}

-(NSObject*) __getInstanceVariable:(NSString *) name {
    NSObject *value;
    Ivar var = class_getInstanceVariable([self class], name.UTF8String);
    value = object_getIvar(self, var);
    return value;
}


-(NSObject*) getInstanceVariable:(NSString *) name {
    NSObject *value;
    NSArray *names = [name componentsSeparatedByString:@"."];
    value = [self __getInstanceVariable:names.firstObject];
    for (int i = 1; i < names.count; ++i) {
        if (value != NULL) {
            value = [value __getInstanceVariable:[names objectAtIndex:i]];
        }
    }
    return value;
}


@end
