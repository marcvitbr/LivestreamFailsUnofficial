//
//  FetchFailsSummaries.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class FetchFailsSummaries: ParameterizedUseCase {
    typealias Parameters = FailsQuery

    private let fetcher: FailsFetcher

    private let receiver: FailsSummariesReceiver

    init(fetcher: FailsFetcher, receiver: FailsSummariesReceiver) {
        self.fetcher = fetcher
        self.receiver = receiver
    }

    func execute(with parameters: FailsQuery) {
        do {
            let fails = try self.fetcher.fetchSummaries(with: parameters)

            self.receiver.receiveFailsSummaries(fails)
        } catch {
            self.receiver.handleErrorFetchingFailsSummaries()
        }
    }
}
