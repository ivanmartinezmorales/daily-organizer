//
//  ContentView.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import SwiftUI

struct ContentView: View {
    // MARK: Add some state
    var body: some View {
        NavigationView {
            HomeView()
                .navigationBarTitle("Do It!")
                
                // Add new task
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
