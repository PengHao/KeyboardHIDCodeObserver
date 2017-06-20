//
//  NSObject+Runtime.h
//  KeyboardTest
//
//  Created by peng hao on 2017/3/17.
//  Copyright © 2017年 peng hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)
-(NSObject*) getInstanceVariable:(NSString *) name;
+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)aftSel;
@end
