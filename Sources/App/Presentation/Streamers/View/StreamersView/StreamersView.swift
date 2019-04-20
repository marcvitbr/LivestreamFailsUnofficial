//
//  StreamersView.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

class StreamersView: UIView {
    private let margin: CGFloat = 20

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var streamersContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!

    private weak var lastImageView: UIImageView?

    private lazy var queue = DispatchQueue(label: "StreamersViewQueue")

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
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

        let imageView = UIImageView(frame: newFrame)

        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = newFrame.height / 2
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: newStreamer.profilePictureURL)

        self.streamersContainer.addSubview(imageView)

        self.lastImageView = imageView

        self.scrollView.contentSize = CGSize(width: newFrame.origin.x + newFrame.width,
                                             height: self.scrollView.frame.height)
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
        let height = self.streamersContainer.frame.height - self.margin

        guard let lastImageView = self.lastImageView else {
            return CGRect(x: self.margin,
                          y: self.margin,
                          width: height,
                          height: height)
        }

        let newX = lastImageView.frame.origin.x + lastImageView.frame.width + self.margin
        return CGRect(x: newX,
                      y: self.margin,
                      width: height,
                      height: height)
    }
}
