//
//  FailsSummariesReceiver.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

protocol FailsSummariesReceiver {
    func receiveFailsSummaries(_ fails: [FailSummary])

    func handleErrorFetchingFailsSummaries()
}
