//
//  FailsHTMLParser.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 21/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import SwiftSoup

final class FailsHTMLParser {
    func parseToSummaries(_ html: String) throws -> [FailSummary] {
        var summaries: [FailSummary] = []

        do {
            let doc: Document = try SwiftSoup.parse(html)

            let failCards = try doc.select("div.post-card");

            for failCard in failCards {
                try summaries.append(self.extractFailSummary(from: failCard))
            }
        } catch {
            throw FailsHTMLParserError.errorParsingFailSummary
        }

        return summaries
    }

    func parseToDetails(_ html: String, _ failIDValue: String) throws -> FailDetails {
        do {
            let doc: Document = try SwiftSoup.parse(html)

            guard let videoURLPath = try doc.select("video > source").first()?.attr("src") else {
                throw FailsHTMLParserError.errorParsingFailDetails
            }

            guard let videoURL = URL(string: videoURLPath) else {
                throw FailsHTMLParserError.errorParsingFailDetails
            }

            return FailDetails(failID: FailID(value: failIDValue),
                               videoURL: videoURL)
        } catch {
            throw FailsHTMLParserError.errorParsingFailDetails
        }
    }

    private func extractFailSummary(from failCard: Element) throws -> FailSummary {
        let failIDValue = try self.extractFailID(from: failCard)
        let description = try self.extractDescription(from: failCard)
        let streamerName = try self.extractStreamerName(from: failCard)
        let gameName = try self.extractGameName(from: failCard)
        let thumbnailUrl = try self.extractThumbnailUrl(from: failCard)

        return FailSummary(failID: FailID(value: failIDValue),
                           streamerName: streamerName,
                           gameName: gameName,
                           description: description,
                           thumbnailURL: thumbnailUrl)
    }

    private func extractDescription(from failCard: Element) throws -> String? {
        guard let title = try failCard.select("p.title") .first() else {
            return nil
        }

        return try title.text()
    }

    private func extractFailID(from failCard: Element) throws -> String {
        let failIDSubstring =
            try failCard.select("a[href]")
                .first()?
                .attr("href")
                .split(separator: "/")
                .last

        return String(failIDSubstring!)
    }

    private func extractStreamerName(from failCard: Element) throws -> String? {
        guard let linkElements = try self.extractLinksFromStreamerElement(from: failCard) else {
            return nil
        }

        if linkElements.isEmpty() {
            return nil
        }

        let streamerName = try linkElements.get(0).text()

        return streamerName
    }

    private func extractGameName(from failCard: Element) throws -> String? {
        guard let linkElements = try self.extractLinksFromStreamerElement(from: failCard) else {
            return nil
        }

        if linkElements.isEmpty() || linkElements.size() < 2  {
            return nil
        }

        let gameName = try linkElements.get(1).text()

        return gameName
    }

    private func extractLinksFromStreamerElement(from failCard: Element) throws -> Elements? {
        guard let streamerElement = try self.extractStreamerElement(from: failCard) else {
            return nil
        }

        return try streamerElement.select("a[href]")
    }

    private func extractStreamerElement(from failCard: Element) throws -> Element? {
        return try failCard.select("div.stream-info > small.text-muted").first()
    }

    private func extractThumbnailUrl(from failCard: Element) throws -> URL? {
        let thumbnailUrlPath = try failCard.select("img.card-img-top").attr("src")

        return URL(string: thumbnailUrlPath)
    }
}
