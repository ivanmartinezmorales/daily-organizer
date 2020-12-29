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
    // On initialization it looks like this:
    @State var quote = "--"
    @State var author = "--"

    var body: some View {
            // This is where we're going to get the weather from
        Image("inspirational")
            .padding()
            
        // Today's quote
        CardView(title: self.quote, subTitle: self.author)
            
        CardView(title: "Source", subTitle: "They Said So Quotes API")
        // MARK: Navigation stuff
        .navigationBarTitle("Today's Daily Quote 📚")
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


