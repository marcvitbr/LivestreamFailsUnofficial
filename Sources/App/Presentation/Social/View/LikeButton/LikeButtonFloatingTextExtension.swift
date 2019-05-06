//
//  LikeButtonFloatingTextExtension.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 05/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

extension LikeButton {
    internal func scheduleCreateLikeFloatingNumberLabel() {
        DispatchQueue.main.async {
            self.createLikeFloatingNumberLabel()
        }
    }

    internal func createLikeFloatingNumberLabel() {
        var label: UILabel? = UILabel(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 10,
                                                                 height: 10)))

        let fontSize = self.calculateFontSizeForLikeEffect()

        label!.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label!.textColor = UIColor.random()
        label!.text = "+\(self.currentLikes)"

        let center = self.likeImage.convert(self.likeImage.center, to: self.viewController.view)

        self.viewController.view.addSubview(label!)

        label?.sizeToFit()
        label?.center = center
        label?.frame.origin.x += CGFloat.random(in: -30...10)
        label?.frame.origin.y -= self.likeImage.frame.height / 2

        let animation = UIViewPropertyAnimator(duration: 0.8, curve: .easeIn) {
            label?.frame.origin.y -= 500
            label?.alpha = 0
        }

        animation.addCompletion { _ in
            label?.removeFromSuperview()
            label = nil
        }

        animation.startAnimation()
    }

    internal func calculateFontSizeForLikeEffect() -> CGFloat {
        let newFontSize = CGFloat(self.totalLikes) + self.minFontSize

        if newFontSize > self.maxFontSize {
            return self.maxFontSize
        }

        return newFontSize
    }
}
