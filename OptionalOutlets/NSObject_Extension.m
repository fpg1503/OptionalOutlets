//
//  NSObject_Extension.m
//  OptionalOutlets
//
//  Created by Francesco Perrotti-Garcia on 3/6/16.
//  Copyright © 2016 Francesco Perrotti-Garcia. All rights reserved.
//


#import "NSObject_Extension.h"
#import "OptionalOutlets.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[OptionalOutlets alloc] initWithBundle:plugin];
        });
    }
}
@end
