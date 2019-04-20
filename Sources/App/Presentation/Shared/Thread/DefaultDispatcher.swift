//
//  DefaultDispatcher.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation

final class DefaultDispatcher: Dispatcher {
    func executeAsync(_ code: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async(execute: code)
    }

    func executeAsyncOnMain(_ code: @escaping () -> Void) {
        DispatchQueue.main.async(execute: code)
    }
}
