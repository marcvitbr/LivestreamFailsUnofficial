//
//  FailDetailsReceiverMock.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class FailDetailsReceiverMock: FailDetailsReceiver {
    var callsToReceiveFailDetails = 0

    var callsToHandleErrorFetchingFailDetails = 0

    func receiveFailDetails(_ details: FailDetails) {
        self.callsToReceiveFailDetails += 1
    }

    func handleErrorFetchingFailDetails() {
        self.callsToHandleErrorFetchingFailDetails += 1
    }
}
