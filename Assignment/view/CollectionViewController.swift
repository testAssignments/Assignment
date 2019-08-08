//
//  CollectionViewController.swift
//  Assignment
//
//  Created by test on 23/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    var collectionView: UICollectionView!
    var spacingValue: CGFloat = 5
    /// layout veriable
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        if UIDevice.current.userInterfaceIdiom == .pad {
            layout.estimatedItemSize = CGSize(width: Constant.ipadWidth, height: Constant.estimatedHeight)
        } else {
            layout.estimatedItemSize = CGSize(width: Constant.iphoneWidth, height: Constant.estimatedHeight)
        }
        
        return layout
    }()
    /// View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setUpNavigationBar()
        DataViewModel.dataVM.refreshTableData { (done) in
            if done {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    /// Setting up the collectionview
    func setupCollectionView(){
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.layer.masksToBounds = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.register(DataCollectionCell.self,
                                forCellWithReuseIdentifier: DataCollectionCell.dataCelIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: spacingValue).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: -spacingValue).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    // Setting up Navigation bar
    func setUpNavigationBar() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCollectionView))
        navigationItem.rightBarButtonItem = refreshButton
    }
    /// Refresh button Action
    @objc func refreshCollectionView() {
        DataViewModel.dataVM.refreshTableData { (done) in
            if done {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.navigationItem.title = DataViewModel.dataVM.viewTitle
                    self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                      at: .top,
                                                      animated: true)
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Error while fetching data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
extension CollectionViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if DataViewModel.dataVM.tableArray.count > 0 {
            return DataViewModel.dataVM.tableArray.count
        } else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataCollectionCell.dataCelIdentifier,
                                                           for: indexPath) as? DataCollectionCell else {
                                                            return UICollectionViewCell()
        }
        cell.setUpCell(with: DataViewModel.dataVM.tableArray[indexPath.row])
        return cell
    }
}
