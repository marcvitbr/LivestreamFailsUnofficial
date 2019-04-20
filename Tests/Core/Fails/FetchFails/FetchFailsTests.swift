//
//  FetchFailsTests.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import XCTest

class FetchFailsTests: XCTestCase {
    let query = FailsQuery(page: 0,
                           mode: .standard,
                           order: .hot,
                           timeFrame: .all,
                           nSFW: false)

    let receiverMock = FailsReceiverMock()

    func testFetchFailsSuccessfully() {
        let fetcherMock = FailsFetcherMock()

        let fetchFails = FetchFails(fetcher: fetcherMock,
                                    receiver: self.receiverMock)

        fetchFails.execute(with: self.query)

        XCTAssertEqual(fetcherMock.callsToFetch, 1)

        XCTAssertEqual(self.receiverMock.callsToReceiveFails, 1)
    }

    func testFetchFailsWithException() {
        let fetcherMock = FailsFetcherMockForException()

        let fetchFails = FetchFails(fetcher: fetcherMock,
                                    receiver: self.receiverMock)

        fetchFails.execute(with: self.query)

        XCTAssertEqual(fetcherMock.callsToFetch, 1)

        XCTAssertEqual(self.receiverMock.callsToHandleErrorFetchingFails, 1)
    }
}
