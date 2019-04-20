//
//  FetchFailDetailsExecutor.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

protocol FetchFailDetailsExecutor: AnyObject {
    func executeFetchFailDetails(_ failID: FailID) throws -> FailDetails
}
