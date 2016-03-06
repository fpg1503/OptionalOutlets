//
//  Optional Outlets.h
//  Optional Outlets
//
//  Created by Francesco Perrotti-Garcia on 3/6/16.
//  Copyright © 2016 Francesco Perrotti-Garcia. All rights reserved.
//

#import <AppKit/AppKit.h>

@class Optional Outlets;

static Optional Outlets *sharedPlugin;

@interface Optional Outlets : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end