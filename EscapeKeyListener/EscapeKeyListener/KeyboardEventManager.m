//
//  KeyboardEventManager.m
//  Vim
//
//  Created by peng hao on 2017/6/19.
//
//

#import "KeyboardEventManager.h"

static KeyboardEventManager* singleKeyboardEventManager;
@interface KeyboardEventManager()
@property(nonatomic, strong) NSMutableDictionary *dictonary;

@end

@implementation KeyboardEventManager
+(instancetype) sharedKeyboardEventManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleKeyboardEventManager = [[KeyboardEventManager alloc] init];
    });
    return singleKeyboardEventManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.dictonary = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void) addObserver:(NSInteger) keyCode block:(KeyBoardObserverBlock) block {
    NSString* key = [NSString stringWithFormat:@"%ld", (long)keyCode];
    NSMutableArray *array = [self.dictonary objectForKey:key];
    if (array == nil) {
        array = [NSMutableArray array];
        [self.dictonary setObject:array forKey:key];
    }
    
    if ([array containsObject:block]) {
        return;
    } else {
        block = (__bridge KeyBoardObserverBlock)Block_copy((__bridge void *)block);
        [array addObject:block];
    }
}


- (void) handleKey:(NSInteger) keyCode isPressDown:(BOOL) down {
    NSString* key = [NSString stringWithFormat:@"%ld", (long)keyCode];
    NSMutableArray *array = [self.dictonary objectForKey:key];
    if (array == nil) {
        return;
    }
    switch (keyCode) {
        case  0xE0: //KeyboardLeftControl
        case  0xE4: //KeyboardRightControl
            _isLeftCtrlDown = down;
            break;
        case  0xE1: //KeyboardLeftShift
        case  0xE5: //KeyboardRightShift
            _isLeftShiftDown = down;
            break;
        case  0xE2: //KeyboardLeftAlt
        case  0xE6: //KeyboardRightAlt
            _isLeftOptionDown = down;
            break;
        case  0xE3: //KeyboardLeft GUI
        case  0xE7: //KeyboardRight GUI
            _isLeftCommandDown = down;
            break;
        default:
            break;
    }
    
    for (KeyBoardObserverBlock block in array) {
        block(down);
    }
}
@end
