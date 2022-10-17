//
//  LocationDeniedView.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 16.10.22.
//

import SwiftUI

struct LocationDeniedView: View {
    
    private let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        
        VStack(spacing: 20){
            Spacer()
            Text("Whoops!")
                .bold()
                .font(.title)
            Text("We need to access your location to provide you with the best sights in the city. You can change your desicion at any time in Settings.")
            Spacer()
            Button {
                // Open Settings
                if let url = URL(string: UIApplication.openSettingsURLString){
                    if UIApplication.shared.canOpenURL(url){
                        // if we can open this settings url, then open it
                        
                        UIApplication.shared.open(url, options:  [:], completionHandler: nil)
                    }
                }
                
            } label: {
                ZStack{
                    Rectangle()
                        .frame(height: 48)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                        .padding()
                }
                
                    
            }

        }
        .padding()
        .foregroundColor(.white)
        .background(backgroundColor)
        .multilineTextAlignment(.center)
        .ignoresSafeArea()
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
/*
 How can you get the URL for the Settings app?
 Make sure to check whether if UIApplication.shared.canOpenURL(url) is true, and then you can run UIApplication.shared.open(.....)
 */
