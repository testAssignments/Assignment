//
//  DataViewModel.swift
//  Assignment
//
//  Created by test on 18/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class DataViewModel {
    /// Shared instance
    static let dataVM = DataViewModel()
    /// Reqired data for the table
    var tableArray = [DataDict]()
    var viewTitle: String?
    /// Api call to refesh the table
    func refreshTableData(callCompleted: @escaping (Bool) -> Void) {
        ServiceManager.callDataAPI { (data, error) in
            if error == nil {
                guard let apiData = data else {
                    return
                }
                if let title = apiData.title {
                    self.viewTitle = title
                    guard let viewRows = apiData.rows else { return }
                    /// Check for nil values inside the array
                    let array = viewRows.filter({ $0.title != nil || $0.description != nil || $0.imageHref != nil })
                    DataViewModel.dataVM.tableArray = array
                    callCompleted(true)
                }
            }
        }
    }
    /// helper method
    func getURLFromPlist() -> String {
        var urlString = ""
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            ////If your plist contain root as Dictionary
            if let dic = NSDictionary(contentsOfFile: path) as? [String: Any], let urlStr = dic["DataURL"] as? String {
                urlString = urlStr
            } else {
                return urlString
            }
        }
        return urlString
    }
}
