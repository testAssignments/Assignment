//
//  dataModel.swift
//  Assignment
//
//  Created by test on 17/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
struct data: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}

struct TableData: Codable {
    var title: String?
    var rows: [data]?
}
