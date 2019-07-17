//
//  ViewController.swift
//  Assignment
//
//  Created by test on 17/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var tableView :UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
        }()
    
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    @objc func refreshView() {
        print("refresh tableview..")
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}

