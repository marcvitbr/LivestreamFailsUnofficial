//
//  StreamerFetcherMockForException.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class StreamerFetcherMockForException: StreamerFetcherMock {
    override func fetchStreamerDetails(name: String) throws -> Streamer {
        _ = try! super.fetchStreamerDetails(name: name)
        throw StreamerFetcherError.errorFetchingStreamerDetails
    }
}
