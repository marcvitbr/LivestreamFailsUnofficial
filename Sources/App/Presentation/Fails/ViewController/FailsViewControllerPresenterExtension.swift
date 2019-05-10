//
//  FailsViewControllerPresenterExtension.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

extension FailsViewController: FailsScreen {
    func configureFailsPresenter() {
        self.failsPresenter = FailsPresenter(screen: self,
                                             fetchSummariesExecutor: self.failsSummariesExecutor,
                                             fetchDetailsExecutor: self.failDetailsExecutor,
                                             dispatcher: self.dispatcher)
    }

    func presentFails(_ fails: [FailSummary]) {
        self.fails = fails

        guard let first = self.fails?.first else {
            return
        }

        self.presentSummary(first)

        self.failsPresenter?.fetchDetails(of: first.failID)
    }

    func presentFailDetails(_ details: FailDetails) {
        self.currentFailView?.details = details
    }

    func showErrorObtainingFails() {}

    func showErrorObtainingDetails() {}

    func showIndicatorForObtainingFails() {}

    func showIndicatorForObtainingDetails() {}

    func hideIndicatorForObtaningFails() {}

    func hideIndicatorForObtainingDetails() {}

    private func presentSummary(_ summary: FailSummary) {
        self.failDetailView.title = summary.description
        self.failDetailView.subtitle = summary.gameName
        self.failDetailView.likeCount = 100
    }
}
