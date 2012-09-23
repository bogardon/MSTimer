//
//  MSTimer.h
//  Miso
//
//  Created by John Wu on 12/8/11.
//  Copyright (c) 2011 TFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSTimer : NSObject

+ (id) startTimerWithTimeInterval:(NSTimeInterval)seconds target:(id)target selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats runLoop:(NSRunLoop *)runLoop mode:(NSString *)mode;

@end

@interface MSTimer (ForwardedMethods)

- (void)fire;
- (NSDate *)fireDate;
- (void)invalidate;
- (BOOL)isValid;
- (void)setFireDate:(NSDate *)date;
- (NSTimeInterval)timeInterval;
- (id)userInfo;

@end
