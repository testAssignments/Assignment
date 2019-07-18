//
//  Manager.swift
//  Assignment
//
//  Created by test on 18/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

class ServiceManager {
    static func callDataAPI(completionHandler: @escaping (ApiData?, _ error: Error?) -> Void) {
        guard let url = URL(string: DataViewModel().getURLFromPlist())
            else { return }
        URLSession.shared.dataTask(with: url) { (data, _ response, _ error) in
            guard let data1 = data else { return }
            guard let dataString = String(bytes: data1, encoding: String.Encoding.isoLatin1) else { return }
            do {
                //JSON data parsing using Codable protocol
                let decoder = JSONDecoder()
                guard let dataVal = dataString.data(using: .utf8) else { return } // to avoid forced unwrapping
                let viewData = try decoder.decode(ApiData.self, from: dataVal)
                guard viewData.rows != nil else { return } // to avoid forced unwrapping
                completionHandler(viewData, nil)
            } catch let err {
                completionHandler(nil, err)
            }
        }.resume()
    }
}
