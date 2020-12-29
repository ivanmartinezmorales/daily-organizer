//
//  HomeView.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import SwiftUI

struct HomeView : View {

    var body: some View {
        VStack {
            CardView(title: getTodaysDate(), subTitle: "Today")
                .padding(.top)
            Spacer()
            Text("Seize the day ✨")
                .font(.title)
                .bold()
                .padding()
            Section {
                NavigationLink(destination: TaskView()) {
                    CardView(title: "Tasks", subTitle: "See your tasks", imageTitle: "list.bullet.rectangle")
                }
                NavigationLink(destination: QuoteView()) {
                    CardView(title: "Daily Quote", subTitle: "See an inspriational quote of the day", imageTitle: "books.vertical.fill")
                }
                NavigationLink(destination: MainMapView()) {
                    CardView(title: "Location", subTitle: "See places nearby", imageTitle: "map.fill")
                }
            }
            Spacer()
        }
    }
    
    // Gets today's date and returns in the following format: Day_of_the_week, Month date
    // Example: Saturday, Nov 28
    func getTodaysDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM-dd")
        let datetime = formatter.string(from: Date())
        return datetime
    }
}

