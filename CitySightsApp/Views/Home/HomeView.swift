//
//  HomeView.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 14.09.22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        
        
        if model.restaurants.count != 0 || model.sights.count != 0{
            
            NavigationView{
                // Determine if we should show list or map
                if !isMapShowing{
                    // show list
                    
                    VStack{
                        HStack{
                            Image(systemName: "mappin")
                            Text("San Francisco")
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Switch to the map view")
                            }
                        }
                        Divider()
                        BusinessList()
                    }
                    .padding()
                    .navigationBarHidden(true)
                    
                }else{
                    // show map
                }
            }
            
            
        }else{
            // after the user has authorized us to locate them, we actually have to wait for the geolocation to work and for us to get the location update. we have to pass latitude longitude into yelp api and wait for the response to come back
            // Still waiting for data so show spinner
            ProgressView()
            //ProgressView is good to use as a placeholder while data is being returned for a view.
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
