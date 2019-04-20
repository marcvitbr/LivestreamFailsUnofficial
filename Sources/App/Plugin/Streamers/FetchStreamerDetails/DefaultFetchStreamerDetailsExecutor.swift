//
//  DefaultFetchStreamerDetailsExecutor.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 02/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation

final class DefaultFetchStreamerDetailsExecutor: FetchStreamerDetailsExecutor, StreamerDetailsReceiver {
    private lazy var semaphore = DispatchSemaphore(value: 0)

    private lazy var remoteFetcher = RemoteStreamerFetcher()

    private var isSuccess = false

    private var retrievedDetails: Streamer?

    func executeFetchStreamerDetails(_ name: String) throws -> Streamer {
        let fetchDetails = FetchStreamerDetails(fetcher: self.remoteFetcher,
                                                receiver: self)

        fetchDetails.execute(with: name)

        self.semaphore.wait()

        guard self.isSuccess, let details = self.retrievedDetails else {
            throw StreamerFetcherError.errorFetchingStreamerDetails
        }

        return details
    }

    func receiveStreamerDetails(_ streamer: Streamer) {
        self.retrievedDetails = streamer
        self.resumeExecution(success: true)
    }

    func handleErrorFetchingStreamerDetails() {
        self.resumeExecution(success: false)
    }

    private func resumeExecution(success: Bool) {
        self.isSuccess = success
        self.semaphore.signal()
    }
}
