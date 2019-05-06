//
//  LikeButtonWaveExtension.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 05/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

extension LikeButton {
    internal func scheduleCreateTouchWaveView() {
        DispatchQueue.main.async {
            self.createTouchWaveView()
        }
    }

    internal func createTouchWaveView() {
        var frame = self.likeImage.frame
        let maxSize = max(frame.width, frame.height)
        frame.size = CGSize(width: maxSize, height: maxSize)

        var waveView: PassthroughView? = PassthroughView(frame: frame)
        waveView?.backgroundColor = UIColor.themeLikeButtonColor()
        waveView?.alpha = 0.1
        waveView?.layer.cornerRadius = waveView!.frame.height / 2
        waveView?.layer.masksToBounds = false

        let animation = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            waveView?.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2)
            waveView?.alpha = 0.3
        }

        animation.addCompletion { _ in
            waveView?.removeFromSuperview()
            waveView = nil

            self.waveViewsCount -= 1

            if self.waveViewsCount == 0 {
                self.resetCounters()
            }
        }

        self.waveViewsCount += 1

        self.contentView.addSubview(waveView!)

        waveView?.center = self.likeImage.center

        self.contentView.bringSubviewToFront(self.likeImage)

        animation.startAnimation()
    }
}
