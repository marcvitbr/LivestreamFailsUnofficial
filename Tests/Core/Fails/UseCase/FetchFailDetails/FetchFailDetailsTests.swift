//
//  FetchFailDetailsTests.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import XCTest

class FetchFailDetailsTests: XCTestCase {
    let failID = FailsFixture.validFailID

    let receiverMock = FailDetailsReceiverMock()

    func testFetchFailDetailsSuccessfully() {
        let fetcherMock = FailsFetcherMock()

        let fetchSummaries = FetchFailDetails(fetcher: fetcherMock,
                                              receiver: self.receiverMock)

        fetchSummaries.execute(with: self.failID)

        XCTAssertEqual(fetcherMock.callsToFetchDetails, 1)

        XCTAssertEqual(self.receiverMock.callsToReceiveFailDetails, 1)
    }

    func testFetchFailDetailsWithException() {
        let fetcherMock = FailsFetcherMockForException()

        let fetchSummaries = FetchFailDetails(fetcher: fetcherMock,
                                              receiver: self.receiverMock)

        fetchSummaries.execute(with: self.failID)

        XCTAssertEqual(fetcherMock.callsToFetchDetails, 1)

        XCTAssertEqual(self.receiverMock.callsToHandleErrorFetchingFailDetails, 1)
    }
}
