//
//  Dispatcher.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

protocol Dispatcher: AnyObject {
    func executeAsync(_ code: @escaping () -> Void)

    func executeAsyncOnMain(_ code: @escaping () -> Void)
}
