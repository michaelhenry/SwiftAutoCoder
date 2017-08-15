//
//  SwiftAutoCoder.swift
//  SwiftAutoCoder
//
//  Created by Michael Henry Pantaleon on 2017/08/03.
//  Copyright © 2017 iamkel.net. All rights reserved.
//



public protocol KeyValueSetterGetter {
    func setValue(_ value: Any?, forKey key: String)
    func value(forKey key: String) -> Any?
}

public extension KeyValueSetterGetter where Self:NSCoding {
    
    fileprivate func encodable(_ value:Any) -> Bool {
        switch value {
        case is ExpressibleByBooleanLiteral,
             is ExpressibleByIntegerLiteral,
             is ExpressibleByFloatLiteral,
             is ExpressibleByUnicodeScalarLiteral,
             is ExpressibleByExtendedGraphemeClusterLiteral,
             is ExpressibleByArrayLiteral,
             is ExpressibleByDictionaryLiteral,
             is ExpressibleByStringLiteral:
            
            return true
        default:
            print(value)
            return false
        }
    }
    
    fileprivate var properties: [String] {
        return Mirror(reflecting: self)
            .children
            .filter { encodable($0.value) }
            .flatMap { $0.label }
    }
    
    public func autoDecode(_ aDecoder: NSCoder) {
        properties.forEach { (keypath) in
            if let keyValue = aDecoder.decodeObject(forKey: keypath) {
                setValue(keyValue, forKey: keypath)
            }
        }
    }
    
    public func autoEncode(with aCoder: NSCoder) {
        properties.forEach { (keypath) in
            if let keyValue = value(forKey: keypath) {
                aCoder.encode(keyValue, forKey: keypath)
            }
        }
    }
}

extension NSObject:KeyValueSetterGetter {}

