//
//  RemoteFailsFetcher.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import Alamofire

final class RemoteFailsFetcher: FailsFetcher {
    private let summariesEndpoint = "https://livestreamfails.com/load/loadPosts.php"

    private let detailsEndpoint = "https://livestreamfails.com/post/"

    private lazy var parser = FailsHTMLParser()

    func fetchSummaries(with query: FailsQuery) throws -> [FailSummary] {
        let queryParameters: [String: Any] = ["loadPostPage": query.page,
                                              "loadPostMode": query.mode.description,
                                              "loadPostOrder": query.order.description,
                                              "loadPostTimeFrame": query.timeFrame.description,
                                              "loadPostNSFW": NSNumber(booleanLiteral: query.nSFW)]

        let url = URL(string: self.summariesEndpoint)!

        var isSuccess = false

        let semaphore = DispatchSemaphore(value: 0)

        var summaries: [FailSummary] = []

        AF.request(url, method: .get, parameters: queryParameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseString { response in
            switch response.result {
            case let .success(html):
                do {
                    summaries = try self.parser.parseToSummaries(html)

                    isSuccess = true
                } catch {
                    isSuccess = false
                }

                semaphore.signal()
            case .failure(_):
                isSuccess = false
                semaphore.signal()
            }
        }

        semaphore.wait()

        if !isSuccess {
            throw FailsFetcherError.errorFetchingFailsSummaries
        }

        return summaries
    }

    func fetchDetails(failID: String) throws -> FailDetails {
        let finalUrl = "\(self.detailsEndpoint)\(failID)"

        let url = URL(string: finalUrl)!

        var isSuccess = false

        let semaphore = DispatchSemaphore(value: 0)

        var details: FailDetails?

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseString { response in
            switch response.result {
            case let .success(html):
                do {
                    details = try self.parser.parseToDetails(html, failID)

                    isSuccess = true
                } catch {
                    isSuccess = false
                }

                semaphore.signal()
            case .failure(_):
                isSuccess = false
                semaphore.signal()
            }
        }

        semaphore.wait()

        guard let obtainedDetails = details, isSuccess else {
            throw FailsFetcherError.errorFetchingFailsSummaries
        }

        return obtainedDetails
    }
}
