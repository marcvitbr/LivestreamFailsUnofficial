//
//  SocialView.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 03/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

class SocialView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var likeButton: LikeButton!

    unowned var viewController: UIViewController! {
        didSet {
            self.likeButton.viewController = self.viewController
        }
    }

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
    }

    private func loadNib() {
        let nib = UINib(nibName: "SocialView", bundle: nil)

        nib.instantiate(withOwner: self, options: nil)

        self.contentView.frame = self.bounds

        self.addSubview(self.contentView)
    }
}
