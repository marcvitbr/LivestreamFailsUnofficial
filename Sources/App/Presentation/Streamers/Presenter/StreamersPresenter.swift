//
//  StreamersPresenter.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 02/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class StreamersPresenter {
    private unowned var screen: StreamersScreen

    private unowned var fetchDetailsExecutor: FetchStreamerDetailsExecutor

    private unowned var fetchStreamersExecutor: FetchStreamersExecutor

    private weak var dispatcher: Dispatcher?

    init(screen: StreamersScreen,
         fetchStreamersExecutor: FetchStreamersExecutor,
         fetchDetailsExecutor: FetchStreamerDetailsExecutor,
         dispatcher: Dispatcher) {
        self.screen = screen
        self.fetchStreamersExecutor = fetchStreamersExecutor
        self.fetchDetailsExecutor = fetchDetailsExecutor
        self.dispatcher = dispatcher
    }

    func fetchStreamersDetails(for fails: [FailSummary]) {
        for fail in fails {
            guard let streamerName = fail.streamerName else {
                continue
            }

            self.dispatcher?.executeAsync {
                self.executeFetchStreamerDetails(streamerName)
            }
        }
    }

    func fetchStreamers() {
        self.dispatcher?.executeAsync {
            self.executeFetchStreamers()
        }
    }

    private func executeFetchStreamerDetails(_ streamerName: String) {
        do {
            let streamer = try self.fetchDetailsExecutor.executeFetchStreamerDetails(streamerName)

            self.presentStreamerOnScreen(streamer)
        } catch {
            self.showErrorOnScreen(streamerName)
        }
    }

    private func executeFetchStreamers() {
        do {
            let streamers = try self.fetchStreamersExecutor.executeFetchStreamers()

            self.presenterStreamersOnScreen(streamers)
        } catch {
            self.showErrorOnScreen()
        }
    }

    private func presentStreamerOnScreen(_ streamer: Streamer) {
        self.dispatcher?.executeAsyncOnMain {
            self.screen.presentStreamerDetails(streamer)
        }
    }

    private func showErrorOnScreen(_ streamerName: String) {
        self.dispatcher?.executeAsyncOnMain {
            self.screen.showErrorObtainingStreamerDetails(streamerName)
        }
    }

    private func presenterStreamersOnScreen(_ streamers: [Streamer]) {
        self.dispatcher?.executeAsyncOnMain {
            self.screen.presentStreamers(streamers)
        }
    }

    private func showErrorOnScreen() {
        self.dispatcher?.executeAsyncOnMain {
            self.screen.showErrorObtainingStreamers()
        }
    }
}
