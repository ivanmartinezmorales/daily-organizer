//
//  Location.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import MapKit
import Foundation
import Combine

class LocationProvider: NSObject, ObservableObject {
  @Published var location: CLLocation? = nil
  private let locationProvider = CLLocationManager()

  override init() {
    super.init()
    self.locationProvider.delegate = self
    self.locationProvider.desiredAccuracy = kCLLocationAccuracyBest
    self.locationProvider.distanceFilter = kCLDistanceFilterNone
    self.locationProvider.requestWhenInUseAuthorization()
    self.locationProvider.startUpdatingLocation()
  }
}

extension LocationProvider: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    print(status)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else {
      return
    }
    self.location = location
  }
}


func GetLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(location)
        }
    }
