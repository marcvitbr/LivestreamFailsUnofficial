//
//  FailsPresenter.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

final class FailsPresenter {
    private unowned var screen: FailsScreen

    private unowned var fetchSummariesExecutor: FetchFailsSummariesExecutor

    private unowned var fetchDetailsExecutor: FetchFailDetailsExecutor

    private weak var dispatcher: Dispatcher?

    init(screen: FailsScreen,
         fetchSummariesExecutor: FetchFailsSummariesExecutor,
         fetchDetailsExecutor: FetchFailDetailsExecutor,
         dispatcher: Dispatcher) {
        self.screen = screen
        self.fetchSummariesExecutor = fetchSummariesExecutor
        self.fetchDetailsExecutor = fetchDetailsExecutor
        self.dispatcher = dispatcher
    }

    func fetchFails(ofStreamer streamerName: String) {
        self.screen.showIndicatorForObtainingFails()

        self.dispatcher?.executeAsync { [weak self] in
            let failsForStreamerQuery = FailsQuery(page: 0,
                                                   mode: .streamer,
                                                   order: .new,
                                                   timeFrame: .all,
                                                   nSFW: false,
                                                   streamerName: streamerName)

            guard let summaries = self?.fetchSummariesExecutor.executeFetchFailsSummaries(query: failsForStreamerQuery) else {
                self?.showErrorObtainingFailsOnScreen()
                return
            }

            self?.dispatcher?.executeAsyncOnMain { [weak self] in
                self?.screen.hideIndicatorForObtaningFails()
                self?.screen.presentFails(summaries)
            }
        }
    }

    func fetchDetails(of failID: FailID) {
        self.screen.showIndicatorForObtainingDetails()

        self.dispatcher?.executeAsync { [weak self] in
            self?.executeFetchDetails(failID)
        }
    }

    private func executeFetchDetails(_ failID: FailID) {
        do {
            let details = try self.fetchDetailsExecutor.executeFetchFailDetails(failID)

            self.dispatcher?.executeAsyncOnMain { [weak self] in
                self?.screen.hideIndicatorForObtainingDetails()
                self?.screen.presentFailDetails(details)
            }
        } catch {
            self.showErrorObtainingDetailsOnScreen()
        }
    }

    private func showErrorObtainingFailsOnScreen() {
        self.dispatcher?.executeAsyncOnMain { [weak self] in
            self?.screen.hideIndicatorForObtaningFails()
            self?.screen.showErrorObtainingFails()
        }
    }

    private func showErrorObtainingDetailsOnScreen() {
        self.dispatcher?.executeAsyncOnMain { [weak self] in
            self?.screen.hideIndicatorForObtainingDetails()
            self?.screen.showErrorObtainingDetails()
        }
    }
}
