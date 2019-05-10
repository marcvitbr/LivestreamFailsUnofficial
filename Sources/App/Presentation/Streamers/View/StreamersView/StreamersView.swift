//
//  StreamersView.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

protocol StreamersViewDelegate: AnyObject {
    func handleStreamerSelection(_ streamer: Streamer)
}

class StreamersView: UIView {
    private let spaceBetweenStreamers: CGFloat = 20

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var streamersContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var streamersViewWidthConstraint: NSLayoutConstraint!

    private weak var lastStreamerView: StreamerCircleView?
    private weak var selectedStreamerView: StreamerCircleView?

    private lazy var queue = DispatchQueue(label: "StreamersViewQueue")

    weak var delegate: StreamersViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    func addStreamers(_ newStreamers: [Streamer]) {
        newStreamers.forEach(self.addStreamer)
    }

    func addStreamer(_ newStreamer: Streamer) {
        self.queue.sync {
            DispatchQueue.main.async {
                self.addStreamerToTheEnd(newStreamer)
            }
        }
    }

    func addStreamerToTheEnd(_ newStreamer: Streamer) {
        let newFrame = self.frameForNewStreamer()

        let streamerCircleView = StreamerCircleView(frame: newFrame)
        streamerCircleView.streamer = newStreamer

        self.addTouch(to: streamerCircleView)

        self.streamersContainer.addSubview(streamerCircleView)

        self.lastStreamerView = streamerCircleView

        let newContentSize = CGSize(width: newFrame.origin.x + newFrame.width,
                                    height: self.scrollView.frame.height)

        self.scrollView.contentSize = newContentSize
        self.streamersViewWidthConstraint.constant = newContentSize.width
    }

    private func initialize() {
        self.loadNib()
    }

    private func loadNib() {
        let nib = UINib(nibName: "StreamersView", bundle: nil)

        nib.instantiate(withOwner: self, options: nil)

        self.contentView.frame = self.bounds

        self.addSubview(self.contentView)
    }

    private func frameForNewStreamer() -> CGRect {
        let height = self.streamersContainer.frame.height

        guard let lastStreamerView = self.lastStreamerView else {
            return CGRect(x: self.spaceBetweenStreamers,
                          y: 0,
                          width: height,
                          height: height)
        }

        let frame = lastStreamerView.frame
        let newX = frame.origin.x + frame.width + self.spaceBetweenStreamers
        return CGRect(x: newX,
                      y: 0,
                      width: height,
                      height: height)
    }

    private func addTouch(to streamerView: StreamerCircleView) {
        streamerView.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        streamerView.addGestureRecognizer(tap)
    }

    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let streamerView = sender.view as? StreamerCircleView,
            let streamer = streamerView.streamer else {
            return
        }

        if let lastSelectedStreamerView = self.selectedStreamerView {
            lastSelectedStreamerView.scaleTo(factor: 1)
        }

        streamerView.scaleTo(factor: 1.1)

        self.selectedStreamerView = streamerView

        self.delegate?.handleStreamerSelection(streamer)
    }
}
