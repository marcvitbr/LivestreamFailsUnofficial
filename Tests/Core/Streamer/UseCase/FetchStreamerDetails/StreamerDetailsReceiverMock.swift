//
//  StreamerDetailsReceiverMock.swift
//  LivestreamFailsUnofficialTests
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

class StreamerDetailsReceiverMock: StreamerDetailsReceiver {
    var callsToReceiveStreamerDetails = 0

    var callsToHandleErrorFetchingStreamerDetails = 0

    func receiveStreamerDetails(_ streamer: Streamer) {
        self.callsToReceiveStreamerDetails += 1
    }

    func handleErrorFetchingStreamerDetails() {
        self.callsToHandleErrorFetchingStreamerDetails += 1
    }
}
