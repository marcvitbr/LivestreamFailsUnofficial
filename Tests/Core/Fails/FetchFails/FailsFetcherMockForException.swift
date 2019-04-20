//
//  FailsFetcherMockForException.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class FailsFetcherMockForException: FailsFetcherMock {
    override func fetch(with query: FailsQuery) throws -> [Fail] {
        _ = try! super.fetch(with: query)

        throw FailsFetcherError.errorFetchingFails
    }
}
