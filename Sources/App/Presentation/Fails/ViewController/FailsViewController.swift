//
//  FailsViewController.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 20/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import UIKit
import AVKit

class FailsViewController: UIViewController, FailVideoViewDelegate {
    @IBOutlet weak var streamersView: StreamersView!
    @IBOutlet weak var currentFailView: FailVideoView!
    @IBOutlet weak var socialView: SocialView!
    @IBOutlet weak var overlayView: FailOverlayView!
    @IBOutlet weak var failDetailView: FailDetailView!
    
    var initialTouchLocation: CGPoint?

    internal lazy var failsSummariesExecutor = DefaultFetchFailsSummariesExecutor()
    internal lazy var failDetailsExecutor = DefaultFetchFailDetailsExecutor()
    internal lazy var streamersExecutor = DefaultFetchStreamersExecutor()
    internal lazy var streamersDetailsExecutor = DefaultFetchStreamerDetailsExecutor()
    internal lazy var dispatcher = DefaultDispatcher()

    internal var failsPresenter: FailsPresenter?
    internal var streamersPresenter: StreamersPresenter?

    internal var fails: [FailSummary]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureFailsPresenter()

        self.configureStreamersPresenter()

        self.configureFailView()

        self.configureLikeButtonBehavior()

        self.streamersPresenter?.fetchStreamers()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func changeElapsedTimeText(_ elapsedTimeText: String) {
        self.overlayView.elapsedText = elapsedTimeText
    }

    func resetElapsedTimeText() {
        self.overlayView.elapsedText = ""
    }

    private func configureFailView() {
        self.view.bringSubviewToFront(self.streamersView)

        self.socialView.viewController = self

        self.streamersView.delegate = self

        self.currentFailView.delegate = self
    }
}
