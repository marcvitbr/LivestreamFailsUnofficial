//
//  FailsReceiverMock.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class FailsReceiverMock: FailsReceiver {
    var callsToReceiveFails = 0

    var callsToHandleErrorFetchingFails = 0

    func receiveFails(_ fails: [Fail]) {
        self.callsToReceiveFails += 1
    }

    func handleErrorFetchingFails() {
        self.callsToHandleErrorFetchingFails += 1
    }
}
