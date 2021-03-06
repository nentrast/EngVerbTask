//
//  ViewController.swift
//  EngVerbsTask
//
//  Created by Alexandr Lobanov on 7/22/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

//MARK outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
//MARK vars
    let arr = Parser.fillModell()
    var datasource:ColletionViewDataSource?    

//MARl lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = ColletionViewDataSource(withColectionView: self.collectionView, searchBar: self.searchBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.collectionView.reloadData()
    }
}
