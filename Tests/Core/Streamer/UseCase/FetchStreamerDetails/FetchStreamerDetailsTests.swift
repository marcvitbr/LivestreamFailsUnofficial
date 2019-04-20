//
//  FetchStreamerDetailsTests.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import XCTest

class FetchStreamerDetailsTests: XCTestCase {
    let streamerName = "TheStreamer"

    let receiverMock = StreamerDetailsReceiverMock()

    func testFetchStreamerDetailsSuccessfully() {
        let fetcherMock = StreamerFetcherMock()

        let fetchStreamer = FetchStreamerDetails(fetcher: fetcherMock,
                                              receiver: self.receiverMock)

        fetchStreamer.execute(with: self.streamerName)

        XCTAssertEqual(fetcherMock.callsToFetchStreamerDetails, 1)

        XCTAssertEqual(self.receiverMock.callsToReceiveStreamerDetails, 1)
    }

    func testFetchFailDetailsWithException() {
        let fetcherMock = StreamerFetcherMockForException()

        let fetchStreamer = FetchStreamerDetails(fetcher: fetcherMock,
                                              receiver: self.receiverMock)

        fetchStreamer.execute(with: self.streamerName)

        XCTAssertEqual(fetcherMock.callsToFetchStreamerDetails, 1)

        XCTAssertEqual(self.receiverMock.callsToHandleErrorFetchingStreamerDetails, 1)
    }
}
