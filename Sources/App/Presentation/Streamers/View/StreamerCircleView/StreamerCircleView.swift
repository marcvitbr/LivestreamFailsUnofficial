//
//  StreamerCircleView.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 11/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

class StreamerCircleView: UIView {
    private lazy var defaultLabelFont = UIFont.systemFont(ofSize: 14)

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profileImageContainer: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabelBottomConstraint: NSLayoutConstraint!

    var streamer: Streamer? {
        didSet {
            guard let streamer = self.streamer else {
                return
            }

            self.profileImageURL = streamer.profilePictureURL
            self.name = streamer.name
        }
    }

    var profileImageURL: URL? {
        didSet {
            if let imageURL = self.profileImageURL {
                self.profileImageView.kf.setImage(with: imageURL)
            }
        }
    }

    var name: String? {
        didSet {
            self.nameLabel.text = self.name
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

    override func layoutSubviews() {
        super.layoutSubviews()

        let topMargin: CGFloat = 1
        let newHeight: CGFloat = self.frame.height - self.nameLabel.frame.height - (topMargin * 2)
        let newWidth: CGFloat = newHeight
        let newX: CGFloat = self.bounds.width / 2 - newWidth / 2

        let offset: CGFloat = 5
        let newFrame = CGRect(x: newX, y: topMargin, width: newWidth, height: newHeight)
        let newFrameImage = CGRect(x: offset,
                                   y: offset,
                                   width: newWidth - offset * 2,
                                   height: newHeight - offset * 2)

        self.profileImageContainer.frame = newFrame
        self.profileImageContainer.layer.cornerRadius = self.profileImageContainer.frame.width / 2
        self.profileImageContainer.setGradientBorder(width: 4,
                                                     colors: [UIColor.random(),
                                                              UIColor.random()])

        self.profileImageView.frame = newFrameImage
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
    }

    func scaleTo(factor: CGFloat) {
        UIView.animate(withDuration: 0.1) {
            self.profileImageContainer.transform = CGAffineTransform.identity.scaledBy(x: factor, y: factor)
        }
    }

    private func initialize() {
        self.loadNib()

        self.configureProfileImageView()

        self.configureNameLabel()
    }

    private func loadNib() {
        let nib = UINib(nibName: "StreamerCircleView", bundle: nil)

        nib.instantiate(withOwner: self, options: nil)

        self.contentView.frame = self.bounds

        self.addSubview(self.contentView)
    }

    private func configureProfileImageView() {
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.clipsToBounds = true
        self.profileImageView.kf.indicatorType = .activity

        self.profileImageContainer.clipsToBounds = true
    }

    private func configureNameLabel() {
        self.nameLabel.textColor = UIColor.themeTextColor()
        self.nameLabel.textAlignment = .center
        self.nameLabel.font = self.defaultLabelFont
        self.nameLabel.lineBreakMode = .byTruncatingTail
        self.nameLabel.numberOfLines = 1
    }
}


public extension UIView {
    func setGradientBorder(
        width: CGFloat,
        colors: [UIColor],
        startPoint: CGPoint = CGPoint(x: 0.5, y: 0),
        endPoint: CGPoint = CGPoint(x: 0.5, y: 1)
        ) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight],
                                cornerRadii: CGSize(width: frame.size.height / 2,
                                                    height: frame.size.height / 2))

        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: frame.size)
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colors.map { $0.cgColor }

        let shape = CAShapeLayer()
        shape.lineWidth = width
        shape.path = path.cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.layer.insertSublayer(gradient, at: 0)
    }
}
