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
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.register(DataCollectionCell.self,
                                forCellWithReuseIdentifier: DataCollectionCell.dataCelIdentifier)
        DataViewModel.dataVM.refreshTableData { (done) in
            if done {
                DispatchQueue.main.sync {
                    // Set the DynamicCollectionLayout delegate
                    if let layout = self.collectionView?.collectionViewLayout as? DynamicCollectionLayout {
                        layout.delegate = self
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
    func height(fromtext: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel()
        label.frame.size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = fromtext
        label.sizeToFit()
        return label.frame.height
    }
}
extension CollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if DataViewModel.dataVM.tableArray.count > 0 {
            return DataViewModel.dataVM.tableArray.count
        } else {
            return 0
        }
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataCollectionCell.dataCelIdentifier,
                                                           for: indexPath) as? DataCollectionCell else {
                                                            return UICollectionViewCell()
        }
        cell.setUpCell(with: DataViewModel.dataVM.tableArray[indexPath.row])
        return cell
    }
}
extension CollectionViewController: DynamicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForSubtitleAtIndexPath indexPath: IndexPath) -> CGFloat {
        let description = DataViewModel.dataVM.tableArray[indexPath.row].description
        let heightofLabel = height(fromtext: " \(String(describing: description)) ",
            font: UIFont.systemFont(ofSize: 14), width: collectionView.frame.size.width/2)
        return heightofLabel
    }
}
