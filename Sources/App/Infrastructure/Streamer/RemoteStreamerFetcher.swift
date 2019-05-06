//
//  RemoteStreamerFetcher.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import Alamofire

final class RemoteStreamerFetcher: StreamerFetcher {
    private let streamerEndpoint = "https://livestreamfails.com/streamer/"

    private let streamersEndpoint = "https://livestreamfails.com/load/loadStreamers.php?loadStreamerPage=0&loadStreamerOrder=amount"

    private lazy var parser = StreamerHTMLParser()

    func fetchStreamerDetails(name: String) throws -> Streamer {
        guard let url = URL(string: "\(self.streamerEndpoint)\(name)") else {
            throw StreamerFetcherError.errorFetchingStreamerDetails
        }

        var isSuccess = false

        let semaphore = DispatchSemaphore(value: 0)

        var streamer: Streamer?

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseString { response in
            switch response.result {
            case let .success(html):
                do {
                    streamer = try self.parser.parseToStreamerDetails(name, html)

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

        guard let obtainedStreamer = streamer, isSuccess else {
            throw StreamerFetcherError.errorFetchingStreamerDetails
        }

        return obtainedStreamer
    }

    func fetchStreamers() throws -> [Streamer] {
        guard let url = URL(string: self.streamersEndpoint) else {
            throw StreamerFetcherError.errorFetchingStreamers
        }

        var isSuccess = false

        let semaphore = DispatchSemaphore(value: 0)

        var streamers: [Streamer] = []

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseString { response in
            switch response.result {
            case let .success(html):
                do {
                    streamers = try self.parser.parseToStreamers(html)

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

        guard isSuccess else {
            throw StreamerFetcherError.errorFetchingStreamers
        }

        return streamers
    }
}
