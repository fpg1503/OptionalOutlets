//
//  SafelyPerformSelector.h
//  OptionalOutlets
//
//  Created by Francesco Perrotti-Garcia on 3/3/16.
//  Copyright © 2016 Francesco Perrotti-Garcia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SafelyPerformSelector)

- (nullable id)safelyPerformSelector:(nonnull SEL)aSelector;
- (nullable id)safelyPerformSelector:(nonnull SEL)aSelector withObject:(nullable id)object;

@end
