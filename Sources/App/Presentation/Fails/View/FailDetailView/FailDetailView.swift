//
//  FailDetailView.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 11/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

class FailDetailView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var likeCountView: UIView!
    @IBOutlet weak var likeCountLabel: UILabel!

    var title: String? {
        didSet {
            self.titleLabel.text = self.title
        }
    }

    var subtitle: String? {
        didSet {
            self.subtitleLabel.text = self.subtitle
        }
    }

    var likeCount: Int = 0 {
        didSet {
            self.likeCountLabel.text = "\(self.likeCount)"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    func decrementLikeCount() {
        if self.likeCount == 0 {
            return
        }

        self.likeCount -= 1
    }

    private func initialize() {
        self.loadNib()

        self.configureLikeCountView()
    }

    private func loadNib() {
        let nib = UINib(nibName: "FailDetailView", bundle: nil)

        nib.instantiate(withOwner: self, options: nil)

        self.contentView.frame = self.bounds

        self.addSubview(self.contentView)
    }

    private func configureLikeCountView() {
        self.likeCountView.layer.cornerRadius = 5
    }
}
