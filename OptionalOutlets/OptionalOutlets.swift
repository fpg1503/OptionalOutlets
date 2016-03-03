//
//  OptionalOutlets.swift
//
//  Created by Francesco Perrotti-Garcia on 3/3/16.
//  Copyright © 2016 Francesco Perrotti-Garcia. All rights reserved.
//

import AppKit

var sharedPlugin: OptionalOutlets?

class OptionalOutlets: NSObject {

    var bundle: NSBundle
    lazy var center = NSNotificationCenter.defaultCenter()

    init(bundle: NSBundle) {
        self.bundle = bundle

        super.init()
        center.addObserver(self, selector: Selector("didApplicationFinishLaunchingNotification:"), name: NSApplicationDidFinishLaunchingNotification, object: nil)
    }

    deinit {
        removeObserver()
    }

    func removeObserver() {
        center.removeObserver(self)
    }
    
    func didApplicationFinishLaunchingNotification(notification: NSNotification) {
        center.removeObserver(self, name: NSApplicationDidFinishLaunchingNotification, object: nil)
        
        center.addObserver(self, selector: Selector("editorDocumentDidChange:"), name: "IDEEditorDocumentDidChangeNotification", object: nil)
        
    }
    
    func editorDocumentDidChange(notification: NSNotification) {
        guard let firstChange = notification.userInfo?["IDEEditorDocumentChangeLocationsKey"]?.firstObject else {
            return
        }
        
        guard firstChange?.respondsToSelector(Selector("documentURL")) ?? false,
            let url = firstChange?.valueForKey("documentURL") as? NSURL else {
            return
        }
        
        guard firstChange?.respondsToSelector(Selector("characterRange")) ?? false,
            let range = firstChange?.valueForKey("characterRange") as? NSRange else {
            return
        }
        
        guard range.length > 0 && range.location != NSNotFound else {
            return
        }
        
        guard notification.object?.respondsToSelector(Selector("textStorage")) ?? false,
            let textStorage = notification.object?.valueForKey("textStorage") else {
            return
        }
        
        let attributedSubstringFromRange = Selector("attributedSubstringFromRange:")
        guard textStorage.respondsToSelector(attributedSubstringFromRange) else {
            return
        }
        
        print(textStorage.safelyPerformSelector(attributedSubstringFromRange, withObject: NSRange(location: 0, length: 10)))
        guard let attributed = textStorage.safelyPerformSelector(attributedSubstringFromRange, withObject: range) as? NSAttributedString else {
            return
        }
        
        
        
        let substring = attributed.string
        
        print(substring)
        
        

//    [mapping enumerateKeysAndObjectsUsingBlock:^(NSString *prefix, NSString *replacement, BOOL * _Nonnull stop) {
//    if ([substring hasPrefix:prefix]) {
//    NSString *updatedSubstring = [substring stringByReplacingOccurrencesOfString:prefix withString:replacement];
//    
//    [textStorage beginEditing];
//    [textStorage replaceCharactersInRange:range withString:updatedSubstring withUndoManager:nil];
//    [textStorage endEditing];
//    }
//    }];
//    }
    }
    

}

