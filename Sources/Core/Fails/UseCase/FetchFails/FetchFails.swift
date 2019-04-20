//
//  FetchFails.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class FetchFails: ParameterizedUseCase {
    typealias Parameters = FailsQuery

    private let fetcher: FailsFetcher

    private let receiver: FailsReceiver

    init(fetcher: FailsFetcher, receiver: FailsReceiver) {
        self.fetcher = fetcher
        self.receiver = receiver
    }

    func execute(with parameters: FailsQuery) {
        do {
            let fails = try self.fetcher.fetch(with: parameters)

            self.receiver.receiveFails(fails)
        } catch {
            self.receiver.handleErrorFetchingFails()
        }
    }
}
