//
//  FetchStreamersExecutor.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 09/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation

protocol FetchStreamersExecutor: AnyObject {
    func executeFetchStreamers() throws -> [Streamer]
}
