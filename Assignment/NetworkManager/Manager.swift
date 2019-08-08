//
//  Manager.swift
//  Assignment
//
//  Created by test on 18/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import Alamofire

class ServiceManager {
    /// Use of Alamofire for API calls
    static func callAlamofireDataAPI(completionHandler: @escaping (ApiData?, _ error: Error?) -> Void) {
        Alamofire.request(Constant.url) .validate().responseString { (response) in
            if response.result.isSuccess {
                guard let data = response.value?.data(using: .utf8) else { return }
                do {
                    // JSON data parsing using Codable protocol
                    
                    let decoder = JSONDecoder()
                    let viewData = try decoder.decode(ApiData.self, from: data)
                    completionHandler(viewData, nil)
                } catch let err {
                    completionHandler(nil, err)
                }
            } else {
                completionHandler(nil, response.error)
            }
        }
    }
}
