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
}
