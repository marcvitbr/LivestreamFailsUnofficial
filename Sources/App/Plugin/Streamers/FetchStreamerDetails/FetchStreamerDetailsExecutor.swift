//
//  FetchStreamerDetailsExecutor.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 02/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

protocol FetchStreamerDetailsExecutor: AnyObject {
    func executeFetchStreamerDetails(_ name: String) throws -> Streamer
}
