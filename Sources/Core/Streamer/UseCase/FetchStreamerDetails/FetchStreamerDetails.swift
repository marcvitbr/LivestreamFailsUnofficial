//
//  FetchStreamerDetails.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class FetchStreamerDetails: ParameterizedUseCase {
    typealias Parameters = String

    private let fetcher: StreamerFetcher

    private let receiver: StreamerDetailsReceiver

    init(fetcher: StreamerFetcher, receiver: StreamerDetailsReceiver) {
        self.fetcher = fetcher
        self.receiver = receiver
    }

    func execute(with parameters: String) {
        do {
            let streamer = try self.fetcher.fetchStreamerDetails(name: parameters)

            self.receiver.receiveStreamerDetails(streamer)
        } catch {
            self.receiver.handleErrorFetchingStreamerDetails()
        }
    }
}
