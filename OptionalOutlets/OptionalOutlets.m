//
//  OptionalOutlets.m
//  OptionalOutlets
//
//  Created by Francesco Perrotti-Garcia on 3/6/16.
//  Copyright © 2016 Francesco Perrotti-Garcia. All rights reserved.
//

#import "OptionalOutlets.h"

@interface OptionalOutlets()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@interface DVTTextStorage : NSTextStorage

- (void)replaceCharactersInRange:(struct _NSRange)arg1 withString:(nonnull NSString *)arg2 withUndoManager:(nullable id)arg3;

@end

@implementation OptionalOutlets

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (instancetype)initWithBundle:(NSBundle *)plugin {
    self = [super init];
    if (self) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)notification {
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editorDocumentDidChange:) name:@"IDEEditorDocumentDidChangeNotification" object:nil];
}


- (void)editorDocumentDidChange:(NSNotification *)notification {
    NSArray *array = notification.userInfo[@"IDEEditorDocumentChangeLocationsKey"];
    id firstChange = array.firstObject;
    
    NSURL *url = [firstChange valueForKey:@"documentURL"];
    if (![url isKindOfClass:[NSNull class]]) {
        NSRange range = [[firstChange valueForKey:@"characterRange"] rangeValue];
        
        // Check if it's a valid range
        if (range.length == 0 || range.location == NSNotFound) {
            return;
        }
        
        // Check if it's an IDESourceCodeDocument
        if (![notification.object respondsToSelector:@selector(textStorage)]) {
            return;
        }
        
        id textStorage = [notification.object textStorage];
        NSAttributedString *attributed;
        
        NSRange newRange = NSMakeRange(range.location, range.length + 3);
        //Fixes a bug where the last three characters would not be present
        
        @try {
            attributed = [textStorage attributedSubstringFromRange:newRange];
        }
        @catch (NSException *exception) {
            return;
        }
        
        NSString *substring = attributed.string;
        
        NSString *updatedSubstring = [self fixedStringForString: substring];
        if (![updatedSubstring isEqualToString:substring]) {
            [textStorage beginEditing];
            [textStorage replaceCharactersInRange:newRange withString:updatedSubstring withUndoManager:nil];
            [textStorage endEditing];
        }
    }
}

- (nonnull NSString *)fixedStringForString:(nonnull NSString *)string {
    
    NSString *regexPattern = @"^(\\s*@IBOutlet[\\w:\\s]*)!";
    NSString *replaceTemplate = @"$1?";
    
    NSMutableString *fixedString = [string mutableCopy];
    NSRange fullRange = (NSRange){0, fixedString.length};
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:0 error:nil];
    
    NSUInteger replaces = [regex replaceMatchesInString:fixedString options:0 range:fullRange withTemplate:replaceTemplate];
    
    return replaces == 1 ? fixedString : string;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
