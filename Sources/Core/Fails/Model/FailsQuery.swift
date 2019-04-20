//
//  FailsQuery.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation

struct FailsQuery {
    var page: Int
    var mode: FailsMode
    var order: FailsOrder
    var timeFrame: FailsTimeFrame
    var nSFW: Bool
}

enum FailsMode: String {
    case standard = "standard"
}

enum FailsTimeFrame: String {
    case all = "all"
}

enum FailsOrder: String {
    case hot = "hot"
}
