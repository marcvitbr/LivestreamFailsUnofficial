//
//  LikeButton.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 03/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

class LikeButton: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!

    unowned var viewController: UIViewController!

    private var animatingTouch = false
    private var waveViewsCount = 0

    var totalLikes: Int = 0 {
        didSet {
            self.countLabel.text = String(self.totalLikes)
        }
    }

    private var currentLikes: Int = 0

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
        self.contentView.clipsToBounds = false
        self.contentView.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.masksToBounds = false

        self.addSubview(self.contentView)
    }

    private func configureLikeTouch() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnLike))
        self.likeImage.isUserInteractionEnabled = true
        self.likeImage.addGestureRecognizer(tap)
    }

    @objc
    private func tapOnLike(sender: UITapGestureRecognizer) {
        print("TAPPED")

        self.currentLikes += 1

        self.scheduleCreateTouchWaveView()

        self.scheduleCreateLikeFloatingNumberLabel()

        self.animateLikeButtonIfNeeded()

        self.totalLikes += 1
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

    private func scheduleCreateTouchWaveView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.createTouchWaveView()
        }
    }

    private func createTouchWaveView() {
        var frame = self.likeImage.frame
        let maxSize = max(frame.width, frame.height)
        frame.size = CGSize(width: maxSize, height: maxSize)
        var view1: UIView? = UIView(frame: frame)
        view1?.backgroundColor = UIColor.white
        view1?.alpha = 0.1

        self.viewController.view.addSubview(view1!)
//        self.contentView.addSubview(view1!)

        view1?.layer.cornerRadius = view1!.frame.height / 2
        view1?.layer.masksToBounds = false

        let center = self.likeImage.convert(self.likeImage.center, to: self.viewController.view)
        view1?.center = center

        let newAlpha = CGFloat.random(in: 0.5...0.9)
        let anim = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            view1?.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2)
            view1?.alpha = newAlpha
        }

        anim.addCompletion { _ in
            view1?.removeFromSuperview()
            view1 = nil

            self.waveViewsCount -= 1

            if self.waveViewsCount == 0 {
                self.animatingTouch = false
            }
        }

        self.waveViewsCount += 1

        anim.startAnimation()
    }

    private func scheduleCreateLikeFloatingNumberLabel() {
        DispatchQueue.main.async {
            self.createLikeFloatingNumberLabel()
        }
    }

    private func createLikeFloatingNumberLabel() {
        var label: UILabel? = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 10, height: 10)))
        let fontSize = self.calculateFontSizeForLikeEffect()
        label!.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label!.textColor = self.generateTextColorForLikeEffect()
        label!.text = "+\(self.totalLikes)"

        let center = self.likeImage.convert(self.likeImage.center, to: self.viewController.view)

        self.viewController.view.addSubview(label!)

        label?.sizeToFit()
        label!.center = center

        let animation = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            label?.frame.origin.y -= 500
            label?.alpha = 0
        }

        animation.addCompletion { _ in
            label?.removeFromSuperview()
            label = nil
        }

        animation.startAnimation()
    }

    private let maxFontSize: CGFloat = 30
    private let minFontSize: CGFloat = 50
    private func calculateFontSizeForLikeEffect() -> CGFloat {
        let newFontSize = CGFloat(self.totalLikes) + self.minFontSize

        if newFontSize > self.maxFontSize {
            return self.maxFontSize
        }

        return newFontSize
    }

    private func generateTextColorForLikeEffect() -> UIColor {
        let red: CGFloat = CGFloat.random(in: 0...1)
        let green: CGFloat = CGFloat.random(in: 0...1)
        let blue: CGFloat = CGFloat.random(in: 0...1)

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
