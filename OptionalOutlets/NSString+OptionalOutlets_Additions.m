//
//  NSString+OptionalOutlets_Additions.m
//  OptionalOutlets
//
//  Created by Christian Sampaio on 09/03/16.
//  Copyright © 2016 Francesco Perrotti-Garcia. All rights reserved.
//

#import "NSString+OptionalOutlets_Additions.h"

@implementation NSString (OptionalOutlets_Additions)

- (nonnull NSString *)replaceImplicitlyUnwrappedForOptional {
    return [self replaceMatchesWithRegex:@"^(\\s*@IBOutlet[\\w:\\s\\[\\]]*)!" replaceTemplate:@"$1?"];
}

- (nonnull NSString *)addPrivateKeyword {
    return [self replaceMatchesWithRegex:@"(^\\s*@IBOutlet)\\s*((?:weak\\s*)?\\s*var\\s*\\w*:[\\w\\s]*)" replaceTemplate:@"$1 private $2"];
}

#pragma mark Internal

- (nonnull NSString *)replaceMatchesWithRegex:(nonnull NSString *)regexPattern replaceTemplate:(nonnull NSString *)replaceTemplate {

    NSMutableString *fixedString = [self mutableCopy];
    NSRange fullRange = (NSRange){0, fixedString.length};

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:0 error:nil];

    NSUInteger replaces = [regex replaceMatchesInString:fixedString options:0 range:fullRange withTemplate:replaceTemplate];

    return replaces == 1 ? fixedString : self;
}

@end
