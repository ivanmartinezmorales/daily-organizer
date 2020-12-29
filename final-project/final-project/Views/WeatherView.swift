//
//  WeatherView.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import SwiftUI
import Foundation

struct QuoteView: View {
    fileprivate let ApiKey = "HclNqtxmjblcYDcqR3SMVQeF"
    @State var quote = "--"
    @State var author = "--"

    var body: some View {
            // This is where we're going to get the weather from
            
        // Today's quote
        CardView(title: self.quote, subTitle: self.author)
        // MARK: Navigation stuff
        .navigationBarTitle("Today's quote")
            .onAppear {
                getQuote()
            }
    }
    
    
    // Fetches the daily quote
    private func getQuote() {
        var request = URLRequest(url: URL(string: "https://quotes.rest/qod?language=en")!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(ApiKey, forHTTPHeaderField: "X-TheySaidSo-Api-Secret")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(Quote.self, from: data!)
                self.quote = responseModel.contents.quotes.first!.quote
                self.author = responseModel.contents.quotes.first!.author
                
            } catch {
                print("Serialization Error")
            }
            
        }).resume()
    }
}


// MARK: - Quote
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

// MARK: - Contents
class Contents: Codable {
    let quotes: [QuoteElement]

    init(quotes: [QuoteElement]) {
        self.quotes = quotes
    }
}

// MARK: - QuoteElement
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

// MARK: - Copyright
class Copyright: Codable {
    let year: Int
    let url: String

    init(year: Int, url: String) {
        self.year = year
        self.url = url
    }
}

// MARK: - Success
class Success: Codable {
    let total: Int

    init(total: Int) {
        self.total = total
    }
}
