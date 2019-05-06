//
//  StreamerFetcherMock.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

class StreamerFetcherMock: StreamerFetcher {
    var callsToFetchStreamerDetails = 0

    func fetchStreamerDetails(name: String) throws -> Streamer {
        self.callsToFetchStreamerDetails += 1
        return StreamerFixture.validStreamer
    }

    func fetchStreamers() throws -> [Streamer] {
        return []
    }
}
