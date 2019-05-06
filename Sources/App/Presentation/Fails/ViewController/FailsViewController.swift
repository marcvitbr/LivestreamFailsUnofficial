//
//  FailsViewController.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 20/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import UIKit
import AVKit

class FailsViewController: UIViewController {
    @IBOutlet weak var streamersView: StreamersView!
    @IBOutlet weak var currentFailView: FailVideoView!
    @IBOutlet weak var socialView: SocialView!

    var initialTouchLocation: CGPoint?

    internal lazy var failsSummariesExecutor = DefaultFetchFailsSummariesExecutor()
    internal lazy var failDetailsExecutor = DefaultFetchFailDetailsExecutor()
    internal lazy var streamersExecutor = DefaultFetchStreamersExecutor()
    internal lazy var streamersDetailsExecutor = DefaultFetchStreamerDetailsExecutor()
    internal lazy var dispatcher = DefaultDispatcher()

    internal var failsPresenter: FailsPresenter?
    internal var streamersPresenter: StreamersPresenter?

    internal var fails: [FailSummary]?
    internal var currentFailIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureFailsPresenter()

        self.configureStreamersPresenter()

        self.configureFailView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.failsPresenter?.fetchSummaries()

        self.streamersPresenter?.fetchStreamers()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func configureFailView() {
        self.view.bringSubviewToFront(self.streamersView)

        self.socialView.viewController = self
    }
}
