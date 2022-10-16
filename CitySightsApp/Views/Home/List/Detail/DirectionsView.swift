//
//  DirectionsView.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 12.10.22.
//

import SwiftUI

struct DirectionsView: View {
    
    var business: Business
    
    var body: some View {
        
        // Business Title
        VStack(alignment: .leading){
            
            HStack{
                BusinessTitle(business: business)
                Spacer()
                
                if let lat = business.coordinates?.latitude,
                   let long = business.coordinates?.longitude,
                   let name = business.name{
                    Link("Open in Maps", destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!)
                }
            }.padding()
            
            
            // Directions map
            DirectionsMap(business: business)
        }.ignoresSafeArea()
    }
}
//
//struct DirectionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsView()
//    }
//}

/*
 What should you do when you want to use special characters (apostrophes, spaces, etc.) in a URL link?
 Methods like addingPercentEncoding encode characters such as spaces and apostrophes, which cannot be directly used in URLs.
 
 How should you calculate directions from two points when using MapKit?
 MKDirections has a calculate method, which makes it easy to calculate a route
 */
