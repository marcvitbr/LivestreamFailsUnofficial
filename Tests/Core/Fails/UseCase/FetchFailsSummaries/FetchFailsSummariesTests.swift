//
//  FetchFailsTests.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import XCTest

class FetchFailsSummariesTests: XCTestCase {
    let query = FailsFixture.validQuery

    let receiverMock = FailsSummariesReceiverMock()

    func testFetchFailsSummariesSuccessfully() {
        let fetcherMock = FailsFetcherMock()

        let fetchSummaries = FetchFailsSummaries(fetcher: fetcherMock,
                                                 receiver: self.receiverMock)

        fetchSummaries.execute(with: self.query)

        XCTAssertEqual(fetcherMock.callsToFetchSummaries, 1)

        XCTAssertEqual(self.receiverMock.callsToReceiveFailsSummaries, 1)
    }

    func testFetchFailsSummariesWithException() {
        let fetcherMock = FailsFetcherMockForException()

        let fetchSummaries = FetchFailsSummaries(fetcher: fetcherMock,
                                                 receiver: self.receiverMock)

        fetchSummaries.execute(with: self.query)

        XCTAssertEqual(fetcherMock.callsToFetchSummaries, 1)

        XCTAssertEqual(self.receiverMock.callsToHandleErrorFetchingFailsSummaries, 1)
    }
}
