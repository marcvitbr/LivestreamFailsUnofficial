//
//  FailsViewControllerExtension.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 20/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

extension FailsViewController {
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {
//            return
//        }
//
//        self.initialTouchLocation = touch.location(in: self.view)
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first,
//            let currentFailView = self.currentFailView else {
//            return
//        }
//
//        let location = touch.location(in: self.view)
//        let previousLocation = touch.previousLocation(in: self.view)
//        let deltaY = location.y - previousLocation.y
//
//        currentFailView.frame.origin.y += deltaY
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first, let initialTouch = self.initialTouchLocation else {
//            return
//        }
//
//        let height = self.view.bounds.height
//        let location = touch.location(in: self.view)
//        let movementSize = location.y - initialTouch.y
//
//        let isFullSlide = abs(movementSize) >= height / 2
//        let isSlideUp = movementSize <= 0
//
//        let finalTopPosition = isFullSlide
//            ? isSlideUp ? -height : height
//            : 0
//
//        self.slideFailView(finalTopPosition,
//                           shouldChangeFail: isFullSlide,
//                           isNext: isSlideUp)
//    }
//
//    private func slideFailView(_ top: CGFloat, shouldChangeFail: Bool, isNext: Bool) {
//        var finalTop = top
//        var shouldChangeFail = shouldChangeFail
//
//        let shouldCancelChange = shouldChangeFail
//            && (isNext && self.isLastFail())
//            || (!isNext && self.isFirstFail())
//
//        if shouldCancelChange {
//            finalTop = 0
//            shouldChangeFail = false
//        }
//
//        let executeAnimation = { [weak self] in
//            guard let certainSelf = self, let currentFailView = certainSelf.currentFailView else {
//                return
//            }
//
//            currentFailView.frame.origin.y = finalTop
//        }
//
//        let executeCompletion: (Bool) -> Void = { [weak self] _ in
//            if shouldChangeFail {
//                self?.changeFailView(isNext)
//            }
//        }
//
//        UIView.animate(withDuration: 0.5,
//                       delay: 0,
//                       options: .curveEaseOut,
//                       animations: executeAnimation,
//                       completion: executeCompletion)
//    }
//
//    private func changeFailView(_ isNext: Bool) {
//        guard let failView = self.currentFailView,
//            let index = self.currentFailIndex else {
//                return
//        }
//
//        failView.stop()
//        failView.alpha = 0
//        failView.frame.origin.y = 0
//
//        let nextIndex = isNext ? index + 1 : index - 1
//        self.currentFailIndex = nextIndex
//
//        guard let fail = self.fails?[nextIndex] else {
//            return
//        }
//
//        failView.summary = fail
//
//        self.failsPresenter?.fetchDetails(of: fail.failID)
//
//        UIView.animate(withDuration: 0.5) { [weak self] in
//            self?.currentFailView?.alpha = 1
//        }
//    }
//
//    private func isLastFail() -> Bool {
//        guard let index = self.currentFailIndex else {
//            return false
//        }
//
//        return index == (self.fails?.count ?? 0) - 1
//    }
//
//    private func isFirstFail() -> Bool {
//        guard let index = self.currentFailIndex else {
//            return false
//        }
//
//        return index == 0
//    }
}
