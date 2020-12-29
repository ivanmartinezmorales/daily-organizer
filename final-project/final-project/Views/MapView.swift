//
//  MapView.swift
//  lab-6-swiftui
//
//

import SwiftUI
import MapKit
import Foundation

class Coordinator: NSObject, MKMapViewDelegate {
  var control: MapView

  init(_ control: MapView) {
    self.control = control
  }

  func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
    if let annotationView = views.first {
      if let annotation = annotationView.annotation {
        if annotation is MKUserLocation {
          let region = MKCoordinateRegion(center: annotation.coordinate,  latitudinalMeters: 1000, longitudinalMeters: 1000)
          mapView.setRegion(region, animated: true)
        } else {
        }
      }
    }
  }
}

struct MapView: UIViewRepresentable {
  let places: [Place]
  let viewType: MKMapType
  @State var isFirstTime: Bool = true
  
  func makeUIView(context: Context) -> MKMapView {
    
    let map = MKMapView()
    map.showsUserLocation = true
    map.delegate = context.coordinator
    map.mapType = viewType
    
    return map
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    updateAnnotations(from: uiView)
    uiView.mapType = self.viewType
  }

  private func updateAnnotations(from mapView: MKMapView) {
      mapView.removeAnnotations(mapView.annotations)
      let annotations = self.places.map(PlaceAnnotation.init)
      mapView.addAnnotations(annotations)
  }
}

struct MainMapView: View {
  @ObservedObject var locationProvider = LocationProvider()
  @State private var places: [Place] = [Place]()
  @State private var searchValue: String = ""
  @State private var pickerValue: MKMapType = MKMapType.standard
  @State private var tapped: Bool = false
  
  private func getNearByLandmarks() {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = self.searchValue
    
    let searchRequest = MKLocalSearch(request: request)
    searchRequest.start { (response, error) in
      if let response = response {
        let mapItems = response.mapItems
        self.places = mapItems.map {
          Place(place: $0.placemark)
        }
      }
    }
  }
  
  private func calculateOffset() -> CGFloat {
    if self.places.count > 0 && !self.tapped {
      return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 2
    } else if self.tapped {
      return 80
    } else {
      return UIScreen.main.bounds.size.height
    }
  }
  
  var body: some View {
    VStack {
      Picker(selection: $pickerValue, label: Text("Map type")) {
        Text("Standard").tag(MKMapType.standard)
        Text("Hybrid").tag(MKMapType.hybrid)
        Text("Satellite").tag(MKMapType.satellite)
      }.pickerStyle(SegmentedPickerStyle())
      .padding()
      
      ZStack(alignment: .top) {
        
        MapView(places: self.places, viewType: self.pickerValue)
        
        TextField("Search", text: $searchValue, onEditingChanged: { _ in })
        {
          self.getNearByLandmarks()
        }.textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .offset(y: 80)
        
        PlaceView(places: self.places) {
          self.tapped.toggle()
        }.animation(.spring())
        .offset(y: calculateOffset())
        .navigationBarTitle("Find Places Nearby")
        
      }
    }
  }
}

struct PlaceView: View {
  
  let places: [Place]
  var onTap: () -> ()
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        EmptyView()
      }.frame(width: UIScreen.main.bounds.size.width,
              height: 50)
      .background(Color.gray)
      .gesture(TapGesture()
                .onEnded(self.onTap)
      )
      
      List {
        ForEach(self.places, id: \.id) { place in
          VStack(alignment: .leading) {
            Text(place.name)
              .fontWeight(.bold)
            Text(place.title)
          }
        }
        
      }.animation(nil)
      
    }.cornerRadius(10)
  }
}

