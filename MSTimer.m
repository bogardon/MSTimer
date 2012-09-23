//
//  MSTimer.m
//  Miso
//
//  Created by John Wu on 12/8/11.
//  Copyright (c) 2011 TFM. All rights reserved.
//

#import "MSTimer.h"

@interface MSTimer () {
    id _target;
    SEL _selector;
    NSTimer *_timer;
}

- (id) initWithTarget:(id)target selector:(SEL)selector interval:(NSTimeInterval)interval userInfo:(id)userInfo repeats:(BOOL)repeats runLoop:(NSRunLoop *)runLoop mode:(NSString *)mode;

- (void)onTimer;

@end

@implementation MSTimer

+ (id) startTimerWithTarget:(id)target selector:(SEL)selector userInfo:(id)userInfo interval:(NSTimeInterval)interval repeats:(BOOL)repeats runLoop:(NSRunLoop *)runLoop mode:(NSString *)mode {
    MSTimer *timer = [[[MSTimer alloc] initWithTarget:target selector:selector interval:interval userInfo:userInfo repeats:repeats runLoop:runLoop mode:mode] autorelease];
    return timer;
}

- (id) initWithTarget:(id)target selector:(SEL)selector interval:(NSTimeInterval)interval userInfo:(id)userInfo repeats:(BOOL)repeats runLoop:(NSRunLoop *)runLoop mode:(NSString *)mode {
    self = [super init];
    if (self) {
        _target = target;
        _selector = selector;
        _timer = [[NSTimer timerWithTimeInterval:interval target:self selector:@selector(onTimer) userInfo:userInfo repeats:repeats] retain];
        [runLoop addTimer:_timer forMode:mode];
    }
    return self;
}

- (id)initTimerWithTarget:(id)target selector:(SEL)selector interval:(NSTimeInterval)interval repeats:(BOOL)repeats {
    self = [super init];
    if (self) {
        _target = target;
        _selector = selector;
        _timer = [[NSTimer timerWithTimeInterval:interval target:self selector:@selector(onTimer) userInfo:nil repeats:repeats] retain];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)dealloc {
    [_timer release];
    _timer = nil;
    _target = nil;
    _selector = nil;
    [super dealloc];
}

#pragma mark - Message Fowarding

+ (BOOL)instancesRespondToSelector:(SEL)aSelector {
    return [[self class] instancesRespondToSelector:aSelector] || [[NSTimer class] instancesRespondToSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([_timer respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:_timer];
    else
        [super forwardInvocation:anInvocation];
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature)
        signature = [_timer methodSignatureForSelector:selector];
    return signature;
}

- (BOOL) isKindOfClass:(Class)aClass {
    return (aClass == [NSTimer class]) || [super isKindOfClass:aClass];
}

- (BOOL) respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [_timer respondsToSelector:aSelector];
}

#pragma mark - Private Methods
                  
- (void)onTimer {
    [_target performSelector:_selector];
}

@end
