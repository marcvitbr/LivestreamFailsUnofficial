//
//  FailsFetcherMock.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

class FailsFetcherMock: FailsFetcher {
    var callsToFetchSummaries = 0

    var callsToFetchDetails = 0

    func fetchSummaries(with query: FailsQuery) throws -> [FailSummary] {
        self.callsToFetchSummaries += 1
        return []
    }

    func fetchDetails(failID: String) throws -> FailDetails {
        self.callsToFetchDetails += 1
        return FailsFixture.validFailDetails
    }
}
