//
//  DefaultFetchStreamersExecutor.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 09/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation

final class DefaultFetchStreamersExecutor: FetchStreamersExecutor, StreamersReceiver {
    private lazy var semaphore = DispatchSemaphore(value: 0)

    private lazy var remoteFetcher = RemoteStreamerFetcher()

    private var isSuccess = false

    private var retrievedStreamers: [Streamer]?

    func executeFetchStreamers() throws -> [Streamer] {
        let fetchStreamers = FetchStreamers(fetcher: self.remoteFetcher, receiver: self)

        fetchStreamers.execute()

        self.semaphore.wait()

        guard self.isSuccess, let streamers = self.retrievedStreamers else {
            throw StreamerFetcherError.errorFetchingStreamers
        }

        return streamers
    }

    func receiveStreamers(_ streamers: [Streamer]) {
        self.retrievedStreamers = streamers
        self.resumeExecution(success: true)
    }

    func handleErrorFetchingStreamers() {
        self.resumeExecution(success: false)
    }

    private func resumeExecution(success: Bool) {
        self.isSuccess = success
        self.semaphore.signal()
    }
}
