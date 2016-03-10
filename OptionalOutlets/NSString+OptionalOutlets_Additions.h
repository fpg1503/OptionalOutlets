//
//  NSString+OptionalOutlets_Additions.h
//  OptionalOutlets
//
//  Created by Christian Sampaio on 09/03/16.
//  Copyright © 2016 Francesco Perrotti-Garcia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OptionalOutlets_Additions)

- (nonnull NSString *)replaceImplicitlyUnwrappedForOptional;
- (nonnull NSString *)addPrivateKeyword;

@end
