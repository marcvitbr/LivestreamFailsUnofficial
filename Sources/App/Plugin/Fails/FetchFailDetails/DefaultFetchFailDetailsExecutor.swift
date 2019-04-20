//
//  DefaultFetchFailDetailsExecutor.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation

final class DefaultFetchFailDetailsExecutor: FetchFailDetailsExecutor, FailDetailsReceiver {
    private lazy var semaphore = DispatchSemaphore(value: 0)

    private lazy var remoteFetcher = RemoteFailsFetcher()

    private var isSuccess = false

    private var retrievedDetails: FailDetails?

    func executeFetchFailDetails(_ failID: FailID) throws -> FailDetails {
        let fetchDetails = FetchFailDetails(fetcher: self.remoteFetcher,
                                            receiver: self)

        fetchDetails.execute(with: failID)

        self.semaphore.wait()

        guard self.isSuccess, let details = self.retrievedDetails else {
            throw FetchFailDetailsExecutorError.errorFetchingDetails
        }

        return details
    }

    func receiveFailDetails(_ details: FailDetails) {
        self.retrievedDetails = details
        self.resumeExecution(success: true)
    }

    func handleErrorFetchingFailDetails() {
        self.resumeExecution(success: false)
    }

    private func resumeExecution(success: Bool) {
        self.isSuccess = success
        self.semaphore.signal()
    }
}
