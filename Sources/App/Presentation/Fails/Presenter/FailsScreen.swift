//
//  FailsScreen.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

protocol FailsScreen: AnyObject {
    func presentFails(_ fails: [FailSummary])

    func presentFailDetails(_ details: FailDetails)

    func showErrorObtainingFails()

    func showErrorObtainingDetails()

    func showIndicatorForObtainingFails()

    func showIndicatorForObtainingDetails()

    func hideIndicatorForObtaningFails()

    func hideIndicatorForObtainingDetails()
}
