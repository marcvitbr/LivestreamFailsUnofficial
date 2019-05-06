//
//  StreamerHTMLParser.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import SwiftSoup

final class StreamerHTMLParser {
    func parseToStreamerDetails(_ name: String, _ html: String) throws -> Streamer {
        do {
            let doc: Document = try SwiftSoup.parse(html)

            guard let profilePictureURLPath = try doc.select("img[alt='\(name)']").first()?.attr("src") else {
                throw StreamerHTMLParserError.errorParsingStreamerDetails
            }

            guard let profilePictureURL = URL(string: profilePictureURLPath) else {
                throw StreamerHTMLParserError.errorParsingStreamerDetails
            }

            return Streamer(name: name, profilePictureURL: profilePictureURL)
        } catch {
            throw StreamerHTMLParserError.errorParsingStreamerDetails
        }
    }

    func parseToStreamers(_ html: String) throws -> [Streamer] {
        var streamers: [Streamer] = []

        do {
            let doc: Document = try SwiftSoup.parse(html)

            let cards = try doc.select("div.card.mb-2.post-card")

            for item in cards {
                guard let profilePictureUrlPath = try item.select("img").first()?.attr("src") else {
                    continue
                }

                guard let profilePictureUrl = URL(string: profilePictureUrlPath) else {
                    continue
                }

                let name = try item.select("p.card-text.title").text()

                streamers.append(Streamer(name: name, profilePictureURL: profilePictureUrl))
            }
        } catch {
            throw StreamerHTMLParserError.errorParsingStreamerDetails
        }

        return streamers
    }
}
