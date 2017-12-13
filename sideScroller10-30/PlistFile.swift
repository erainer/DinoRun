//
//  PlistFile.swift
//  PlistTest
//
//  Created by Cynthia Grieb on 10/9/17.
//  Copyright © 2017 Cynthia Grieb. All rights reserved.
//
// ** Usage: ***********************************************************************************
// Create a PlistFile structure for file named data.plist
//     let someCollection = PlistFile(name: "data")
//
// Load the data from the file into an array of optional type [Any]?
//     let someArray = someCollection.array
//
// Load the data from the file into an array and cast it as type [[String: String]]?
//     let someArray = someCollection.array as? [[String: String]]
//
// Load the data from the file into a dictionary of optional type [String: Any]?
//     let someArray = someCollection.dictionary
//
// Load the data from the file into a dictionary and cast it as optional type [String: String]?
//     let someArray = someCollection.dictionary as? [String: String]
// *********************************************************************************************

import Foundation

struct PlistFile {
    // stored property with property observer
    var name: String {
        didSet {
            self.name = removeExt(oldValue)
        }
    }
    // computed properties
    var dictionary: [String: Any]? {
        get {
            return getDictionary()
        }
    }
    var array: [Any]? {
        get {
            return getArray()
        }
    }
    private var path: URL? {
        get {
            return Bundle.main.url(forResource: self.name, withExtension: "plist")
        }
    }
    // this function returns the string removing the suffix .plist, if found
    private func removeExt(_ str: String) -> String {
        if str.hasSuffix(".plist") {
            let index = str.index(str.endIndex, offsetBy: -6)
            // name = newValue.substring(to: self.name.index(self.name.endIndex, offsetBy: -6))
            return String(str[..<index])
        } else {
            return str
        }
    }
    // attempts to return the data from the plist as a dictionary
    private func getDictionary() -> [String: Any]? {
        if let result = try? Data(contentsOf: self.path!) {
            return try! PropertyListSerialization.propertyList(from: result, options: [], format: nil) as? [String: Any]
        } else {
            return nil
        }
    }
    // attempts to return the data from the plist as an array
    private func getArray() -> [Any]? {
        if let result = try? Data(contentsOf: self.path!) {
            return try! PropertyListSerialization.propertyList(from: result, options: [], format: nil) as? [Any]
        } else {
            return nil
        }
    }
    
    init(name fname: String) {
        self.name = fname               // have to initialize the name first
        self.name = removeExt(fname)    // before we can change the value
    }
}
