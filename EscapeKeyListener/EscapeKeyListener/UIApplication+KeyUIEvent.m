//
//  UIApplication+KeyUIEvent.m
//  Vim
//
//  Created by peng hao on 2017/6/19.
//
//

#import "UIApplication+KeyUIEvent.h"
#import "NSObject+Runtime.h"
#import "KeyboardEventManager.h"


@implementation UIApplication (KeyUIEvent)

+(void) load {
    [super load];
    SEL sel = NSSelectorFromString(@"handleKeyHIDEvent:");
    [UIApplication swizzleMethod:sel withMethod:@selector(myHandleKeyHIDEvent:)];
}

-(void) myHandleKeyHIDEvent:(UIEvent *) event{
//    https://wenku.baidu.com/view/1bfb5345b307e87101f696de.html
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *eventString = [NSString stringWithFormat:@"%@", event];
    [eventString enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        if ([line rangeOfString:@":"].location!= NSNotFound) {
            NSArray *array = [line componentsSeparatedByString:@":"];
            NSString *key = [array objectAtIndex:0];
            NSString *value = [array objectAtIndex:1];
            value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            key = [key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [dic setObject:value forKey:key];
        }
    }];
    NSString *type = [dic objectForKey:@"EventType"];
    if ([type isEqualToString:@"Keyboard"]) {
        NSString *usageStr = [dic objectForKey:@"Usage"];
        NSString *downStr = [dic objectForKey:@"Down"];
        
        NSInteger usage = [usageStr integerValue];
        BOOL isPressDown = [downStr isEqualToString:@"1"];
        [[KeyboardEventManager sharedKeyboardEventManager] handleKey:usage isPressDown:isPressDown];
    }
    
    [self myHandleKeyHIDEvent: event];
}



@end
