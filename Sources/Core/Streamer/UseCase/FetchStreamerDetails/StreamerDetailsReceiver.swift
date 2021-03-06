//
//  StreamerDetailsReceiver.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

protocol StreamerDetailsReceiver {
    func receiveStreamerDetails(_ streamer: Streamer)

    func handleErrorFetchingStreamerDetails()
}
