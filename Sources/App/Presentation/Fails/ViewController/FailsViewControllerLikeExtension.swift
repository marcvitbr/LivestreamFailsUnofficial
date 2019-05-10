//
//  FailsViewControllerLikeExtension.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 11/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

extension FailsViewController: LikeButtonDataSource, LikeButtonDelegate {
    func configureLikeButtonBehavior() {
        self.socialView.likeButtonDataSource = self
        self.socialView.likeButtonDelegate = self
    }

    func hasLikesToSpend() -> Bool {
        return self.failDetailView.likeCount > 0
    }

    func handleLikeAction() {
        self.failDetailView.decrementLikeCount()
    }
}
