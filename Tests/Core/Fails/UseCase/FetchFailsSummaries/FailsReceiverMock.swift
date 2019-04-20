//
//  FailsSummariesReceiverMock.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class FailsSummariesReceiverMock: FailsSummariesReceiver {
    var callsToReceiveFailsSummaries = 0

    var callsToHandleErrorFetchingFailsSummaries = 0

    func receiveFailsSummaries(_ fails: [FailSummary]) {
        self.callsToReceiveFailsSummaries += 1
    }

    func handleErrorFetchingFailsSummaries() {
        self.callsToHandleErrorFetchingFailsSummaries += 1
    }
}
