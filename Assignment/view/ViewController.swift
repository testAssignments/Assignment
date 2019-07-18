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
    var labelheight:CGFloat = 0.0
    /// Table of Content
    lazy var tableView :UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.lightGray
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(dataCell.self, forCellReuseIdentifier: dataCell.dataCelIdentifier)
        return tableView
        }()
    /// View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupNavigationBar()
        setlayouts()
        // Do any additional setup after loading the view, typically from a nib.
    }
    /// Setting up Views
    func setupview(){
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
    }
    /// Setting up Navigation bar
    func setupNavigationBar(){
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshView))
        navigationItem.rightBarButtonItem = refreshButton
        self.navigationItem.title = "testTitle"
    }
    /// Setting up constraints here
    func setlayouts(){
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
        tableView.reloadData()
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    /// Datasource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataCell = tableView.dequeueReusableCell(withIdentifier: dataCell.dataCelIdentifier,
                                                       for: indexPath) as? dataCell else {
                                                        return UITableViewCell()
        }
        let text = "kjsdbfajhsdbfkjasbdfksaljbdfa sdfkjbasdkfjbasdkjfbaslkdjbfasd fasdfbalksjdbfkasjbdf sdkjabsdkfjb askdjfblkjsadb "
        let rowWidth = UIScreen.main.bounds.size.width - tableView.estimatedRowHeight
        labelheight = dataCell.subTitle.height(fromtext: " \(text) ",
            font: dataCell.subTitle.font, width: rowWidth)
        dataCell.subTitle.text = text
        return dataCell
    }
    /// Delegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if labelheight < tableView.estimatedRowHeight {
            return tableView.estimatedRowHeight
        }else{
            return labelheight
        }
    }
    /// Handling selctions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

