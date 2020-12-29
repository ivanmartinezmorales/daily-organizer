//
//  Place.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/29/20.
//

import Foundation
import MapKit

struct Place {
  let place: MKPlacemark
  
  var id: UUID {
    return UUID()
  }
  
  var name: String {
    self.place.name ?? ""
  }
  
  var title: String {
    self.place.title ?? ""
  }
  
  var coordinate: CLLocationCoordinate2D {
    self.place.coordinate
  }
  
}

