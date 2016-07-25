//
//  Verb.swift
//  EngVerbsTask
//
//  Created by Alexandr Lobanov on 7/21/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

class Verb: NSObject {
    
    //MARK: vars
    var verb: String?
    var past:String?
    var participles:[String]?
    var frequency: String?
    var imageFront:UIImage?
    var imageBack:UIImage?
    
    //MARK: init
    init(withDictionary dictionary:NSDictionary, verb:String) {
        self.verb = verb
        if let past = dictionary["past"] as? String {
            self.past = past
        }
        if let participles = dictionary["participles"] as? [String] {
            self.participles = participles
        }
        if let frequency = dictionary["frequency"] as? String {
            self.frequency = frequency
        }
    }
    
    

}
