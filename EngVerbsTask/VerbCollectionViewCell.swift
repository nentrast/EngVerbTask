//
//  VerbCollectionViewCell.swift
//  EngVerbsTask
//
//  Created by Alexandr Lobanov on 7/22/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

class VerbCollectionViewCell: UICollectionViewCell {

    enum CellColor:String {
        case Black = "000000", Blue = "0075f2"
    }

//MARK: vars
    @IBOutlet weak var imageVerb: UIImageView!
    var verb: Verb?
    private var width:Int = 0
    private  var height:Int = 0
    private var timer:NSTimer!
//MARK: fiil model with data
    func fillWithParams(verb: Verb)  {
        self.verb = verb
        self.width = Int(self.bounds.size.height)
        self.height = Int(self.bounds.size.width)
        self.showVerb()
    }
    
//MARK: show word image 
    func showVerb() {
        self.showImageWithParams(.Black, words: [(self.verb?.verb)!])
        self.showWithAnimation()
    }

    func showParticiples() {
        self.showImageWithParams(.Blue, words: (self.verb?.participles)!)
        self.showWithAnimation()
        self.timer =  NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(self.showVerb), userInfo: nil, repeats: false)
    }
    
    private func showWithAnimation() {
        self.alpha = 0.0
        UIView.animateWithDuration(1.0) {
            self.alpha = 1.0
        }
    }
    
    private func showImageWithParams(color:CellColor, words:[String]) {
        let word = words.joinWithSeparator(",")
        ImageLoader.downloadThumbImage("http://dummyimage.com/\(self.width)x\(self.height)/\(color.rawValue)/ffffff.png&text=\(word)", imageView: self.imageVerb)
    }
    

    
}
