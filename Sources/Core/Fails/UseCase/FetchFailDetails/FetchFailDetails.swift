//
//  FetchFailDetails.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class FetchFailDetails: ParameterizedUseCase {
    typealias Parameters = FailID

    private let fetcher: FailsFetcher

    private let receiver: FailDetailsReceiver

    init(fetcher: FailsFetcher, receiver: FailDetailsReceiver) {
        self.fetcher = fetcher
        self.receiver = receiver
    }

    func execute(with parameters: FailID) {
        do {
            let details = try self.fetcher.fetchDetails(failID: parameters.value)

            self.receiver.receiveFailDetails(details)
        } catch {
            self.receiver.handleErrorFetchingFailDetails()
        }
    }
}
