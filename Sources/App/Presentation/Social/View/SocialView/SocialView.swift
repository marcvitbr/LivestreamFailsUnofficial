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
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    unowned var viewController: UIViewController! {
        didSet {
            self.likeButton.viewController = self.viewController
        }
    }

    weak var likeButtonDataSource: LikeButtonDataSource? {
        didSet {
            self.likeButton.dataSource = self.likeButtonDataSource
        }
    }

    weak var likeButtonDelegate: LikeButtonDelegate? {
        didSet {
            self.likeButton.delegate = self.likeButtonDelegate
        }
    }

    var profilePictureURL: URL? {
        didSet {
            if let url = self.profilePictureURL {
                self.profileImageView.kf.setImage(with: url)
            }
        }
    }

    var streamerName: String? {
        didSet {
            self.nameLabel.text = self.streamerName
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

        self.configureProfilePictureImageView()
    }

    private func loadNib() {
        let nib = UINib(nibName: "SocialView", bundle: nil)

        nib.instantiate(withOwner: self, options: nil)

        self.contentView.frame = self.bounds

        self.addSubview(self.contentView)
    }

    private func configureProfilePictureImageView() {
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
    }
}
