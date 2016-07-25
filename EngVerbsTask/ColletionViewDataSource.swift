//
//  ColletionViewDataSource.swift
//  EngVerbsTask
//
//  Created by Alexandr Lobanov on 7/21/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

class ColletionViewDataSource:NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var collectionView:UICollectionView?
    var searchBar:UISearchBar?
    let cellID = "cellVerb"
    let device = UIDevice.currentDevice().model
    
    var gestureDelete = UILongPressGestureRecognizer()
    var activeSearchBar = false
    
    var arrayOfVerbs = Parser.fillModell()
    var searchedVerbs = [Verb]()

    
    init(withColectionView collectionView:UICollectionView, searchBar:UISearchBar) {
        super.init()
        self.collectionView = collectionView
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.searchBar = searchBar
        self.searchBar?.delegate = self
        self.initDeleteGesture()

    }
    
    //MARL: long press gesture
    func initDeleteGesture() {
        self.gestureDelete = UILongPressGestureRecognizer(target: self, action: #selector(handleLongpressDelete))
        self.gestureDelete.minimumPressDuration = 1
        self.collectionView?.addGestureRecognizer(gestureDelete)
    }
    

    
    func handleLongpressDelete(gesture: UILongPressGestureRecognizer) {
        if gesture.state != UIGestureRecognizerState.Ended  {
            return
        }
        
        let point = gesture.locationInView(self.collectionView)
        if let indexPath = self.collectionView?.indexPathForItemAtPoint(point) {
            self.collectionView?.performBatchUpdates({ 
                    self.deleteItemAtINdexPath(indexPath)
                    self.collectionView?.deleteItemsAtIndexPaths([indexPath])
                    self.collectionView?.reloadData()
                }, completion: nil)
        }
    }
    
    //MARK: Collection view data source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.activeSearchBar {
            return self.searchedVerbs.count
        }
        return self.arrayOfVerbs.count
    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellID, forIndexPath: indexPath) as? VerbCollectionViewCell

        if activeSearchBar {
            cell?.fillWithParams(self.searchedVerbs[indexPath.row])
        } else {
             cell?.fillWithParams(arrayOfVerbs[indexPath.row])
        }
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as? VerbCollectionViewCell
        cell?.verb?.verb
        cell?.showParticiples()
        print("selected item \(cell?.verb?.verb)")
    }
    
    func deleteItemAtINdexPath(indexPath:NSIndexPath) {
        if activeSearchBar {
           self.removeItem(self.searchedVerbs[indexPath.row])
            self.searchedVerbs.removeAtIndex(indexPath.row)
        } else {
            self.arrayOfVerbs.removeAtIndex(indexPath.row)
        }
    }
    
    func removeItem(object:Verb) {
        var temp = 0
        for item in self.arrayOfVerbs {
            if object.verb == item.verb {
                self.arrayOfVerbs.removeAtIndex(temp)
            }
            temp += 1
        }
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let temp = self.arrayOfVerbs.removeAtIndex(sourceIndexPath.item)
        self.arrayOfVerbs.insert(temp, atIndex: destinationIndexPath.item)
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var cellSize = CGSizeMake(0.0, 0.0)
        switch self.device {
        case "iPad":
            cellSize = CGSizeMake(collectionView.bounds.size.width/4 - 10, collectionView.bounds.size.height/4 - 10)
            
            break
        case "iPhone":
            cellSize = CGSizeMake(collectionView.bounds.size.width/2 - 10, collectionView.bounds.size.height/4 - 10)
            break
        default:
            print("Other device")
        }
        return cellSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    //MARK search bar
    func filteConten(searchedName: String) {
          print(searchedName)
        self.searchedVerbs = self.arrayOfVerbs.filter({ (text:Verb ) -> Bool in
            return text.verb!.containsString(searchedName)
        })

    }
       
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.text = searchText.lowercaseString
        if searchText.characters.count > 0 {
        self.activeSearchBar = true
        self.filteConten(searchText.lowercaseString)
            self.collectionView?.reloadData()
        }
        else {
            self.activeSearchBar = false
            self.collectionView?.reloadData()
        }
    }
}
