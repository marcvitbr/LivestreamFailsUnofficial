//
//  DefaultFetchFailsSummariesExecutor.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation

final class DefaultFetchFailsSummariesExecutor: FetchFailsSummariesExecutor, FailsSummariesReceiver {
    private lazy var semaphore = DispatchSemaphore(value: 0)

    private lazy var remoteFetcher = RemoteFailsFetcher()

    private var isSuccess = false

    private var retrievedSummaries: [FailSummary]?

    func executeFetchFailsSummaries(page: Int) -> [FailSummary] {
        let fetchSummaries = FetchFailsSummaries(fetcher: self.remoteFetcher,
                                                 receiver: self)

        let query = FailsQuery(page: page,
                               mode: .standard,
                               order: .new,
                               timeFrame: .all,
                               nSFW: false)

        fetchSummaries.execute(with: query)

        self.semaphore.wait()

        guard self.isSuccess, let summaries = self.retrievedSummaries else {
            return []
        }

        return summaries
    }

    func receiveFailsSummaries(_ fails: [FailSummary]) {
        self.retrievedSummaries = fails
        self.resumeExecution(success: true)
    }

    func handleErrorFetchingFailsSummaries() {
        self.resumeExecution(success: false)
    }

    private func resumeExecution(success: Bool) {
        self.isSuccess = success
        self.semaphore.signal()
    }
}
