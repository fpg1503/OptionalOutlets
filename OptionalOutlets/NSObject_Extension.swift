//
//  NSObject_Extension.swift
//
//  Created by Francesco Perrotti-Garcia on 3/3/16.
//  Copyright © 2016 Francesco Perrotti-Garcia. All rights reserved.
//

import Foundation

extension NSObject {
    class func pluginDidLoad(bundle: NSBundle) {
        let appName = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? NSString
        if appName == "Xcode" {
        	if sharedPlugin == nil {
        		sharedPlugin = OptionalOutlets(bundle: bundle)
        	}
        }
    }
}