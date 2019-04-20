//
//  FailsFetcherMockForException.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class FailsFetcherMockForException: FailsFetcherMock {
    override func fetchSummaries(with query: FailsQuery) throws -> [FailSummary] {
        let _ = try! super.fetchSummaries(with: query)
        throw FailsFetcherError.errorFetchingFailsSummaries
    }

    override func fetchDetails(failID: String) throws -> FailDetails {
        let _ = try! super.fetchDetails(failID: failID)
        throw FailsFetcherError.errorFetchingFailDetails
    }
}
