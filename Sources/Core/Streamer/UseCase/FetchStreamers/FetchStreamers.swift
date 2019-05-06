//
//  FetchStreamers.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 09/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation

final class FetchStreamers: UseCase {
    private weak var receiver: StreamersReceiver?

    private weak var fetcher: StreamerFetcher?

    init(fetcher: StreamerFetcher, receiver: StreamersReceiver) {
        self.fetcher = fetcher
        self.receiver = receiver
    }

    func execute() {
        do {
            guard let streamers = try self.fetcher?.fetchStreamers() else {
                self.receiver?.handleErrorFetchingStreamers()
                return
            }

            self.receiver?.receiveStreamers(streamers)
        } catch {
            self.receiver?.handleErrorFetchingStreamers()
        }
    }
}
