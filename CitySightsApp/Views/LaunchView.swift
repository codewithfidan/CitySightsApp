//
//  ContentView.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 08.09.22.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Detect the authorization status of geolocating the user
        
        if model.authorizationState == .notDetermined{
            // if undetermined, show onboarding
            
            
        }else if model.authorizationState == .authorizedWhenInUse ||
                    model.authorizationState == .authorizedAlways{
            // if approved, show HomeView
            HomeView()
            
        }else {
            
            // if denied, show DeniedView
        }
        
        
        
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
