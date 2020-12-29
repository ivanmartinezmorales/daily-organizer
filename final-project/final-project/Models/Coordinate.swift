//
//  Coordinate.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "\(self.latitude), \(self.longitude)"
    }
    
    static var Phoenix: Coordinate {
        return Coordinate(latitude: 33.45, longitude: -112.07)
    }
}
