//
//  BusinessMap.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 16.09.22.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable{
    
    @EnvironmentObject var  model: ContentModel
    
    var locations: [MKPointAnnotation]{
        
        var annotations = [MKPointAnnotation]()
        
        // Create a set of annotations from our list of business
        for business in model.restaurants + model.sights{
            
            // if the business has a lat/long, create an MKPointAnnotation for it
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude{
                
                // Create a new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                annotations.append(a)
            }
        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        // Make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        // Set the region
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        
        // Add annotations - updateuiview is going to call several times as the data changes.  we dont want to add our annotations over and over again.it will add perpetually more and more annotations. so we need to make sure we remove all annotations and then add the ones base on  the business
        
        // Remove annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add annotation the ones based on the business
        //uiView.addAnnotations(self.locations)
        uiView.showAnnotations(self.locations, animated: true) // zoom effect
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        // if we dont need mapview anymore
        uiView.removeAnnotations(uiView.annotations)
    }
}
