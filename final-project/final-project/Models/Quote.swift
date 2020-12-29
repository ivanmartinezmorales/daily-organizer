//
//  Quote.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/29/20.
//

import Foundation

class Quote: Codable {
    let success: Success
    let contents: Contents
    let baseurl: String
    let copyright: Copyright

    init(success: Success, contents: Contents, baseurl: String, copyright: Copyright) {
        self.success = success
        self.contents = contents
        self.baseurl = baseurl
        self.copyright = copyright
    }
}

class Contents: Codable {
    let quotes: [QuoteElement]

    init(quotes: [QuoteElement]) {
        self.quotes = quotes
    }
}

class QuoteElement: Codable {
    let quote, length, author: String
    let tags: [String]
    let category, language, date: String
    let permalink: String
    let id: String
    let background: String
    let title: String

    init(quote: String, length: String, author: String, tags: [String], category: String, language: String, date: String, permalink: String, id: String, background: String, title: String) {
        self.quote = quote
        self.length = length
        self.author = author
        self.tags = tags
        self.category = category
        self.language = language
        self.date = date
        self.permalink = permalink
        self.id = id
        self.background = background
        self.title = title
    }
}

class Copyright: Codable {
    let year: Int
    let url: String

    init(year: Int, url: String) {
        self.year = year
        self.url = url
    }
}

class Success: Codable {
    let total: Int

    init(total: Int) {
        self.total = total
    }
}
