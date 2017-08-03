//
//  SwiftAutoCoder.swift
//  SwiftAutoCoder
//
//  Created by Michael Henry Pantaleon on 2017/08/03.
//  Copyright © 2017 iamkel.net. All rights reserved.
//


extension NSObject {
    
    fileprivate var properties: [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }
    
    public func autoDecode(_ aDecoder: NSCoder) {
        properties.forEach { (keypath) in
            let keyValue = aDecoder.decodeObject(forKey: keypath)
            setValue(keyValue, forKey: keypath)
        }
    }
    
    public func autoEncode(with aCoder: NSCoder) {
        properties.forEach { (keypath) in
            let keyvalue = value(forKey: keypath)
            aCoder.encode(keyvalue, forKey: keypath)
        }
    }
}
