//
//  dataModel.swift
//  Assignment
//
//  Created by test on 17/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
struct DataDict: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}

struct ApiData: Codable {
    var title: String?
    var rows: [DataDict]?
}
