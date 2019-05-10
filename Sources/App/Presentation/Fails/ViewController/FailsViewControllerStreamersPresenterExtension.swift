//
//  FailsViewControllerStreamersPresenterExtension.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 02/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

extension FailsViewController: StreamersScreen, StreamersViewDelegate {
    func configureStreamersPresenter() {
        self.streamersPresenter = StreamersPresenter(screen: self,
                                                     fetchStreamersExecutor: self.streamersExecutor,
                                                     fetchDetailsExecutor: self.streamersDetailsExecutor,
                                                     dispatcher: self.dispatcher)
    }

    func presentStreamers(_ streamers: [Streamer]) {
        self.streamersView.addStreamers(streamers)

        if let firstStreamer = streamers.first {
            self.failsPresenter?.fetchFails(ofStreamer: firstStreamer.name)

            self.presentStreamerDetails(firstStreamer)
        }
    }

    func handleStreamerSelection(_ streamer: Streamer) {
        self.currentFailView.stop()

        self.failsPresenter?.fetchFails(ofStreamer: streamer.name)

        self.presentStreamerDetails(streamer)
    }

    func presentStreamerDetails(_ streamer: Streamer) {
        self.socialView.profilePictureURL = streamer.profilePictureURL
        self.socialView.streamerName = streamer.name
    }

    func showErrorObtainingStreamers() {}

    func showErrorObtainingStreamerDetails(_ name: String) {}
}
