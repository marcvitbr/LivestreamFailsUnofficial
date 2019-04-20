//
//  StreamerFetcher.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

protocol StreamerFetcher {
    func fetchStreamerDetails(name: String) throws -> Streamer
}
