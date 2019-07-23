//
//  CollectionViewController.swift
//  Assignment
//
//  Created by test on 23/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        // Set the DynamicCollectionLayout delegate
        if let layout = collectionView?.collectionViewLayout as? DynamicCollectionLayout {
            layout.delegate = self as? DynamicLayoutDelegate
        }
    }
}
