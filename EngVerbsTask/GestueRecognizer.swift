//
//  GestueRecognizer.swift
//  EngVerbsTask
//
//  Created by Alexandr Lobanov on 7/24/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

class GestueRecognizer {
    class func handleLongPress(gesture: UILongPressGestureRecognizer, collectionView: UICollectionView, inout arrayOfItems: [Verb]) {
        if gesture.state != .Ended {
            return
        }
        let  p = gesture.locationInView(collectionView)
        
        if let indexPath = collectionView.indexPathForItemAtPoint(p)  {
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
            
            arrayOfItems.removeAtIndex(indexPath.row)
            
        } else {
             print("There are no cell here")

        }
    }
    
}
