//
//  HomeCardView.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import SwiftUI

struct CardView: View {
    var title: String
    var subTitle: String
    var imageTitle: String?
    
    var body: some View {
        VStack {
            HStack {
                if imageTitle != nil {
                    Image(systemName: imageTitle!)
                        .resizable()
                        .frame(maxWidth: 50, maxHeight: 50, alignment: .center)
                        .padding()
                        .accentColor(Color(UIColor.black))
                    Divider()
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text(self.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(UIColor.black))
                    Text(self.subTitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
