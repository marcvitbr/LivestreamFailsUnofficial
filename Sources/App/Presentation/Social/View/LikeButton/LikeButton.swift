//
//  LikeButton.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 03/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

protocol LikeButtonDataSource: AnyObject {
    func hasLikesToSpend() -> Bool
}

protocol LikeButtonDelegate: AnyObject {
    func handleLikeAction()
}

class LikeButton: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!

    weak var dataSource: LikeButtonDataSource?
    weak var delegate: LikeButtonDelegate?
    unowned var viewController: UIViewController!

    internal let maxFontSize: CGFloat = 30
    internal let minFontSize: CGFloat = 50
    internal var animatingTouch = false
    internal var waveViewsCount = 0

    var totalLikes: Int = 0 {
        didSet {
            self.countLabel.text = String(self.totalLikes)
        }
    }

    internal var currentLikes: Int = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    private func initialize() {
        self.loadNib()

        self.configureLikeTouch()
    }

    private func loadNib() {
        let nib = UINib(nibName: "LikeButton", bundle: nil)

        nib.instantiate(withOwner: self, options: nil)

        self.contentView.frame = self.bounds
        self.contentView.layer.masksToBounds = false

        self.addSubview(self.contentView)
    }

    private func configureLikeTouch() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnLike))
        self.likeImage.isUserInteractionEnabled = true
        self.likeImage.addGestureRecognizer(tap)
        self.likeImage.clipsToBounds = false
    }

    @objc
    private func tapOnLike(sender: UITapGestureRecognizer) {
        if !(self.dataSource?.hasLikesToSpend() ?? false) {
            return
        }

        self.currentLikes += 1

        self.scheduleCreateTouchWaveView()

        self.scheduleCreateLikeFloatingNumberLabel()

        self.animateLikeButtonIfNeeded()

        self.totalLikes += 1

        self.delegate?.handleLikeAction()
    }

    private func animateLikeButtonIfNeeded() {
        if self.animatingTouch {
            return
        }

        self.animatingTouch = true

        let scaleUpAnimation = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            self.likeImage.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }

        let shrinkAnimation = UIViewPropertyAnimator(duration: 0.2, curve: .linear, animations: {
            self.likeImage.transform = CGAffineTransform.identity.scaledBy(x: 0.7, y: 0.7)
        })

        let scaleNormalAnimation = UIViewPropertyAnimator(duration: 0.2, curve: .linear, animations: {
            self.likeImage.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        })

        scaleUpAnimation.addCompletion { _ in
            shrinkAnimation.startAnimation()
        }

        shrinkAnimation.addCompletion { _ in
            scaleNormalAnimation.startAnimation()
        }

        scaleUpAnimation.startAnimation()
    }

    internal func resetCounters() {
        self.animatingTouch = false
        self.currentLikes = 0
    }
}
