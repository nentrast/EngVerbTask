//
//  Parser.swift
//  EngVerbsTask
//
//  Created by Alexandr Lobanov on 7/21/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

class Parser: NSObject {
    class func fillModell() -> [Verb] {
        var array = [Verb]()
        let path = NSBundle.mainBundle().pathForResource("index", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:[String:AnyObject]]
            for object in json! {
                let verb = Verb(withDictionary: object.1, verb: object.0)
                array.append(verb)
            }
        } catch {
            print("Error serialization")
        }
        return array
    }
}
