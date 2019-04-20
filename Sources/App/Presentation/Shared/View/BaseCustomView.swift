//
//  BaseCustomView.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func loadNib(name: String, contentView: UIView?) {
        let nib = UINib(nibName: name, bundle: nil)

        nib.instantiate(withOwner: self, options: nil)

        contentView?.frame = self.bounds

        guard let view = contentView else {
            return
        }

        self.addSubview(view)
    }
}
