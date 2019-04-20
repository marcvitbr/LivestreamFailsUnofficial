//
//  FailsFixture.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation

final class FailsFixture {
    static let validFailID = FailID(value: "5cbc522252387")

    static let validFailDetails = FailDetails(failID: FailsFixture.validFailID,
                                              videoURL: URL(string: "https://stream.livestreamfails.com/video/5cbc522252387.mp4")!)

    static let validQuery = FailsQuery(page: 0,
                                       mode: .standard,
                                       order: .hot,
                                       timeFrame: .all,
                                       nSFW: false)
}
