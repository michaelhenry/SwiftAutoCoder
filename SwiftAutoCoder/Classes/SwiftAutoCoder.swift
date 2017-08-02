//
//  SwiftAutoCoder.swift
//  SwiftAutoCoder
//
//  Created by Michael Henry Pantaleon on 2017/08/03.
//  Copyright © 2017 iamkel.net. All rights reserved.
//

protocol SwiftAutoCoder {
    
    func decodeX(_ aDecoder: NSCoder)
    func encodeX(_ aCoder: NSCoder)
}

extension SwiftAutoCoder where Self:NSObject {
    
    var properties: [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }
    
    func decodeX(_ aDecoder: NSCoder) {
        properties.forEach { (keypath) in
            let keyValue = aDecoder.decodeObject(forKey: keypath)
            setValue(keyValue, forKey: keypath)
        }
    }
    
    func encodeX(_ aCoder: NSCoder) {
        properties.forEach { (keypath) in
            let keyvalue = value(forKey: keypath)
            aCoder.encode(keyvalue, forKey: keypath)
        }
    }
    
}
