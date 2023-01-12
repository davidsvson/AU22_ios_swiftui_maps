//
//  ContentView.swift
//  MapApp
//
//  Created by David Svensson on 2023-01-10.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var locationManager = LocationManager()
        
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3323341, longitude: -122.0312186), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    @State var places = [
        Place(name: "nice place", latitude: 37.3323341, longitude: -122.032),
        Place(name: "food", latitude: 37.3323341, longitude: -122.030),
        Place(name: "nice food", latitude: 37.3323341, longitude: -122.029),
    ]
    
        
    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                interactionModes: [.all],
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: places) { place in
                //MapPin(coordinate: place.coordinate)
                // MapMarker(coordinate: place.coordinate)
                MapAnnotation(coordinate: place.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    MapPinView(place: place)
                }
                
            }
            Button(action: {
                addPin()
            }) {
                Text("Add pin")
            }
            Button(action: {
                locationManager.startLocationUpdates()
            }) {
                Text("Start updates")
            }
        }
    }
    
    func addPin() {
       // let newPlace = Place(name: "New Place", latitude: 37.3323341, longitude: -122.027)
        
        if let location = locationManager.location {
            let newPlace = Place(name: "here",
                                 latitude: location.latitude,
                                 longitude: location.longitude)
            
            places.append(newPlace)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}










//    let p1 = Person()
//    let p2 = p1.changeName("david")
//    p2.changeAge(33)
//
//    Person().changeName("David").changeAge(33)
//
//
//    struct Person {
//        var name = ""
//        var age = 0
//
//        func changeName(_ newName : String ) -> Person {
//            let p = Person(name: newName, age: age)
//
//            return p
//        }
//
//        func changeAge(_ newAge : Int) -> Person {
//            return Person(name: name , age: newAge)
//        }
//
//
//    }

struct MapPinView: View {
    var place : Place
    
    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .resizable()
                .frame(width: 30, height: 30)
            Text(place.name)
        }
    }
}
