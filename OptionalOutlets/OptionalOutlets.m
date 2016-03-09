//
//  OptionalOutlets.m
//  OptionalOutlets
//
//  Created by Francesco Perrotti-Garcia on 3/6/16.
//  Copyright © 2016 Francesco Perrotti-Garcia. All rights reserved.
//

#import "OptionalOutlets.h"
#import "NSString+OptionalOutlets_Additions.h"

@interface OptionalOutlets()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@interface DVTTextStorage : NSTextStorage

- (void)replaceCharactersInRange:(struct _NSRange)arg1 withString:(nonnull NSString *)arg2 withUndoManager:(nullable id)arg3;

@end

@implementation OptionalOutlets

static NSString * const PrivateFeatureKey = @"com.perrotti-garcia.OptionalOutlets.kPrivateFeatureEnabled";
static NSString * const OptionalFeatureKey = @"com.perrotti-garcia.OptionalOutlets.kOptionalFeatureEnabled";

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (instancetype)initWithBundle:(NSBundle *)plugin {
    self = [super init];
    if (self) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [self setDefaultValue:@(YES) forFeatureKey:OptionalFeatureKey];
        [self setDefaultValue:@(YES) forFeatureKey:PrivateFeatureKey];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(menuDidChange:)
                                                     name:NSMenuDidChangeItemNotification
                                                   object:nil];
    }
    return self;
}

- (void)menuDidChange:(NSNotification *)notification {
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Editor"];
    NSString *optionalMenuTitle = @"Turn '!' into '?' in @IBOutlets";
    if (menuItem && [menuItem.submenu itemWithTitle:optionalMenuTitle] == nil) {
        [menuItem.submenu addItem:[NSMenuItem separatorItem]];
        NSMenuItem *enableOptionalOutlet = [[NSMenuItem alloc] initWithTitle:optionalMenuTitle action:@selector(toggleOptionalFeature:) keyEquivalent:@""];
        enableOptionalOutlet.target = self;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:OptionalFeatureKey]) {
            enableOptionalOutlet.state = NSOnState;
        }
        [menuItem.submenu addItem:enableOptionalOutlet];

        NSMenuItem *enablePrivateMenu = [[NSMenuItem alloc] initWithTitle:@"Add `private` keyword to @IBOutlets" action:@selector(togglePrivateFeature:) keyEquivalent:@""];
        enablePrivateMenu.target = self;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:PrivateFeatureKey]) {
            enablePrivateMenu.state = NSOnState;
        }
        [menuItem.submenu addItem:enablePrivateMenu];
    }
}

- (void)toggleOptionalFeature:(NSMenuItem *)menuItem {
    BOOL shouldCheck = menuItem.state == NSOnState;
    menuItem.state = shouldCheck ? NSOffState : NSOnState;
    [[NSUserDefaults standardUserDefaults] setBool:!shouldCheck forKey:OptionalFeatureKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)togglePrivateFeature:(NSMenuItem *)menuItem {
    BOOL shouldCheck = menuItem.state == NSOnState;
    menuItem.state = shouldCheck ? NSOffState : NSOnState;
    [[NSUserDefaults standardUserDefaults] setBool:!shouldCheck forKey:PrivateFeatureKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setDefaultValue:(id)value forFeatureKey:(NSString *)featureKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults valueForKey:featureKey] == nil) {
        [userDefaults setValue:value forKey:featureKey];
        [userDefaults synchronize];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
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

    BOOL enabledOptionalFeature = [[NSUserDefaults standardUserDefaults] boolForKey:OptionalFeatureKey];
    BOOL enabledPrivateFeature = [[NSUserDefaults standardUserDefaults] boolForKey:PrivateFeatureKey];

    NSString *optionalOutletString = enabledOptionalFeature ? [string replaceImplicitlyUnwrappedForOptional] : string;
    NSString *privateOutletString = enabledPrivateFeature ? [optionalOutletString addPrivateKeyword] : optionalOutletString;

    return privateOutletString;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
