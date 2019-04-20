//
//  FailsViewControllerStreamersPresenterExtension.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 02/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

extension FailsViewController: StreamersScreen {
    func configureStreamersPresenter() {
        self.streamersPresenter = StreamersPresenter(screen: self,
                                                     fetchDetailsExecutor: self.streamersDetailsExecutor,
                                                     dispatcher: self.dispatcher)
    }

    func presentStreamerDetails(_ streamer: Streamer) {
        self.streamersView.addStreamer(streamer)
    }

    func showErrorObtainingStreamerDetails(_ name: String) {}
}
