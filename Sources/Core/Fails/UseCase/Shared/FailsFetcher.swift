//
//  FailsFetcher.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

protocol FailsFetcher {
    func fetchSummaries(with query: FailsQuery) throws -> [FailSummary]

    func fetchDetails(failID: String) throws -> FailDetails
}
