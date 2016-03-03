//
//  SafelyPerformSelector.m
//  OptionalOutlets
//
//  Created by Francesco Perrotti-Garcia on 3/3/16.
//  Copyright © 2016 Francesco Perrotti-Garcia. All rights reserved.
//

#import "SafelyPerformSelector.h"

@implementation NSObject (SafelyPerformSelector)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (id)safelyPerformSelector:(SEL)aSelector {
    @try {
        return [self performSelector:aSelector];
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (id)safelyPerformSelector:(SEL)aSelector withObject:(id)object {
    @try {
        return [self performSelector:aSelector withObject:object];
    }
    @catch (NSException *exception) {
        return nil;
    }
}

#pragma clang diagnostic pop

@end
