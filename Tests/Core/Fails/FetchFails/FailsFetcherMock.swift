//
//  FailsFetcherMock.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

class FailsFetcherMock: FailsFetcher {
    var callsToFetch = 0

    func fetch(with query: FailsQuery) throws -> [Fail] {
        self.callsToFetch += 1
        return []
    }
}
