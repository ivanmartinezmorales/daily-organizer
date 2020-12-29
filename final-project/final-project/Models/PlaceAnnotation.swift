//
//  PlaceAnnotation.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/29/20.
//

import Foundation
import UIKit

import MapKit

final class PlaceAnnotation: NSObject, MKAnnotation {
  let title: String?
  let coordinate: CLLocationCoordinate2D
  
  init(place: Place) {
    self.title = place.name
    self.coordinate = place.coordinate
  }
}

