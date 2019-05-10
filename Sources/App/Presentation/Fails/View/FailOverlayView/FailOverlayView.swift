//
//  FailOverlayView.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 11/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

class FailOverlayView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var elapsedLabel: UILabel!

    var elapsedText: String = "00:00:00" {
        didSet {
            self.elapsedLabel.text = self.elapsedText
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

    private func initialize() {
        self.loadNib()
    }

    private func loadNib() {
        let nib = UINib(nibName: "FailOverlayView", bundle: nil)

        nib.instantiate(withOwner: self, options: nil)

        self.contentView.frame = self.bounds

        self.addSubview(self.contentView)
    }
}
