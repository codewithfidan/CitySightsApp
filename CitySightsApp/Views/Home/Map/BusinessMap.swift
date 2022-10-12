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
    @Binding var selectedBusiness: Business? // 2 way binding to this property to read and write value to this property
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
        mapView.delegate = context.coordinator
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
    
    // MARK: - Coordinator class
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        
        var map: BusinessMap
        
        init(map: BusinessMap){
            
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // if the annotation is the user blue dot(current location), return nil
            if annotation is MKUserLocation{
                return nil
            }
            
            // Check if there is a reusable annotation view first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
            
            if annotationView == nil{ // we could not get a reusable one
                
                // create a new one
                // Create an annotation view
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
                
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }else{
                
                // We got a reusable one
                annotationView!.annotation = annotation
            }
            
            // return it
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            // User tapped on the annotation view
            
            
            // Get the business object that this business object
            // Loop through in the businesses in the model and find a match
            for business in map.model.restaurants + map.model.sights {
                
                if business.name == view.annotation?.title{
                    map.selectedBusiness = business
                    return
                }
            }
            
            
            //set the selectedBusiness property to that business object
        }
    }
}
/*
 
 How do you add annotations to a MKMapView?
 Annotations can be directly added using MKPointAnnotation and specifying coordinates
 
 How does the protocol delegate pattern help handle events for a MapView?
 The protocol delegate pattern is a commonly used pattern when working with UIKit, although less often in SwiftUI. We can call methods in the delegate to run when an event is detected, and the delegate can also be notified when an event occurs.


 */
