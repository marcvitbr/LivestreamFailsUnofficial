//
//  StreamersScreen.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 02/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

protocol StreamersScreen: AnyObject {
    func presentStreamerDetails(_ streamer: Streamer)

    func showErrorObtainingStreamerDetails(_ name: String)

    func presentStreamers(_ streamers: [Streamer])

    func showErrorObtainingStreamers()
}
