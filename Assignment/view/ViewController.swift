//
//  ViewController.swift
//  Assignment
//
//  Created by test on 17/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// Dynamic label height
    var labelheight: CGFloat = 0.0
    /// Shared instance
    /// Table of Content
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.lightGray
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.register(DataCell.self, forCellReuseIdentifier: DataCell.dataCelIdentifier)
        return tableView
        }()
    /// View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupNavigationBar()
        setLayouts()
        DataViewModel.dataVM.refreshTableData { (done) in
            if done {
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                    self.navigationItem.title = DataViewModel.dataVM.viewTitle
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    /// Setting up Views
    func setupview() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
    }
    /// Setting up Navigation bar
    func setupNavigationBar() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshView))
        navigationItem.rightBarButtonItem = refreshButton
    }
    /// Setting up constraints here
    func setLayouts() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    /// View refresh method
    @objc func refreshView() {
        print("refresh tableview..")
        DataViewModel.dataVM.refreshTableData { (done) in
            if done {
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
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
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    /// Datasource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataViewModel.dataVM.tableArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataCell = tableView.dequeueReusableCell(withIdentifier: DataCell.dataCelIdentifier,
                                                       for: indexPath) as? DataCell else {
                                                        return UITableViewCell()
        }
        dataCell.title.text = ""
        dataCell.subTitle.text = ""
        let rowdata = DataViewModel.dataVM.tableArray[indexPath.row]
        /// check for nil values
        if rowdata.title != nil || rowdata.description != nil || rowdata.imageHref != nil {
            if let title = rowdata.title {
                dataCell.title.text = title
            }
            if let description = rowdata.description {
                dataCell.subTitle.text = description
            }
            if let imageurl = rowdata.imageHref {
                dataCell.imgView.downloadImageFrom(link: imageurl)
            } else {
                dataCell.imgView.image = #imageLiteral(resourceName: "Imageplaceholder")
            }
        }
        return dataCell
    }
    /// Delegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let description = DataViewModel.dataVM.tableArray[indexPath.row].description
        let heightofLabel = height(fromtext: " \(String(describing: description)) ",
            font: UIFont.systemFont(ofSize: 14), width: tableView.frame.width)
        return heightofLabel + 70
    }
}
